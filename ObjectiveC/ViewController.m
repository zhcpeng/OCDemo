//
//  ViewController.m
//  ObjectiveC
//
//  Created by 张春鹏 on 2018/9/7.
//  Copyright © 2018年 张春鹏. All rights reserved.
//

#import "ViewController.h"

#define CurrentSystemVersion ([[UIDevice currentDevice].systemVersion doubleValue])

#define isIOS11Hegher ([[UIDevice currentDevice].systemVersion doubleValue] >= 11.0 ? 1 : 0)

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>{
    
}

@property (nonatomic, strong) UITableView *tableView;           /// <#Desprition#>
@property (nonatomic, strong) NSMutableArray<NSString *> *dataSources;           /// <#Desprition#>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSources = [NSMutableArray array];
    [_dataSources addObject:@"ScrollHeaderViewController"];
    [_dataSources addObject:@"MenuViewController"];
    [_dataSources addObject:@"SearchContentViewController"];
    [_dataSources addObject:@"TableViewSelectedCellController"];
    [_dataSources addObject:@"TextLabelViewController"];
    [_dataSources addObject:@"MasonryViewController"];
    [_dataSources addObject:@"DataFormatterViewController"];
//    [_dataSources addObject:@""];
    
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:UITableViewCell.self forCellReuseIdentifier:@"UITableViewCell"];
    _tableView.rowHeight = 50;
    
    [self.view addSubview:_tableView];
    _tableView.frame = self.view.bounds;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = _dataSources[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    Class vc = NSClassFromString(_dataSources[indexPath.row]);
    [self.navigationController pushViewController:[[vc alloc] init] animated:true];
}


@end
