//
//  WSSingleImageCell.m
//  WSCycleScrollView
//
//  Created by ynfMac on 2018/9/26.
//  Copyright © 2018年 ynfMac. All rights reserved.
//

#import "WSSingleImageCell.h"

@interface WSSingleImageCell ()

@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation WSSingleImageCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
    }
    return self;
}

- (void)setupImageView{
    UIImageView *imageView = [[UIImageView alloc] init];
    _imageView = imageView;
    [self.contentView addSubview:imageView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = self.bounds; 
}

- (void)setImageName:(NSString *)imageName{
    if (imageName != _imageName) {
        _imageName = imageName;
        _imageView.image = [UIImage imageNamed:_imageName];
    }
}

@end
