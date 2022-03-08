//
//  UICollectionViewCenterItemViewController.m
//  ObjectiveC
//
//  Created by zhcpeng on 2019/12/5.
//  Copyright © 2019 张春鹏. All rights reserved.
//

#import "UICollectionViewCenterItemViewController.h"

#import "Masonry.h"

#import "SDTopListHeaderCollectionFlowLayout.h"

@interface UICollectionViewCenterItemViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;           ///< cv
//@property (nonatomic, strong) <#Type#> *<#name#>;           ///< <#Desprition#>

@property (nonatomic, assign) NSInteger number;           ///< n

@end

@implementation UICollectionViewCenterItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    SDTopListHeaderCollectionFlowLayout *flowLayout = [[SDTopListHeaderCollectionFlowLayout alloc] init];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
//    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.itemSize = CGSizeMake(100, 80);
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:UICollectionViewCell.self forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.height.equalTo(@(100));
    }];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    _number = 3;
    CGFloat itemTotalWidth = 100 * _number;
    if (itemTotalWidth < width) {
        _collectionView.contentInset = UIEdgeInsetsMake(0, (width - itemTotalWidth) / 2, 0, 0);
    }
    
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _number;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
//    item.backgroundColor = [UIColor redColor];
    item.backgroundColor = [UIColor colorWithRed:(arc4random() % 255 / 255.0) green:(arc4random() % 255 / 255.0) blue:(arc4random() % 255 / 255.0) alpha:1];
    return item;
}



@end
