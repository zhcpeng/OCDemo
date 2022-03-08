//
//  SDTopListHeaderCollectionFlowLayout.m
//  StockDetail
//
//  Created by zhcpeng on 2019/12/5.
//  Copyright © 2019 JD. All rights reserved.
//

#import "SDTopListHeaderCollectionFlowLayout.h"

@interface SDTopListHeaderCollectionFlowLayout ()

@property (nonatomic, assign) CGFloat sumCellWidth;           ///< sumCellWidth

@end

@implementation SDTopListHeaderCollectionFlowLayout

// MARK: - Life Cycle
// - (instancetype)init {
//    self = [super init];
//    if (self) {
//
//    }
//    return self;
// }

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *layoutAttributes_t = [super layoutAttributesForElementsInRect:rect];
    NSArray *layoutAttributes = [[NSArray alloc] initWithArray:layoutAttributes_t copyItems:YES];
    // 用来临时存放一行的Cell数组
    NSMutableArray *layoutAttributesTemp = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < layoutAttributes.count; index++) {
        UICollectionViewLayoutAttributes *currentAttr = layoutAttributes[index]; // 当前cell的位置信息
        UICollectionViewLayoutAttributes *previousAttr = index == 0 ? nil : layoutAttributes[index - 1]; // 上一个cell 的位置信
        UICollectionViewLayoutAttributes *nextAttr = index + 1 == layoutAttributes.count ?
            nil : layoutAttributes[index + 1];//下一个cell 位置信息

        // 加入临时数组
        [layoutAttributesTemp addObject:currentAttr];
        _sumCellWidth += currentAttr.frame.size.width;

        CGFloat previousY = previousAttr == nil ? 0 : CGRectGetMaxY(previousAttr.frame);
        CGFloat currentY = CGRectGetMaxY(currentAttr.frame);
        CGFloat nextY = nextAttr == nil ? 0 : CGRectGetMaxY(nextAttr.frame);
        // 如果当前cell是单独一行
        if (currentY != previousY && currentY != nextY) {
            if ([currentAttr.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
                [layoutAttributesTemp removeAllObjects];
                _sumCellWidth = 0.0;
            } else if ([currentAttr.representedElementKind isEqualToString:UICollectionElementKindSectionFooter]) {
                [layoutAttributesTemp removeAllObjects];
                _sumCellWidth = 0.0;
            } else {
                [self setCellFrameWith:layoutAttributesTemp];
            }
        }
        // 如果下一个cell在本行，这开始调整Frame位置
        else if (currentY != nextY) {
            [self setCellFrameWith:layoutAttributesTemp];
        }
    }
    return layoutAttributes;
}

- (void)setCellFrameWith:(NSMutableArray *)layoutAttributes {
    CGFloat nowWidth = self.collectionView.frame.size.width - _sumCellWidth;
    for (UICollectionViewLayoutAttributes *attributes in layoutAttributes) {
        CGRect nowFrame = attributes.frame;
        nowFrame.origin.x = nowWidth;
        attributes.frame = nowFrame;
        nowWidth += nowFrame.size.width;
    }
    _sumCellWidth = 0.0;
    [layoutAttributes removeAllObjects];
}

@end
