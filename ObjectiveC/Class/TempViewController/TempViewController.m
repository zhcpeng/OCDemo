//
//  TempViewController.m
//  ObjectiveC
//
//  Created by zhcpeng on 2019/12/23.
//  Copyright © 2019 张春鹏. All rights reserved.
//

#import "TempViewController.h"
#import "SKFancyChartManager.h"

#import "UIGestureRecognizer+Extension.h"
#import "UIButton+Utilities.h"

#import <objc/runtime.h>

#import <Masonry.h>

@interface TempView : UIView

@property (nonatomic, strong) NSString *name;           ///<
- (void)print;

@end

@interface TempClass : UIView

@property (nonatomic, strong) NSString *name;           ///<
- (void)print;

@end

//@interface Person: NSObject
//@end
//@implementation Person
//@end
//
//@interface Person (Test1)
//@property (nonatomic, strong) NSString *name;
//
//+ (instancetype)initWithName: (NSString *)name;
//@end
//
//@implementation Person (Test1)
//- (void)setName:(NSString *)name {
//    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//- (NSString *)name {
//    return objc_getAssociatedObject(self, _cmd);
//}
//+ (instancetype)initWithName: (NSString *)name {
//    Person *p = [[Person alloc] init];
//    p.name = name;
//    NSLog(@"%@", p.name);
//    NSLog(@"%@", objc_getAssociatedObject(p, @selector(name)));
//    return p;
//}
//@end


@interface TempViewController ()

@end

@implementation TempViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSArray *data = @[@(2), @(3), @(4), @(5), @(6), @(7)];
    // 0 2 4 6 8 10
    
//    NSArray *data = @[@(20), @(30), @(40), @(50), @(60), @(70)];
    // 0 12 28 42 56 70
    
//    NSArray *data = @[@(250), @(380), @(440), @(580), @(670), @(470)];
    // 0 140 280 420 560 700
    
//    NSArray *data = @[@(250), @(380), @(440), @(580), @(670), @(770)];
    // 0 160 320 480 640 800
    
//    NSArray *data = @[@(2), @(3), @(11), @(10), @(6), @(7)];
    // 0 3 6 9 12 15
    
//    NSArray *data = @[@(2000), @(3300), @(4000), @(5000), @(6000), @(6200)];
    // 0 1300 2600 3900 5200 6500
    
//    NSArray *data = @[@(-2), @(-3), @(-4), @(-5), @(-6), @(-7)];
    // -10 -8 -6 -4 -2 0
    
//    NSArray *data = @[@(-2), @(3), @(-4), @(5), @(6), @(7)];
    // -6 -3 0 3 6 9
    
//    NSArray *data = @[@(250), @(380), @(440), @(-580), @(670), @(770)];
    // -810 -540 -270 0 270 540 810
    
//    NSArray *data = @[@(-2000), @(3300), @(4000), @(5000), @(6000), @(6200)];
    // -3200 -1600 0 1600 3200 4800 6400
    
//    NSArray *data = @[@(2), @(3), @(11), @(10), @(-6), @(7)];
//    -8 -4 0 4 8 12
    
//    NSArray *data = @[@(-2), @(-3), @(-4), @(-5), @(-6), @(-7)];
    // -10 -8 -6 -4 -2 0
    
//    NSArray *data = @[@(-2), @(-3), @(-4), @(-5), @(-6), @(-9)];
    // -10 -8 -6 -4 -2 0
    
//    NSArray *data = @[@(-2), @(-3), @(4), @(-5), @(-6), @(-9)];
    // -9 -6 -3 0 3 6
    
//    NSArray *data = @[@(30), @(13), @(11), @(34), @(68), @(23)];
    // 0 14 28 42 56 70
    
//    NSArray *data = @[@(300000), @(540000), @(11000), @(34000), @(6800), @(23)];
    
//    NSArray *result = [SKFancyChartManager calculateYScale:data];
    
//    NSLog(result);
    
//    NSLog(@"%@", result.firstObject);
//    void;
    
    
    
    
//
//    NSCalendar *calendar = [NSCalendar currentCalendar];
////    [NSTimeZone resetSystemTimeZone];
//    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
//    [calendar setTimeZone:timeZone];
//    NSDate *firstDay;
//    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&firstDay interval:nil forDate:[NSDate date]];
//    NSDateComponents *lastDateComponents = [calendar components:NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitDay fromDate:firstDay];
//    NSUInteger dayNumberOfMonth = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]].length;
//    NSInteger day = [lastDateComponents day];
//    [lastDateComponents setDay:day+dayNumberOfMonth-1];
//    NSDate *lastDay = [calendar dateFromComponents:lastDateComponents];
//
//    NSLog(@"%@", firstDay);
//    NSLog(@"%@", lastDay);
    
    
    
    //
//    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//    formatter.numberStyle = NSNumberFormatterDecimalStyle;
//    formatter.maximumFractionDigits = 2;
//    formatter.roundingMode = NSNumberFormatterRoundHalfUp;
//    NSString *string = [formatter stringFromNumber:[NSNumber numberWithDouble:51189.12111]];
//    NSLog(@"Formatted number string:%@",string);
    
    
    // 快捷手势
//    UIGestureRecognizer *gest = [UIGestureRecognizer jdsk_initWithBlcok:^{
//        NSLog(@"1111");
//    }];
////    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] init];
////    gest.actionBlock = ^{
////        NSLog(@"22222");
////    };
//    [self.view addGestureRecognizer:gest];

    
    
    // 添加属性
//    Person *p = [[Person alloc] init];
//    p.name = @"111111";
//    NSLog(@"%@", p.name);
//
//    Person *p2 = [Person initWithName:@"222"];
//    NSLog(@"%@", p2.name);
    
    
    // button block extendInset
//    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn1.backgroundColor = [UIColor redColor];
//    btn1.jdsk_touchExtendInset = UIEdgeInsetsMake(-50, -50, -50, -50);
//    btn1.frame = CGRectMake(50, 100, 100, 50);
//    [self.view addSubview:btn1];
//    btn1.buttonActionBlock = ^{
//        NSLog(@"22222222222222");
//    };
    
    
    
    
//    NSNumber *n1 = [NSNumber numberWithBool:true];
//    NSNumber *n2 = @(true);
//    NSNumber *n3 = @(1);
//    NSNumber *n4 = [NSNumber numberWithChar:'a'];
//    NSNumber *n5 = [NSNumber numberWithFloat:10.01];
    
    
    
    
//    UIViewController *vc1 = [[UIViewController alloc] init];
//    vc1.view.backgroundColor = [UIColor redColor];
//    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc1];
//    vc1.navigationController.navigationBar.hidden = true;
////    navi.modalPresentationStyle = UIModalPresentationOverFullScreen;
////    navi.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self presentViewController:navi animated:false completion:nil];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        UIViewController *vc2 = [[UIViewController alloc] init];
//        vc2.view.backgroundColor = [UIColor greenColor];
////        [vc1.navigationController pushViewController:vc2 animated:true];
//        [navi pushViewController:vc2 animated:true];
//    });
    
    
//    TempView *temp = [[TempView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    [self.view addSubview:temp];
    
    
    
//    UIView *tempContent = [[UIView alloc] initWithFrame:CGRectMake(20, 200, 200, 200)];
//    tempContent.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:tempContent];
//
//    UIView *temp = [[UIView alloc] init];
//    temp.backgroundColor = [UIColor redColor];
//    [tempContent addSubview:temp];
//    [temp mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(UIEdgeInsetsMake(20, 20, 20, 20));
//    }];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        tempContent.frame = CGRectMake(50, 300, 300, 300);
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [temp mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.u
//        }];
//    });
    
    
//    NSArray *a1 = @[@"2020/02/01", @"2020/03/02", @"2020/04/05"];
//    NSArray *a2 = @[@"2020/02/01", @"2020/04/02", @"2020/05/05"];
//
//    NSMutableSet *set = [NSMutableSet setWithArray:a1];
//    [set addObjectsFromArray:a2];
//    NSArray *a3 = [set allObjects];
//    NSArray *a4 = [a3 sortedArrayUsingSelector:@selector(compare:)];
//    NSLog(@"%ld", a4.count);
    
    
    
//    id cls = [TempClass class];
//    void *obj = &cls;
//    [(__bridge  id)obj print];
    
    
//    id cls = [TempView class];
//    void *obj = &cls;
//    [(__bridge  id)obj print];
    
    
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    sv.contentSize = CGSizeMake(-20, -20);

//    [sv layoutSubviews];
    
    CGRect frame = sv.frame;
    frame.size = CGSizeMake(-30, -50);
    sv.frame = frame;
    
    
    NSLog(@"%@", NSStringFromCGRect(sv.frame));
    
}



@end


/**
 
 FCTabsCollectionFlowLayout *flowLayout = [[FCTabsCollectionFlowLayout alloc] init];
 [flowLayout setItemSize:CGSizeMake((kSCREEN_WIDTH - kCommonMargin * 2), 0)];
 flowLayout.minimumLineSpacing = kCommonMargin;
 flowLayout.minimumInteritemSpacing = kCommonMargin;
 flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
 flowLayout.sectionInset = UIEdgeInsetsMake(0, kCommonMargin, 0, kCommonMargin);

 _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 46, kSCREEN_WIDTH, 0) collectionViewLayout:flowLayout];
 _collectionView.delegate = self;
 _collectionView.dataSource = self;
 _collectionView.scrollsToTop = false;
 _collectionView.showsVerticalScrollIndicator = false;
 _collectionView.showsHorizontalScrollIndicator = false;
 _collectionView.bounces = false;
 _collectionView.backgroundColor = [UIColor clearColor];
 [_collectionView registerClass:FCTabsCollectionItemView.self forCellWithReuseIdentifier:FCTabsCollectionItemView.jdsk_identifier];
 [self.containerView addSubview:_collectionView];
 
 
 @implementation FCTabsCollectionFlowLayout

 - (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
     CGRect targetRect = CGRectMake(proposedContentOffset.x, 0, CGRectGetWidth(self.collectionView.bounds), CGRectGetHeight(self.collectionView.bounds));
     NSArray<UICollectionViewLayoutAttributes *> *attriArray = [NSArray arrayWithArray:[super layoutAttributesForElementsInRect:targetRect]];
     CGFloat horizontalCenterX = proposedContentOffset.x + CGRectGetWidth(self.collectionView.bounds) * 0.5;
     CGFloat offsetAdjustment = CGFLOAT_MAX;
     for (UICollectionViewLayoutAttributes *layoutAttributes in attriArray) {
         CGFloat itemHorizontalCenterX = layoutAttributes.center.x;
         if (fabs(itemHorizontalCenterX - horizontalCenterX) < fabs(offsetAdjustment)) {
             offsetAdjustment = itemHorizontalCenterX - horizontalCenterX;
         }
     }
     return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
 }

 @end
 */




@implementation TempView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
//    UIGraphicsPushContext(context);
    CGContextSaveGState(context);
    [@"11111" drawAtPoint:CGPointMake(50, 50) withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16], NSForegroundColorAttributeName : [UIColor redColor]}];
//    UIGraphicsPopContext();
    CGContextRestoreGState(context);
}

- (void)print {
    NSLog(@"1111 %@", self.name);
}


@end

@implementation TempClass

- (void)print {
    NSLog(@"1111 %@", self.name);
}

@end
