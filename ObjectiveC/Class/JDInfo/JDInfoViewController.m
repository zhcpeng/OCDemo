//
//  JDInfoViewController.m
//  ObjectiveC
//
//  Created by zhangchunpeng1 on 2021/9/15.
//  Copyright © 2021 张春鹏. All rights reserved.
//

#import "JDInfoViewController.h"

//#import <JDBBaseInfoModule/JDBBaseInfoModule-umbrella.h>
#import <JDBBaseInfoModule/JDBDeviceInfo.h>
#import <JDBBaseInfoModule/JDBNetInfo.h>

#import <objc/runtime.h>
//#import <objc/message.h>

@interface JDInfoViewController ()

@end

@implementation JDInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [JDBDeviceInfo refreshInfo];
//    NSString *did = [JDBDeviceInfo getOpenUDID];
//    NSLog(@"%@",did);
//    return;
    
    
    
//    IMP imp = [NSClassFromString(@"UIScreen") methodForSelector:NSSelectorFromString(@"mainScreen")];
//    UIScreen *(*function)(id, SEL) = (void *)imp;
//    UIScreen *screen = function(NSClassFromString(@"UIScreen"), NSSelectorFromString(@"mainScreen"));
//    CGFloat scale = screen.scale;
//    NSLog(@"%.2f", scale);
    
    
    
//    NSDictionary *dict = [JDBNetInfo getIPAddressesInfo];
//    NSLog(@"%@", dict);
//
//    NSLog(@"%@", [JDBDeviceInfo  getIP]);
//    
//    return;;

    NSString *className = @"JDBDeviceInfo";
    unsigned int count = 0;
    Class metaClass = object_getClass(NSClassFromString(className));
    Method *methods = class_copyMethodList(metaClass, &count);
    Class clazz = NSClassFromString(className);
    for (NSInteger i = 1; i < count; i++) {
        Method method = methods[i];
        SEL name = method_getName(method);
        IMP imp = [clazz methodForSelector:name];
        /// *** SEL如果不带返回值，此处使用id会报错，要用void *** 非常重要
        id (*function)(id, SEL) = (void *)imp;
        id result = function(clazz, name);
        NSLog(@"%@: %@", NSStringFromSelector(name), result);
    }
    free(methods);//释放

}


@end
