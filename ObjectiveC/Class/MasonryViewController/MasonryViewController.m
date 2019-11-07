//
//  MasonryViewController.m
//  ObjectiveC
//
//  Created by zhcpeng on 2019/3/5.
//  Copyright © 2019 张春鹏. All rights reserved.
//

#import "MasonryViewController.h"
#import "UIView+Extension.h"
#import <Masonry.h>

@interface MasonryViewController ()

@end

@implementation MasonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view).insets(UIEdgeInsetsMake(100, 20, 0, 20));
        make.height.equalTo(@(200));
    }];
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor redColor];
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor greenColor];
    
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor redColor];
    
    [contentView addSubviews:@[view1,view2,view3]];
    [@[view1,view2,view3] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(contentView).insets(UIEdgeInsetsMake(20, 0, 20, 0));
    }];
    [@[view1,view2,view3] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:40 tailSpacing:40];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
