//
//  ViewController.m
//  WSCycleScrollView
//
//  Created by ynfMac on 2018/9/26.
//  Copyright © 2018年 ynfMac. All rights reserved.
//

#import "ViewController.h"
#import "WSCycleScrollView.h"
#import "WSSecondViewController.h"

@interface ViewController ()<WSCycleScrollViewDelegate>
- (IBAction)push:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    NSArray *images = @[@"h7",@"h6",@"h7",@"h6"];
    
    WSCycleScrollView *cycleScrollView = [WSCycleScrollView cycleScrollViewWithFrame:CGRectMake(100, 100, 200, 100) imageNames:images];
    cycleScrollView.delegate = self;
    cycleScrollView.autoScrollTimeInterval = 2;
    cycleScrollView.pageControAliment = WSCycleSCrollViewPageControlAlimentleft;
    cycleScrollView.scrollDirection = WSCyclesScrollViewDirectionHorizontal;
    
    [self.view addSubview:cycleScrollView];
    
    UIButton *name = [[UIButton alloc] init];
    name.frame = CGRectMake(100, 350, 100, 30);
    [name setTitle:@"push" forState:UIControlStateNormal];
    [name setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [name addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:name];

}

- (void)cycleScrollView:(WSCycleScrollView *)sycleScrollView didSelcectItemAtIndex:(NSUInteger)index{

    NSLog(@"index:%ld",index);
}

- (IBAction)push:(id)sender {
    [self.navigationController pushViewController:[[WSSecondViewController alloc] init] animated:YES];
    
}

@end
