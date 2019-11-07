//
//  TableViewSelectedCellController.m
//  ObjectiveC
//
//  Created by 张春鹏 on 2018/11/26.
//  Copyright © 2018 张春鹏. All rights reserved.
//

#import "TableViewSelectedCellController.h"

@interface JDMultipleSelectionCell : UITableViewCell


@end

@implementation JDMultipleSelectionCell

- (void)layoutSubviews {
    for (UIControl *control in self.subviews) {
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews) {
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img=(UIImageView *)v;
                    if (self.selected) {
                        img.image=[UIImage imageNamed:@"common_marked"];
                    } else {
                        img.image=[UIImage imageNamed:@"common_unmark"];
                    }
                    break;
                }
            }
        }
    }
    [super layoutSubviews];
}


//适配第一次图片为空的情况
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews) {
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img=(UIImageView *)v;
                    if (self.selected) {
                        img.image=[UIImage imageNamed:@"common_marked"];
                    } else {
                        img.image=[UIImage imageNamed:@"common_unmark"];
                    }
                    break;
                }
            }
        }
    }
    
}

@end

@interface TableViewSelectedCellController ()

@property (nonatomic, strong) NSMutableArray<NSString *> *dataSources;           ///<

@end

@implementation TableViewSelectedCellController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSources = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        [_dataSources addObject:[@(i) stringValue]];
    }
    [self.tableView registerClass:JDMultipleSelectionCell.self forCellReuseIdentifier:@"UITableViewCell"];
    self.tableView.editing = true;
    self.tableView.allowsMultipleSelectionDuringEditing = true;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JDMultipleSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
//    cell.textLabel.text = _dataSources[indexPath.row];
//    cell.editingAccessoryType = UITableViewCellAccessoryCheckmark;
    cell.textLabel.text = @"dequeueReusableCellWithIdentifierdequeueReusableCellWithIdentifier";
    return cell;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return false;
}


@end
