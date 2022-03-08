//
//  JDBaseInfoManager.h
//  JDBBaseInfoModule
//
//  Created by Leven on 2021/7/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDBaseInfoManager : NSObject

@property (nonatomic,assign)BOOL isAgreeUserRightPolicy;
@property(nonatomic, copy) NSString *wifiBSSID;
@property(nonatomic, copy) NSString *wifiSSID;

+ (instancetype)shareManager;

// set,get内部用线程保证同步
- (void)setBssidStatus:(BOOL)status;

- (BOOL)getBssidStatus;

- (NSString *)getWifiBSSIDInfo; //wifibssid

- (NSString *)getwifiSSIDInfo; //

- (void)setWifiBssidInfo:(NSString *)bssid;

+ (void)refreshWIFIBSSID;

@end

NS_ASSUME_NONNULL_END
