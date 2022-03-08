//
//  ExchangeIMPViewController.m
//  ObjectiveC
//
//  Created by zhangchunpeng1 on 2021/7/6.
//  Copyright © 2021 张春鹏. All rights reserved.
//

#import "ExchangeIMPViewController.h"

#import <objc/runtime.h>

@implementation ExchangeIMPBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"ExchangeIMPBaseViewControllers");
}

@end

@interface ExchangeIMPViewController ()

@end

@implementation ExchangeIMPViewController

//+ (void)load {
//    NSLog(@"%@", NSStringFromSelector(_cmd));
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"ExchangeIMPViewController");
}


@end


@interface ExchangeIMPViewController (AAAA)

- (void)aaaa_viewDidLoad;

@end

@implementation ExchangeIMPViewController (AAAA)

//+ (void)load {
//    NSLog(@"%@:aaaa:%@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
//
//    Method originalMethod = class_getInstanceMethod(self, @selector(viewDidLoad));
//    Method swizzledMethod = class_getInstanceMethod(self, @selector(aaaa_viewDidLoad));
//    method_exchangeImplementations(originalMethod, swizzledMethod);
//}

- (void)aaaa_viewDidLoad {
    [self aaaa_viewDidLoad];
    
    NSLog(@"%@:aaaa:%@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
    
}

@end




@interface ExchangeIMPViewController (BBBB)
@end

@implementation ExchangeIMPViewController (BBBB)

//+ (void)load {
//    NSLog(@"%@:bbbb:%@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
//
//    Method originalMethod = class_getInstanceMethod(self, @selector(viewDidLoad));
//    Method swizzledMethod = class_getInstanceMethod(self, @selector(bbbb_viewDidLoad));
//    method_exchangeImplementations(originalMethod, swizzledMethod);
//}

- (void)bbbb_viewDidLoad {
    [self bbbb_viewDidLoad];

    NSLog(@"%@:bbbb:%@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));

}

@end




@interface ExchangeIMPViewController (CCCC)
@end

@implementation ExchangeIMPViewController (CCCC)

//+ (void)load {
//    NSLog(@"%@:cccc:%@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
//
//    Method originalMethod = class_getInstanceMethod(self, @selector(viewDidLoad));
//    Method swizzledMethod = class_getInstanceMethod(self, @selector(cccc_viewDidLoad));
//    method_exchangeImplementations(originalMethod, swizzledMethod);
//}

- (void)cccc_viewDidLoad {
    [self cccc_viewDidLoad];

    NSLog(@"%@:cccc:%@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));

}

@end
