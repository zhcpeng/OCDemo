//
//  UIStackViewController.m
//  ObjectiveC
//
//  Created by zhcpeng on 2019/11/7.
//  Copyright © 2019 张春鹏. All rights reserved.
//

#import "UIStackViewController.h"
#import "Masonry.h"

@interface UIStackViewController ()

@end

@implementation UIStackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UILayoutGuide
    NSMutableArray *views = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < 10; i++) {
        UIImageView *v = [[UIImageView alloc] init];
        v.image = [UIImage imageNamed:@"common_marked"];
//        v.backgroundColor = [UIColor greenColor];
        [views addObject:v];
    }
    
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:views];
    stackView.backgroundColor = [UIColor redColor];
    
    stackView.spacing = 10;
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.distribution = UIStackViewDistributionFill;
    
    [self.view addSubview:stackView];
    
    
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}


@end
