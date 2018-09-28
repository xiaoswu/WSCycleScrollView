//
//  WSCycleScrollView.h
//  WSCycleScrollView
//
//  Created by ynfMac on 2018/9/26.
//  Copyright © 2018年 ynfMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WSCycleScrollView;

@protocol WSCycleScrollViewDelegate <NSObject>

@optional

- (void)cycleScrollView:(WSCycleScrollView *)sycleScrollView didSelcectItemAtIndex:(NSUInteger)index;

@end

typedef NS_ENUM(NSInteger, WSCycleSCrollViewPageControlAliment) {
    WSCycleSCrollViewPageControlAlimentCenter,
    WSCycleSCrollViewPageControlAlimentRight,
    WSCycleSCrollViewPageControlAlimentleft
    
};

typedef NS_ENUM(NSInteger, WSCyclesScrollViewDirection){
    WSCyclesScrollViewDirectionVertical,
    WSCyclesScrollViewDirectionHorizontal
};

@interface WSCycleScrollView : UIView

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imageNames:(NSArray <NSString *>*)imageNames;

@property (nonatomic,weak) id<WSCycleScrollViewDelegate> delegate;

// 图片轮播时的时间间隔 默认2s.
@property (nonatomic) NSTimeInterval autoScrollTimeInterval;

@property (nonatomic) WSCycleSCrollViewPageControlAliment  pageControAliment;

@property (nonatomic) WSCyclesScrollViewDirection scrollDirection;

@end
