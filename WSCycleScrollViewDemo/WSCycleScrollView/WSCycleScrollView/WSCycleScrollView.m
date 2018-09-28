//
//  WSCycleScrollView.m
//  WSCycleScrollView
//
//  Created by ynfMac on 2018/9/26.
//  Copyright © 2018年 ynfMac. All rights reserved.
//

#import "WSCycleScrollView.h"
#import "WSSingleImageCell.h"

static NSString * const cellId = @"WSCycleScrollViewId";

static const NSTimeInterval WSDefaultScrollTimeInterval = 2.0f;

@interface WSCycleScrollView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) NSArray *imageNames;

@end

@implementation WSCycleScrollView
{
    UICollectionView * _mainView;
    UICollectionViewFlowLayout *_flowlayout;
    UIPageControl * _pageControl;
    NSTimer * _timer;
    
    // 数组的首元素与末元素在collectionView上无法实现完美的衔接, 为了有无限轮播的效果,我想到的办法是加多cell的个数，一直往后轮播。_itemCounts是collectionview中cell的个数 与imageNames的关系是 _itemCounts = imageNames *100;
    NSUInteger _itemCounts;
}

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialization];
        
        [self setupMainView];
    }
    
    return self;
}

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imageNames:(NSArray<NSString *> *)imageNames{
    WSCycleScrollView *sycleScrollView = [[WSCycleScrollView alloc] initWithFrame:frame];
    sycleScrollView.imageNames = imageNames;
    return sycleScrollView;
}

- (void)initialization{
    [self setAutoScrollTimeInterval:WSDefaultScrollTimeInterval];
    
    self.pageControAliment = WSCycleSCrollViewPageControlAlimentCenter;
    
    _scrollDirection = WSCyclesScrollViewDirectionHorizontal;
}

#pragma mark - view
- (void)layoutSubviews{
    [super layoutSubviews];
    
    _mainView.frame = self.bounds;
    _flowlayout.itemSize = self.bounds.size;
    
    CGPoint pageControlCenter = CGPointZero;
    
    CGSize pageControlSize = [_pageControl sizeForNumberOfPages:self.imageNames.count];
    
    switch (_pageControAliment) {
        case WSCycleSCrollViewPageControlAlimentCenter:
            pageControlCenter = CGPointMake(_mainView.center.x, _mainView.bounds.size.height - 10);
            
            break;
        case WSCycleSCrollViewPageControlAlimentRight:
            pageControlCenter = CGPointMake(_mainView.frame.size.width - (10 + pageControlSize.width *0.5), _mainView.bounds.size.height - 10);
            break;
        case WSCycleSCrollViewPageControlAlimentleft:
            pageControlCenter = CGPointMake(10 + pageControlSize.width *0.5, _mainView.bounds.size.height - 10);
            break;
            
        default:
            break;
    }
    
    _pageControl.center = pageControlCenter;
}

- (void)setupMainView{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0.f;
    _flowlayout = flowLayout;
    
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    mainView.backgroundColor = [UIColor clearColor];
    mainView.showsVerticalScrollIndicator = NO;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.pagingEnabled = YES;
    
    [mainView registerClass:[WSSingleImageCell class] forCellWithReuseIdentifier:cellId];
    mainView.dataSource = self;
    mainView.delegate = self;
    
    [self addSubview:mainView];
    _mainView = mainView;
}

- (void)setupPageControl:(NSUInteger)page{
    if (_pageControl) [_pageControl removeFromSuperview];
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = _imageNames.count;
    [self addSubview:pageControl];
    _pageControl = pageControl;
}

#pragma mark - timer
- (void)setupTimer:(NSTimeInterval)timeInterval{
    if (_timer) [self invalidateTimer];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

- (void)invalidateTimer{
    [_timer invalidate];
    _timer = nil;
}

- (void)automaticScroll{
    if (_itemCounts < 1) return;
    
    NSUInteger currentIndex = [self ws_getCurrentPage];
    NSUInteger nextIndex = currentIndex + 1;
    
    if (nextIndex >= _itemCounts) {
        nextIndex = 0;
        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        return;
    }

    [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

#pragma mark - setter
- (void)setImageNames:(NSArray *)imageNames{
    _imageNames = imageNames;
    
    if (imageNames.count < 1) return;
    _itemCounts = imageNames.count *100;
    [self setupPageControl:_itemCounts];
}

- (void)setAutoScrollTimeInterval:(NSTimeInterval)autoScrollTimeInterval{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    
    [self setupTimer:autoScrollTimeInterval];
}

- (void)setScrollDirection:(WSCyclesScrollViewDirection)scrollDirection{
        _scrollDirection = scrollDirection;
        _flowlayout.scrollDirection = (UICollectionViewScrollDirection)scrollDirection;
}

#pragma mark - privite method
- (NSUInteger)ws_getCurrentPage{
    NSUInteger page;
    
    if (_scrollDirection == WSCyclesScrollViewDirectionHorizontal) {
        page = (_mainView.contentOffset.x + _mainView.frame.size.width *0.5) / _mainView.frame.size.width;
    } else if (_scrollDirection == WSCyclesScrollViewDirectionVertical){
        page = (_mainView.contentOffset.y + _mainView.frame.size.height *0.5) / _mainView.frame.size.height;
    } else {
        page = 0;
    }
    
    return page;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _itemCounts;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WSSingleImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    cell.imageName = self.imageNames[indexPath.row % _imageNames.count];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cycleScrollView:didSelcectItemAtIndex:)]) {
        [self.delegate  cycleScrollView:self didSelcectItemAtIndex:_pageControl.currentPage];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _pageControl.currentPage = [self ws_getCurrentPage] % _imageNames.count;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self invalidateTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self setupTimer:_autoScrollTimeInterval];
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    if (!newSuperview) [self invalidateTimer];
}


@end
