//
//  ImageShowViewController.h
//  ObjectiveC
//
//  Created by zhangchunpeng1 on 2021/7/8.
//  Copyright © 2021 张春鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageShowViewController : UIViewController

@property (nonatomic, strong) UIImage *image;           ///< image
@property (nonatomic, assign) CGRect showBounds;           ///< rect

@end

NS_ASSUME_NONNULL_END
