//
//  AlignmentViewController.m
//  ObjectiveC
//
//  Created by ext.zhangchunp1 on 2023/10/31.
//  Copyright © 2023 张春鹏. All rights reserved.
//

#import "AlignmentViewController.h"

#import "YYTTTAttributedLabel.h"

@interface AlignmentViewController ()

@end

@implementation AlignmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentJustified;
    NSMutableDictionary *attributed = @{NSFontAttributeName: [UIFont systemFontOfSize:18], NSForegroundColorAttributeName: [UIColor redColor], NSBaselineOffsetAttributeName: [NSNumber numberWithFloat:0], NSParagraphStyleAttributeName: style}.mutableCopy;

// , NSUnderlineStyleAttributeName: [NSNumber numberWithInt:NSUnderlineStyleNone]
    
//    NSString * text = @"et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla paria";
//    NSString * text = @"et dolore mna aliqu";
    NSString * text = @"中国";
    
    CGSize size = [text boundingRectWithSize:CGSizeMake(200, 100) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributed context:nil].size;
    
    
//    [attributed setObject:[NSNumber numberWithFloat:((200.0 - (size.width))/(text.length - 0))] forKey:NSKernAttributeName];
    NSMutableAttributedString *at = [[NSMutableAttributedString alloc] initWithString:text attributes:attributed];
    [at addAttribute:NSKernAttributeName value:[NSNumber numberWithFloat:((200.0 - (size.width))/(text.length - 1))] range:NSMakeRange(0, text.length - 1)];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 200, 100)];
    [self.view addSubview:label];
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor grayColor];
    
    
    
    label.attributedText = at;
    
    
    
    YYTTTAttributedLabel *l2 = [[YYTTTAttributedLabel alloc] initWithFrame: CGRectMake(50, 350, 200, 100)];
    l2.backgroundColor = [UIColor grayColor];
    l2.textAlignment = NSTextAlignmentJustified;
//    l2.text = text;
    l2.attributedText = at;
    [self.view addSubview:l2];
    
    
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
