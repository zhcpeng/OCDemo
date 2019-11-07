//
//  MenuViewController.m
//  ObjectiveC
//
//  Created by 张春鹏 on 2018/9/17.
//  Copyright © 2018年 张春鹏. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSIndexPath *showMenuIndexPath;           /// <#Desprition#>

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:UITableViewCell.self forCellReuseIdentifier:@"UITableViewCell"];
    _tableView.rowHeight = 50;
    [self.view addSubview:_tableView];
    _tableView.frame = self.view.bounds;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    longPressGesture.minimumPressDuration = 0.5;
    [_tableView addGestureRecognizer:longPressGesture];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resignFirstResponder) name:UIMenuControllerWillHideMenuNotification object:nil];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)canBecomeFirstResponder {
    return true;
}
- (BOOL)resignFirstResponder {
    self.showMenuIndexPath = nil;
    return true;
}

- (void)setShowMenuIndexPath:(NSIndexPath *)showMenuIndexPath {
    if (showMenuIndexPath == nil && _showMenuIndexPath) {
        UITableViewCell *cell = [_tableView cellForRowAtIndexPath:_showMenuIndexPath];
        [cell setSelected:false animated:true];
    }
    _showMenuIndexPath = showMenuIndexPath;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    return cell;
}

- (void)longPress: (UILongPressGestureRecognizer *)gest {
    if (gest.state != UIGestureRecognizerStateBegan) {
        return;
    }
    
    CGPoint point = [gest locationInView:_tableView];
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:point];
    UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    cell.selected = true;
    [self becomeFirstResponder];
    UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteActiion)];
    UIMenuItem *topItem = [[UIMenuItem alloc] initWithTitle:@"置顶" action:@selector(topAction)];
    [[UIMenuController sharedMenuController] setMenuItems:@[deleteItem, topItem]];
    CGRect frame = cell.frame;
    frame.origin.y += 15;
    [[UIMenuController sharedMenuController] setTargetRect:frame inView:_tableView];
    [[UIMenuController sharedMenuController] setMenuVisible:true animated:true];
    
    _showMenuIndexPath  = indexPath;
}

- (void)deleteActiion {
    NSLog(@"删除：%ld", _showMenuIndexPath.row);
    self.showMenuIndexPath = nil;
}

- (void)topAction {
    NSLog(@"置顶：%ld", _showMenuIndexPath.row);
    self.showMenuIndexPath = nil;
}

@end
