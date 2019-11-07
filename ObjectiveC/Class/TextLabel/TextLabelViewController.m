//
//  TextLabelViewController.m
//  ObjectiveC
//
//  Created by 张春鹏 on 2018/12/3.
//  Copyright © 2018 张春鹏. All rights reserved.
//

#import "TextLabelViewController.h"
//#import "YYText.h"
#import "NSAttributedString+JKAdditions.h"

@interface TextLabelViewController ()

@property (nonatomic, strong) UILabel *label;           ///< label

@end

@implementation TextLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _label = [[UILabel alloc] init];
    _label.numberOfLines = 0;
    _label.preferredMaxLayoutWidth = 280;
    _label.backgroundColor = [UIColor redColor];
    _label.frame = CGRectMake(20, 100, 280, 200);
    [self.view addSubview:_label];
    
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentJustified;
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    NSMutableAttributedString *temp = [[NSMutableAttributedString alloc] initWithString:@"每一天都要自己做啊每个用8京东股票的人健康快乐幸\n|||有一天偶遇佛祖aaaa，说可以个愿望 aaaaaaaaaaaaaaa 我说：那让每个用京东股票的人健康快乐幸福每一天都要自己做啊每个用京东股票的人健康快乐幸福每一天都要自己做啊每个用京东股票的人健康快乐幸福每一天都要自己做啊每个用京东股票的人健康快乐幸福每一天都要自己做啊每个用京东股票的人健康快乐幸福每一天都要自己做啊" attributes:@{NSParagraphStyleAttributeName:style, NSFontAttributeName: [UIFont systemFontOfSize:12]}];
//    NSMutableAttributedString *temp = [[NSMutableAttributedString alloc] initWithString:@"有一天偶遇佛祖aa，遇遇佛祖说：我可以给一个愿望aaaaa 我说：那让每个用京东股票的人健康快乐幸福每一天都要自己做啊" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]}];
    
    
//    NSDictionary *attributes = [temp attributesAtIndex:0 effectiveRange:nil];
//    if ([attributes.allKeys containsObject:NSParagraphStyleAttributeName]) {
//        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
//        [style setParagraphStyle:[attributes objectForKey:NSParagraphStyleAttributeName]];
//        style.alignment = NSTextAlignmentJustified;
//        style.lineBreakMode = NSLineBreakByTruncatingTail;
//
//
//    } else {
//        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
//        style.alignment = NSTextAlignmentJustified;
//        style.lineBreakMode = NSLineBreakByTruncatingTail;
//
//    }
    
    
//    NSLog(@"%@",temp);
    
    
    _label.attributedText = temp;
    
}



@end
