//
//  SearchContentViewController.m
//  ObjectiveC
//
//  Created by 张春鹏 on 2018/10/30.
//  Copyright © 2018 张春鹏. All rights reserved.
//

#import "SearchContentViewController.h"
#import "Masonry.h"

@interface SearchContentViewController ()<UISearchControllerDelegate,UISearchBarDelegate, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UISearchController *searchController;           ///< search
@property (nonatomic, strong) UITableView *tableView;           ///< tab
@property (nonatomic, strong) NSMutableArray *dataSources;           ///< data
@property (nonatomic, strong) UIScrollView *scrollView;           ///< scroll

@end

@implementation SearchContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataSources = [NSMutableArray array];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:UITableViewCell.self forCellReuseIdentifier:@"UITableViewCell"];
//    [self.view addSubview:_tableView];
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.delegate = self;
    _searchController.searchBar.delegate = self;
    _searchController.searchResultsUpdater = self;
    [_searchController.searchBar sizeToFit];
//    [self.view addSubview:_searchController.searchBar];
//    _searchController.searchBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
    
    
//    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:_scrollView];
//    _scrollView.contentSize = self.view.bounds.size;
//    [_scrollView addSubview:_searchController.searchBar];
    //    _searchController.searchBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 50);
    [self.view addSubview:_searchController.searchBar];
    [_searchController.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(88);
    }];
//    _tableView.tableHeaderView = _searchController.searchBar;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = [@(indexPath.row) stringValue];
    return cell;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.navigationController pushViewController:[[UIViewController alloc] init] animated:true];
//    SearchDetailVC *vc = [[SearchDetailVC alloc]initWithNibName:@"SearchDetailVC" bundle:nil];
//    [self.navigationController pushViewController:vc animated:YES];
    //    self.searchController.active = NO;
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    for (id obj in [searchBar subviews]) {
        if ([obj isKindOfClass:[UIView class]]) {
            for (id obj2 in [obj subviews]) {
                if ([obj2 isKindOfClass:[UIButton class]]) {
                    UIButton *btn = (UIButton *)obj2;
                    [btn setTitle:@"取消" forState:UIControlStateNormal];
                }
            }
        }
    }
    return YES;
}


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}


@end
