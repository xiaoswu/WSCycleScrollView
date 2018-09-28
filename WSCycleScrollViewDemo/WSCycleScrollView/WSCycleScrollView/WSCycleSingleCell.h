//
//  WSSingleImageCell.h
//  WSCycleScrollView
//
//  Created by ynfMac on 2018/9/26.
//  Copyright © 2018年 ynfMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSCycleSingleCell : UICollectionViewCell

typedef NS_ENUM(NSUInteger,WSCycleSingleCellStyle){
    WSCycleSingleCellStyleDefault, // 只显示图片
    WSCycleSingleCellStyleValue1,  // 只显示文字
    WSCycleSingleCellStyleValue2   // 即显示文字也显示图片
};

@property (nonatomic,strong,readonly) UIImageView *imageView;

@property (nonatomic,strong,readonly) UILabel *textLabel;

@property (nonatomic,assign) WSCycleSingleCellStyle style;

@end
