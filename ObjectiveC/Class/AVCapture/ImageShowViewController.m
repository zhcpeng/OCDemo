//
//  ImageShowViewController.m
//  ObjectiveC
//
//  Created by zhangchunpeng1 on 2021/7/8.
//  Copyright © 2021 张春鹏. All rights reserved.
//

#import "ImageShowViewController.h"

#define SelfWidth CGRectGetWidth(UIScreen.mainScreen.bounds)
#define SelfHeight CGRectGetHeight(UIScreen.mainScreen.bounds)

@interface ImageShowViewController ()

@property (nonatomic, strong) UIImageView *imageView;           ///< imageView

@end

@implementation ImageShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
    
    
//    CALayer *Mylayer=[CALayer layer];
//    Mylayer.bounds= _showBounds;
//    Mylayer.position=CGPointMake(SelfWidth/2, (SelfHeight - CGRectGetHeight(_showBounds))/2);
////    Mylayer.position=CGPointMake(SelfWidth/2, (SelfHeight - 120)/2);
////    Mylayer.position = CGPointMake(CGRectGetWidth(_showBounds) / 2, CGRectGetHeight(_showBounds) / 2);
//    Mylayer.masksToBounds=YES;
//    Mylayer.borderWidth=1;
//    Mylayer.borderColor=[UIColor whiteColor].CGColor;
//    [self.view.layer addSublayer:Mylayer];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:false animated:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    _imageView.image = _image;
}


@end
