//
//  ViewController.m
//  相册布局
//
//  Created by wyw on 16/7/11.
//  Copyright © 2016年 Style_Y. All rights reserved.
//

#import "ViewController.h"
#import "YLineLayout.h"
#import "YPhotoViewCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation ViewController

static NSString *const YPhotoCellID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 布局
    YLineLayout *layout = [[YLineLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(200, 200);
    
    CGFloat collectionViewW = self.view.frame.size.width;
    
    CGRect frame = CGRectMake(0, 200, collectionViewW, 400);

    // collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YPhotoViewCell class]) bundle:nil] forCellWithReuseIdentifier:YPhotoCellID];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YPhotoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YPhotoCellID forIndexPath:indexPath];
    cell.imageName = [NSString stringWithFormat:@"%zd",indexPath.item + 1];
    
    return cell;
}

@end
