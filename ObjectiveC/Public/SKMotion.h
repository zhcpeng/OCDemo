//
//  SKMotion.h
//  STKSecurityBoxSDK
//
//  Created by zhangchunpeng1 on 2021/9/6.
//

#import <Foundation/Foundation.h>


@interface SKMotion : NSObject

@property (nonatomic, assign) NSInteger direction;           ///< direction

- (void)start;

- (void)stop;

@end

