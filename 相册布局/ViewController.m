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
#import "YCircleLayout.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

/** collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;
/** 数据 */
@property (nonatomic, strong) NSMutableArray *imageNames;

@end

@implementation ViewController

static NSString *const YPhotoCellID = @"cell";

- (NSMutableArray *)imageNames
{
    if (_imageNames == nil) {
        _imageNames = [NSMutableArray array];
        for (int i = 0; i < 20; i++) {
            [_imageNames addObject:[NSString stringWithFormat:@"%zd",i+1]];
        }
    }
    return _imageNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 布局
    YCircleLayout *layout = [[YCircleLayout alloc] init];
    CGFloat collectionViewW = self.view.frame.size.width;
    
    // collectionView的尺寸
    CGRect frame = CGRectMake(0, 200, collectionViewW, 400);

    // collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    // 设置数据源和代理
    collectionView.dataSource = self;
    collectionView.delegate = self;
    self.collectionView = collectionView;
    
    // 注册cell
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YPhotoViewCell class]) bundle:nil] forCellWithReuseIdentifier:YPhotoCellID];
    
}
/**
 *  触摸切换布局
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.collectionView.collectionViewLayout isKindOfClass:[YLineLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[YCircleLayout alloc] init] animated:YES];
        [self.collectionView reloadData];
    } else {
        YLineLayout *layout = [[YLineLayout alloc] init];
        layout.itemSize = CGSizeMake(200, 200);
        [self.collectionView setCollectionViewLayout:layout animated:YES];
        [self.collectionView reloadData];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YPhotoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YPhotoCellID forIndexPath:indexPath];
    cell.imageName = self.imageNames[indexPath.item];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.imageNames removeObjectAtIndex:indexPath.item];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}


@end
