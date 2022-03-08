//
//  SKTouchFaceIDViewController.m
//  ObjectiveC
//
//  Created by zhcpeng on 2020/9/7.
//  Copyright © 2020 张春鹏. All rights reserved.
//

#import "SKTouchFaceIDViewController.h"

#import "SKTouchFaceIDManager.h"
#import "SAMKeychain.h"

@interface SKTouchFaceIDViewController ()

@end

@implementation SKTouchFaceIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"开启验证" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(50, 100, 200, 50);
    [self.view addSubview:button];
    
    
    NSString *pw = [SAMKeychain passwordForService:@"stock" account:@"111"];
    if (pw) {
        NSLog(@"%@", pw);
    } else {
        [SAMKeychain setPassword:@"011" forService:@"stock" account:@"111"];
    }
    
}

- (void)buttonAction {
    short type = [SKTouchFaceIDManager.share supportType];
    if (type == 2) {
        // face
        [SKTouchFaceIDManager.share authenticationWithBiometrics:^(BOOL success, NSError *error) {
            NSLog(@"%d, %@", success, error.domain);
        }];
    } else if (type == 1) {
        // touch
        [SKTouchFaceIDManager.share authenticationWithBiometrics:^(BOOL success, NSError *error) {
            NSLog(@"%d, %@", success, error.domain);
        }];
    } else {
        NSLog(@"不支持");
    }
}



@end
