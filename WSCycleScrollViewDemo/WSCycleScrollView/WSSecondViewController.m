//
//  WSSecondViewController.m
//  WSCycleScrollView
//
//  Created by ynfMac on 2018/9/27.
//  Copyright © 2018年 ynfMac. All rights reserved.
//

#import "WSSecondViewController.h"
#import "WSCycleScrollView.h"

@interface WSSecondViewController ()

@end

@implementation WSSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    NSArray *images = @[@"h6",@"h7",@"h7"];
    
    WSCycleScrollView *cycleScrollView = [WSCycleScrollView cycleScrollViewWithFrame:CGRectMake(100, 100, 200, 100) imageNames:images];
    cycleScrollView.autoScrollTimeInterval = 2;
    cycleScrollView.pageControAliment = WSCycleSCrollViewPageControlAlimentCenter;
    
    [self.view addSubview:cycleScrollView];
}

- (void)dealloc{
    NSLog(@"%@ -- dealloc",NSStringFromClass([self class]));
}

@end
