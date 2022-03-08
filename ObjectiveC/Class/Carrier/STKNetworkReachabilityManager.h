
#import <Foundation/Foundation.h>

#if !TARGET_OS_WATCH
#import <SystemConfiguration/SystemConfiguration.h>

typedef NS_ENUM(NSInteger, STKNetworkReachabilityStatus) {
    STKNetworkReachabilityStatusUnknown          = -1,
    STKNetworkReachabilityStatusNotReachable     = 0,
    STKNetworkReachabilityStatusReachableViaWWAN = 1,
    STKNetworkReachabilityStatusReachableViaWiFi = 2,
    STKNetworkReachabilityStatusReachableViaWWAN2G = 3,
    STKNetworkReachabilityStatusReachableViaWWAN3G = 4,
    STKNetworkReachabilityStatusReachableViaWWAN4G = 5,
    STKNetworkReachabilityStatusReachableViaWWAN5G = 6,
};

NS_ASSUME_NONNULL_BEGIN

@interface STKNetworkReachabilityManager : NSObject

/**
 The current network reachability status.
 */
@property (readonly, nonatomic, assign) STKNetworkReachabilityStatus networkReachabilityStatus;

/**
 Whether or not the network is currently reachable.
 */
@property (readonly, nonatomic, assign, getter = isReachable) BOOL reachable;

/**
 Whether or not the network is currently reachable via WWAN.
 */
@property (readonly, nonatomic, assign, getter = isReachableViaWWAN) BOOL reachableViaWWAN;

/**
 Whether or not the network is currently reachable via WiFi.
 */
@property (readonly, nonatomic, assign, getter = isReachableViaWiFi) BOOL reachableViaWiFi;

///---------------------
/// @name Initialization
///---------------------

/**
 Returns the shared network reachability manager.
 */
+ (instancetype)sharedManager;

/**
 Creates and returns a network reachability manager with the default socket address.
 
 @return An initialized network reachability manager, actively monitoring the default socket address.
 */
+ (instancetype)manager;

/**
 Creates and returns a network reachability manager for the specified domain.

 @param domain The domain used to evaluate network reachability.

 @return An initialized network reachability manager, actively monitoring the specified domain.
 */
+ (instancetype)managerForDomain:(NSString *)domain;

/**
 Creates and returns a network reachability manager for the socket address.

 @param address The socket address (`sockaddr_in6`) used to evaluate network reachability.

 @return An initialized network reachability manager, actively monitoring the specified socket address.
 */
+ (instancetype)managerForAddress:(const void *)address;

/**
 Initializes an instance of a network reachability manager from the specified reachability object.

 @param reachability The reachability object to monitor.

 @return An initialized network reachability manager, actively monitoring the specified reachability.
 */
- (instancetype)initWithReachability:(SCNetworkReachabilityRef)reachability NS_DESIGNATED_INITIALIZER;

/**
 *  Initializes an instance of a network reachability manager
 *
 *  @return nil as this method is unavailable
 */
- (nullable instancetype)init NS_UNAVAILABLE;

///--------------------------------------------------
/// @name Starting & Stopping Reachability Monitoring
///--------------------------------------------------

/**
 Starts monitoring for changes in network reachability status.
 */
- (void)startMonitoring;

/**
 Stops monitoring for changes in network reachability status.
 */
- (void)stopMonitoring;

///-------------------------------------------------
/// @name Getting Localized Reachability Description
///-------------------------------------------------

/**
 Returns a localized string representation of the current network reachability status.
 */
- (NSString *)localizedNetworkReachabilityStatusString;

///---------------------------------------------------
/// @name Setting Network Reachability Change Callback
///---------------------------------------------------

/**
 Sets a callback to be executed when the network availability of the `baseURL` host changes.

 @param block A block object to be executed when the network availability of the `baseURL` host changes.. This block has no return value and takes a single argument which represents the various reachability states from the device to the `baseURL`.
 */
- (void)setReachabilityStatusChangeBlock:(nullable void (^)(STKNetworkReachabilityStatus status))block;

@end


FOUNDATION_EXPORT NSString * const STKNetworkingReachabilityDidChangeNotification;
FOUNDATION_EXPORT NSString * const STKNetworkingReachabilityNotificationStatusItem;

FOUNDATION_EXPORT NSString * STKStringFromNetworkReachabilityStatus(STKNetworkReachabilityStatus status);

NS_ASSUME_NONNULL_END
#endif
