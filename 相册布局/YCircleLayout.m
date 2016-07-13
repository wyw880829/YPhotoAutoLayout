//
//  YCircleLayout.m
//  相册布局
//
//  Created by wyw on 16/7/13.
//  Copyright © 2016年 Style_Y. All rights reserved.
//

#import "YCircleLayout.h"

@interface YCircleLayout()

/** 布局数组 */
@property (nonatomic, strong) NSMutableArray *attrsArray;

@end

@implementation YCircleLayout

- (NSMutableArray *)attrsArray
{
    if (_attrsArray == nil) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    [self.attrsArray removeAllObjects];
    // 当前区item数量
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attr];
    }
    return self.attrsArray;
}

/**
 *  返回当前位置的UICollectionViewLayoutAttributes属性
 *
 *  @param indexPath 当前位置
 *
 *  @return UICollectionViewLayoutAttributes
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 当前区item数量
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    // 半径
    CGFloat randius = 150;
    
    // collectionView的中心点
    CGFloat centerX = self.collectionView.frame.size.width * 0.5;
    CGFloat centerY = self.collectionView.frame.size.height * 0.5;
    
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    // 设置布局尺寸
    attr.size = CGSizeMake(70, 70);

    // 当前item中心点和collectionView的中心点的角度
    CGFloat angle = (2*M_PI / count) * indexPath.item;
    
    if (count == 1) {
        attr.center = CGPointMake(centerX, centerY);
    } else {
        // 当前item的中心点
        CGFloat itemCenterX = centerX + randius*sin(angle);
        CGFloat itemCenterY = centerY + randius*cos(angle);
        attr.center = CGPointMake(itemCenterX, itemCenterY);
    }

    return attr;
}


@end
