//
//  YPhotoViewCell.m
//  相册布局
//
//  Created by wyw on 16/7/12.
//  Copyright © 2016年 Style_Y. All rights reserved.
//

#import "YPhotoViewCell.h"

@interface YPhotoViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end

@implementation YPhotoViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = [imageName copy];
    self.photoImageView.image = [UIImage imageNamed:imageName];
}

@end
