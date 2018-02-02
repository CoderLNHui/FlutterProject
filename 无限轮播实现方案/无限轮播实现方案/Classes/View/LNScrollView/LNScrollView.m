//
//  LNScrollView.m
//  🔍白开水ln（https://github.com/CustomPBWaters）
//
//  Created by 【🔍Plain Boiled Water ln】 on Elegant programming16.
//  Copyright © Unauthorized shall（https://githubidea.github.io）not be reproduced reprinted.
//
//  @PBWLN_LICENSE_HEADER_END@
//
/**
 ScrollView循环滚动轮播原理:
 1.三张图片:left cneter right,始终显示中间一张
 3.自定义小圆点(图片)
 4.返回点击对应下标做后续处理
 */

#import "LNScrollView.h"
#define ScreenViewW  self.frame.size.width
#define ScreenViewH  self.frame.size.height
#import "LNPageControl.h"


@interface LNScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *centerImageView;
@property (nonatomic, strong) UIImageView *rightImageView;

/* 中间显示页 */
@property (nonatomic, assign) NSInteger centerPage;
/* 圆点 */
@property (nonatomic, strong) LNPageControl *pageControl;
/* 图片数组 */
@property (nonatomic, strong) NSArray *imageArray;
/* 定时器 */
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation LNScrollView

- (instancetype)initWithFrame:(CGRect)frame andImageArray:(NSArray *)imageArray index:(void(^)(NSInteger index))indexBlock {
    
    if ([super initWithFrame:frame]) {
        _imageArray = imageArray;
        _myBlock = indexBlock;
        
        UIImageView *imageView;
        if (_imageArray.count <= 1) { // 优化:单页时,以下就不再创建,直接返回图片
            imageView = [[UIImageView alloc] initWithFrame:self.bounds];
            imageView.image = self.imageArray[0];
            [self addSubview:imageView];
            
            return self;
        }
        
        [self createScrollView];
        [self createPageControl];
        [self createContentViews];
        [self startTimer];
        
        self.centerPage = 0; // 当前应该显示数组self.imageView[0]这张图片
    }
    return self;
}



- (void)createScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.delegate = self;// 当滚动结束时，调代理方法，我们在代理方法中调整偏移量等事项
    self.scrollView.pagingEnabled = YES;// 分页
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(3 * ScreenViewW, ScreenViewH); // 内容滚动大小
    self.scrollView.backgroundColor = [UIColor grayColor];
    
    [self addSubview:self.scrollView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self.scrollView addGestureRecognizer:tap];
}

- (void)createPageControl
{
    self.pageControl = [[LNPageControl alloc] initWithFrame:CGRectMake(0, ScreenViewH - 40, ScreenViewW, 40)];
    self.pageControl.numberOfPages = self.imageArray.count;
    self.pageControl.hidesForSinglePage = YES; // 单页隐藏圆点
    //self.pageControl.userInteractionEnabled = YES;
    self.pageControl.page_W = 25; // 设置圆点大小
    self.pageControl.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];

    
    // 自定义小圆点(图片),KVC 访问私有变量
    //self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    //self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.pageControl setValue:[UIImage imageNamed:@"dot_1"] forKeyPath:@"_currentPageImage"];
    [self.pageControl setValue:[UIImage imageNamed:@"dot"] forKeyPath:@"_pageImage"];
    
    [self addSubview:self.pageControl];
}


#pragma mark - 添加三张图片
- (void)createContentViews
{
    // 把3张imageView对象添加到scrollView上
    CGRect frame = self.bounds;
    self.leftImageView = [[UIImageView alloc] initWithFrame:frame];
    
    frame.origin.x += ScreenViewW;
    self.centerImageView = [[UIImageView alloc] initWithFrame:frame];
    
    frame.origin.x += ScreenViewW;
    self.rightImageView = [[UIImageView alloc] initWithFrame:frame];
    
    [self.scrollView addSubview:self.leftImageView];
    [self.scrollView addSubview:self.centerImageView];
    [self.scrollView addSubview:self.rightImageView];
}


#pragma mark - set方法赋值
- (void)setCenterPage:(NSInteger)centerPage {
    _centerPage = centerPage;
    if (_centerPage < 0) { // 向右滑动显示左面图片,值与0比较
        _centerPage = self.imageArray.count - 1;
    }
    if (_centerPage > self.imageArray.count - 1) {
        _centerPage = 0; // 向左滑动显示右面图片,值与count-1 比较
    }
    
    // Page: left和right用center表示
    NSInteger leftPage = _centerPage - 1 < 0 ? self.imageArray.count -1 : _centerPage - 1;
    NSInteger rightPage = _centerPage +1 > self.imageArray.count - 1 ? 0 : _centerPage + 1;
    
    // 赋值
    self.leftImageView.image = self.imageArray[leftPage];
    self.centerImageView.image = self.imageArray[_centerPage];
    self.rightImageView.image = self.imageArray[rightPage];
    
    // 显示中间那一页（注:这里不要使用动画）
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0)];
    // 设置pageControl的页码
    self.pageControl.currentPage = _centerPage;
    
}


#pragma mark ------------------
#pragma mark - 定时器方法相关

// 开启定时器
- (void)startTimer {
    
    if (_imageArray.count <= 1) return; // 优化:单页时,定时器不开启
    [self stopTimer];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage:) userInfo:nil repeats:YES];
    /*
     作用:修改timer在runLoop中的模式
     目的:不管主线程在做什么操作,都会分配一定的时间处理定时器
     NSDefaultRunLoopMode(默认):同一时间只能执行一个任务
     NSRunLoopCommonModes(公用):可以分配一定的时间处理定时器
     */
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

}

// 代码让scrollView滚动
- (void)nextPage:(NSTimer *)timer {
    CGPoint offset = self.scrollView.contentOffset;
    offset.x += ScreenViewW;
    [self.scrollView setContentOffset:offset animated:YES];
    // 说明：方法动画结束时调用 scrollViewDidEndScrollingAnimation:(仅当animated设置为YES时才调用)
    
}

// 停止定时器
- (void)stopTimer {
    if (_timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}


#pragma mark ------------------
#pragma mark - UIScrollViewDelegate

// 用户即将开始拖动时,停止定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
    NSLog(@"用户即将开始拖动时,停止定时器");
}

// 手动滚动 减速完毕会调用(停止滚动),开启定时器
// 只要设置了scrollView的分页显示，当手动(使用手指)滚动结束后，该代理方法会被调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 判断contentOffsest.x
    if (scrollView.contentOffset.x > scrollView.frame.size.width) { // 下一张
        self.centerPage++;
    } else if (scrollView.contentOffset.x < scrollView.frame.size.width){ // 上一张
        self.centerPage--;
    }
    [self startTimer];
    NSLog(@"手动减速完毕,开启定时器 当前页 %ld",self.centerPage);
}


// 代码 让scrollView滚动结束时才会调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    self.centerPage++;
    //NSLog(@"setContentOffset:YES --> DidEndScrollingAnimation");
}


//--------------------------- <#我是分割线#> ------------------------------//
//
- (void)tapClick:(UITapGestureRecognizer *)tapIndex {
    
    if (self.myBlock) {
        self.myBlock(self.centerPage);
    }
    
}


@end





























