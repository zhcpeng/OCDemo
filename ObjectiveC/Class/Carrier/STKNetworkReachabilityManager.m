
#import "STKNetworkReachabilityManager.h"
#if !TARGET_OS_WATCH

#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>

//import "Reachability.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
//#import "Reachability.h"
//#include <sys/param.h>
//#include <sys/mount.h>
#endif



NSString * const STKNetworkingReachabilityDidChangeNotification = @"STKNetworkingReachabilityDidChangeNotification";
NSString * const STKNetworkingReachabilityNotificationStatusItem = @"STKNetworkingReachabilityNotificationStatusItem";

typedef void (^STKNetworkReachabilityStatusBlock)(STKNetworkReachabilityStatus status);

NSString * STKStringFromNetworkReachabilityStatus(STKNetworkReachabilityStatus status) {
    switch (status) {
        case STKNetworkReachabilityStatusNotReachable:
            return NSLocalizedStringFromTable(@"Not Reachable", @"STKNetworking", nil);
        case STKNetworkReachabilityStatusReachableViaWWAN:
            return NSLocalizedStringFromTable(@"Reachable via WWAN", @"STKNetworking", nil);
        case STKNetworkReachabilityStatusReachableViaWiFi:
            return NSLocalizedStringFromTable(@"Reachable via WiFi", @"STKNetworking", nil);
        case STKNetworkReachabilityStatusUnknown:
        default:
            return NSLocalizedStringFromTable(@"Unknown", @"STKNetworking", nil);
    }
}

static STKNetworkReachabilityStatus STKNetworkReachabilityStatusForFlags(SCNetworkReachabilityFlags flags) {
    BOOL isReachable = ((flags & kSCNetworkReachabilityFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkReachabilityFlagsConnectionRequired) != 0);
    BOOL canConnectionAutomatically = (((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) || ((flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0));
    BOOL canConnectWithoutUserInteraction = (canConnectionAutomatically && (flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0);
    BOOL isNetworkReachable = (isReachable && (!needsConnection || canConnectWithoutUserInteraction));

    STKNetworkReachabilityStatus status = STKNetworkReachabilityStatusUnknown;
    if (isNetworkReachable == NO) {
        status = STKNetworkReachabilityStatusNotReachable;
    }
#if	TARGET_OS_IPHONE
    else if ((flags & kSCNetworkReachabilityFlagsIsWWAN) != 0) {
        status = STKNetworkReachabilityStatusReachableViaWWAN;
        
        NSArray *typeStrings2G = @[CTRadioAccessTechnologyEdge,
                                        CTRadioAccessTechnologyGPRS,
                                          CTRadioAccessTechnologyCDMA1x];
        NSArray *typeStrings3G = @[CTRadioAccessTechnologyHSDPA,
                                       CTRadioAccessTechnologyWCDMA,
                                       CTRadioAccessTechnologyHSUPA,
                                       CTRadioAccessTechnologyCDMAEVDORev0,
                                       CTRadioAccessTechnologyCDMAEVDORevA,
                                       CTRadioAccessTechnologyCDMAEVDORevB,
                                       CTRadioAccessTechnologyeHRPD];
        NSArray *typeStrings4G = @[CTRadioAccessTechnologyLTE];
        
        CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
        if (@available(iOS 12.0, *)) {
            NSDictionary *carrier = info.serviceCurrentRadioAccessTechnology;
            
            NSArray *types = [carrier allValues];
            NSString *type1 = types.firstObject;
            if ([typeStrings4G containsObject:type1]) {
                status = STKNetworkReachabilityStatusReachableViaWWAN4G;
            } else if ([typeStrings3G containsObject:type1]) {
                status = STKNetworkReachabilityStatusReachableViaWWAN3G;
            } else if ([typeStrings2G containsObject:type1]) {
                status = STKNetworkReachabilityStatusReachableViaWWAN2G;
            }
            if (@available(iOS 14.0, *)) {
                if ([@[CTRadioAccessTechnologyNRNSA, CTRadioAccessTechnologyNR] containsObject:type1]) {
                    status = STKNetworkReachabilityStatusReachableViaWWAN5G;
                }
            }
        } else {
            NSString *currentStatus = info.currentRadioAccessTechnology;
            if ([typeStrings4G containsObject:currentStatus]) {
                status = STKNetworkReachabilityStatusReachableViaWWAN4G;
            } else if ([typeStrings3G containsObject:currentStatus]) {
                status = STKNetworkReachabilityStatusReachableViaWWAN3G;
            } else if ([typeStrings2G containsObject:currentStatus]) {
                status = STKNetworkReachabilityStatusReachableViaWWAN2G;
            }
        }
    }
#endif
    else {
        status = STKNetworkReachabilityStatusReachableViaWiFi;
    }

    return status;
}

/**
 * Queue a status change notification for the main thread.
 *
 * This is done to ensure that the notifications are received in the same order
 * as they are sent. If notifications are sent directly, it is possible that
 * a queued notification (for an earlier status condition) is processed after
 * the later update, resulting in the listener being left in the wrong state.
 */
static void STKPostReachabilityStatusChange(SCNetworkReachabilityFlags flags, STKNetworkReachabilityStatusBlock block) {
    STKNetworkReachabilityStatus status = STKNetworkReachabilityStatusForFlags(flags);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (block) {
            block(status);
        }
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        NSDictionary *userInfo = @{ STKNetworkingReachabilityNotificationStatusItem: @(status) };
        [notificationCenter postNotificationName:STKNetworkingReachabilityDidChangeNotification object:nil userInfo:userInfo];
    });
}

static void STKNetworkReachabilityCallback(SCNetworkReachabilityRef __unused target, SCNetworkReachabilityFlags flags, void *info) {
    STKPostReachabilityStatusChange(flags, (__bridge STKNetworkReachabilityStatusBlock)info);
}


static const void * STKNetworkReachabilityRetainCallback(const void *info) {
    return Block_copy(info);
}

static void STKNetworkReachabilityReleaseCallback(const void *info) {
    if (info) {
        Block_release(info);
    }
}

@interface STKNetworkReachabilityManager ()
@property (readonly, nonatomic, assign) SCNetworkReachabilityRef networkReachability;
@property (readwrite, nonatomic, assign) STKNetworkReachabilityStatus networkReachabilityStatus;
@property (readwrite, nonatomic, copy) STKNetworkReachabilityStatusBlock networkReachabilityStatusBlock;
@end

@implementation STKNetworkReachabilityManager

+ (instancetype)sharedManager {
    static STKNetworkReachabilityManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [self manager];
    });

    return _sharedManager;
}

+ (instancetype)managerForDomain:(NSString *)domain {
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, [domain UTF8String]);

    STKNetworkReachabilityManager *manager = [[self alloc] initWithReachability:reachability];
    
    CFRelease(reachability);

    return manager;
}

+ (instancetype)managerForAddress:(const void *)address {
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *)address);
    STKNetworkReachabilityManager *manager = [[self alloc] initWithReachability:reachability];

    CFRelease(reachability);
    
    return manager;
}

+ (instancetype)manager
{
#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= 90000) || (defined(__MAC_OS_X_VERSION_MIN_REQUIRED) && __MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
    struct sockaddr_in6 address;
    bzero(&address, sizeof(address));
    address.sin6_len = sizeof(address);
    address.sin6_family = AF_INET6;
#else
    struct sockaddr_in address;
    bzero(&address, sizeof(address));
    address.sin_len = sizeof(address);
    address.sin_family = AF_INET;
#endif
    return [self managerForAddress:&address];
}

- (instancetype)initWithReachability:(SCNetworkReachabilityRef)reachability {
    self = [super init];
    if (!self) {
        return nil;
    }

    _networkReachability = CFRetain(reachability);
    self.networkReachabilityStatus = STKNetworkReachabilityStatusUnknown;

    return self;
}

- (instancetype)init NS_UNAVAILABLE
{
    return nil;
}

- (void)dealloc {
    [self stopMonitoring];
    
    if (_networkReachability != NULL) {
        CFRelease(_networkReachability);
    }
}

#pragma mark -

- (BOOL)isReachable {
    return [self isReachableViaWWAN] || [self isReachableViaWiFi];
}

- (BOOL)isReachableViaWWAN {
    return self.networkReachabilityStatus == STKNetworkReachabilityStatusReachableViaWWAN;
}

- (BOOL)isReachableViaWiFi {
    return self.networkReachabilityStatus == STKNetworkReachabilityStatusReachableViaWiFi;
}

#pragma mark -

- (void)startMonitoring {
    [self stopMonitoring];

    if (!self.networkReachability) {
        return;
    }

    __weak __typeof(self)weakSelf = self;
    STKNetworkReachabilityStatusBlock callback = ^(STKNetworkReachabilityStatus status) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;

        strongSelf.networkReachabilityStatus = status;
        if (strongSelf.networkReachabilityStatusBlock) {
            strongSelf.networkReachabilityStatusBlock(status);
        }

    };

    SCNetworkReachabilityContext context = {0, (__bridge void *)callback, STKNetworkReachabilityRetainCallback, STKNetworkReachabilityReleaseCallback, NULL};
    SCNetworkReachabilitySetCallback(self.networkReachability, STKNetworkReachabilityCallback, &context);
    SCNetworkReachabilityScheduleWithRunLoop(self.networkReachability, CFRunLoopGetMain(), kCFRunLoopCommonModes);

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(self.networkReachability, &flags)) {
            STKPostReachabilityStatusChange(flags, callback);
        }
    });
}

- (void)stopMonitoring {
    if (!self.networkReachability) {
        return;
    }

    SCNetworkReachabilityUnscheduleFromRunLoop(self.networkReachability, CFRunLoopGetMain(), kCFRunLoopCommonModes);
}

#pragma mark -

- (NSString *)localizedNetworkReachabilityStatusString {
    return STKStringFromNetworkReachabilityStatus(self.networkReachabilityStatus);
}

#pragma mark -

- (void)setReachabilityStatusChangeBlock:(void (^)(STKNetworkReachabilityStatus status))block {
    self.networkReachabilityStatusBlock = block;
}

#pragma mark - NSKeyValueObserving

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    if ([key isEqualToString:@"reachable"] || [key isEqualToString:@"reachableViaWWAN"] || [key isEqualToString:@"reachableViaWiFi"]) {
        return [NSSet setWithObject:@"networkReachabilityStatus"];
    }

    return [super keyPathsForValuesAffectingValueForKey:key];
}

- (NSString *)net {
    NSString *netconnType = @"";
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    if (@available(iOS 12.0, *)) {
        
    } else {
        
        NSString *currentStatus = info.currentRadioAccessTechnology;
        if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {
            netconnType = @"GPRS"; }
        else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) { netconnType = @"2.75G EDGE"; }
        else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){ netconnType = @"3G"; }
        else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){ netconnType = @"3.5G HSDPA"; }
        else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){ netconnType = @"3.5G HSUPA"; }
        else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){ netconnType = @"2G"; }
        else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){ netconnType = @"3G"; }
        else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){ netconnType = @"3G"; }
        else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){ netconnType = @"3G"; }
        else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){ netconnType = @"HRPD"; }
        else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){ netconnType = @"4G"; }
    }

           
        
    return netconnType;
}

@end

#endif
