//
//  ScrollHeaderViewController.m
//  ObjectiveC
//
//  Created by 张春鹏 on 2018/9/17.
//  Copyright © 2018年 张春鹏. All rights reserved.
//

#import "ScrollHeaderViewController.h"

@interface ScrollHeaderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;           /// <#Desprition#>
@property (nonatomic, strong) UIImageView *imageView;           /// <#Desprition#>

@end

@implementation ScrollHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:UITableViewCell.self forCellReuseIdentifier:@"UITableViewCell"];
    _tableView.rowHeight = 50;
    
    _imageView = [[UIImageView alloc] init];
    _imageView.image = [UIImage imageNamed:@"timg.jpeg"];
    _imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = true;
    
    UIView *header = [[UIView alloc] init];
    header.frame = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    [header addSubview:_imageView];
    _tableView.tableHeaderView = header;
    
    [self.view addSubview:_tableView];
    _tableView.frame = self.view.bounds;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        UIViewController *vc = NSClassFromString(@"TransitionViewController").new;
        
        UIViewController *temp = [[UIViewController alloc] init];
        temp.view.backgroundColor = [UIColor greenColor];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:temp];
        nav.modalPresentationStyle = 0;

        [self presentViewController:nav animated:true completion:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIViewController *vc = NSClassFromString(@"TransitionViewController").new;
            vc.modalPresentationStyle = 0;
            [temp presentViewController:vc animated:true completion:nil];
        });
        
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = @"1111";
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        CGRect frame = _imageView.frame;
        frame.origin.y = scrollView.contentOffset.y;
        frame.size.height = 200 - scrollView.contentOffset.y;
        _imageView.frame = frame;
    }
}

@end
