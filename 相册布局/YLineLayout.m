//
//  YLineLayout.m
//  相册布局
//
//  Created by wyw on 16/7/11.
//  Copyright © 2016年 Style_Y. All rights reserved.
//

#import "YLineLayout.h"

@implementation YLineLayout

- (instancetype)init
{
    if (self == [super init]) {
        
    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    // 左右滑动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置item尺寸
    self.itemSize = CGSizeMake(200, 200);
    // 设置内边距
    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}

/**
 *  当cell的bounds调用时，是否重新调用layoutAttributesForElementsInRect
 *
 *  @param newBounds bounds
 *
 *  @return 
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/**
 UICollectionViewLayoutAttributes *attrs;
 1.一个cell对应一个UICollectionViewLayoutAttributes对象
 2.UICollectionViewLayoutAttributes对象决定了cell的frame
 */
/**
 * 这个方法的返回值是一个数组（数组里面存放着rect范围内所有元素的布局属性）
 * 这个方法的返回值决定了rect范围内所有元素的排布（frame）
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 获取已经布局好的属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // 获取collectionView中心点的X值
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    // 自定义属性
    for (UICollectionViewLayoutAttributes *attrs in array) {
        // 显示的collection和collectionView中线的差值
        CGFloat cha = ABS(attrs.center.x - centerX);
        // 根据间距值计算cell的比例
        CGFloat scale = 1.2 - cha / self.collectionView.frame.size.width;
        // 设置cell的比例
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return array;
}

/**
 * 这个方法的返回值，就决定了collectionView停止滚动时的偏移量
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
   // 获取布局属性
    // 范围矩形
    CGRect rect;
    rect.origin.x = proposedContentOffset.x;
    rect.origin.y = 0;
    rect.size = self.collectionView.frame.size;
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // 获取collectionView中心点的X值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    // 距离中心点最小间距的cell
    CGFloat minDelea = MAXFLOAT;
    
    for (UICollectionViewLayoutAttributes *attrs in array) {
        CGFloat delea = attrs.center.x - centerX;
        if (ABS(minDelea) > ABS(delea)) {
            minDelea = delea;
        }
    }
    
    // 修改原有偏移量
    proposedContentOffset.x += minDelea;
    
    return proposedContentOffset;
}

@end
















