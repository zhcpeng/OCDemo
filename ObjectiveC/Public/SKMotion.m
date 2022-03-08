//
//  SKMotion.m
//  STKSecurityBoxSDK
//
//  Created by zhangchunpeng1 on 2021/9/6.
//

#import "SKMotion.h"
#import <CoreMotion/CoreMotion.h>

@interface SKMotion ()

@property (nonatomic, strong) CMMotionManager *motionManager;           ///< manager

@end


static const float sensitive = 0.77;

@implementation SKMotion

- (void)deviceMotion: (CMDeviceMotion *)motion {
    double x = motion.gravity.x;
    double y = motion.gravity.y;
    double z = motion.gravity.z;
    
    if (y < 0) {
        if (fabs(y) > sensitive) {
            _direction = 1;
        }
    } else {
        if (y > sensitive) {
            _direction = 2;
        }
    }
    if (x < 0) {
        if (fabs(x) > sensitive) {
            _direction = 3;
        }
    } else {
        if (x > sensitive) {
            _direction = 4;
        }
    }
    NSLog(@"%ld", _direction);
}

- (void)start {
    if (self.motionManager.deviceMotionAvailable) {
        [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
            [self performSelectorOnMainThread:@selector(deviceMotion:) withObject:motion waitUntilDone:true];
        }];
    }
}

- (void)stop {
    [_motionManager stopDeviceMotionUpdates];
}

- (CMMotionManager *)motionManager {
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.deviceMotionUpdateInterval = 0.5;
    }
    return _motionManager;
}

@end
