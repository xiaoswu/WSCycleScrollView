//
//  WSSingleImageCell.m
//  WSCycleScrollView
//
//  Created by ynfMac on 2018/9/26.
//  Copyright © 2018年 ynfMac. All rights reserved.
//

#import "WSCycleSingleCell.h"

static const CGFloat labelHeight  = 30.0f;

@interface WSCycleSingleCell ()

@property (nonatomic,strong,readwrite) UIImageView *imageView;

@property (nonatomic,strong,readwrite) UILabel *textLabel;

@end

@implementation WSCycleSingleCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setStyle:WSCycleSingleCellStyleDefault];
    }
    return self;
}

- (void)setupImageView:(WSCycleSingleCellStyle)style{
    if (style == WSCycleSingleCellStyleValue1) return;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    _imageView = imageView;
    [self.contentView addSubview:imageView];
}

- (void)setupLabel:(WSCycleSingleCellStyle)style{
    if (style == WSCycleSingleCellStyleDefault) return;
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.textAlignment = NSTextAlignmentLeft;
    textLabel.textColor = [UIColor grayColor];
    _textLabel = textLabel;
    [self.contentView addSubview:textLabel];
    
    if (_style == WSCycleSingleCellStyleValue1) {
        _textLabel.numberOfLines = 0;
    } else { // _style == WSCycleSingleCellStyleValue2
        _textLabel.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.imageView) {
        self.imageView.frame = self.bounds;
    }
    
    if (self.textLabel) {
        if (_style == WSCycleSingleCellStyleValue1) {
            self.textLabel.frame = self.bounds;
        } else { // _style == WSCycleSingleStyleValue2
            self.textLabel.frame = CGRectMake(0, self.bounds.size.height - labelHeight,self.bounds.size.width, labelHeight);
        }
    }
}

- (void)setStyle:(WSCycleSingleCellStyle)style{
    
    _style = style;
    
    [self removeAllSubViews];
    
    [self setupLabel:_style];
    [self setupImageView:_style];
    
    [self layoutSubviews];
}

- (void)removeAllSubViews{
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
}

@end
