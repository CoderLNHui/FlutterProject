/*
 * LNScrollView.m
 *
 *「Public_不知名开发者 | https://github.com/CoderLN | https://www.jianshu.com/u/fd745d76c816」
 *
 * 各位厂友, 由于「时间 & 知识」有限, 总结的文章难免有「未全、不足」, 该模块将系统化学习, 后续「坚持新增文章, 替换、补充文章内容」.
 */
 

#import "LNScrollView.h"
#import "LNPageControl.h"

#define kviewWidth   self.frame.size.width
#define kviewHeight  self.frame.size.height

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h" /** 约束布局 */

@interface LNScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray * images; // 图片数组
@property (nonatomic, strong) UIImageView * leftImageView; // 左视图
@property (nonatomic, strong) UIImageView * centerImageView; // 中
@property (nonatomic, strong) UIImageView * rightImageView; // 右
@property (nonatomic, assign) NSInteger centerPage; // 中间视图下标
@property (nonatomic, strong) UILabel * numberLabel; // 下标显示
@property (nonatomic, strong) NSTimer * timer; // 定时器
@property (nonatomic, strong) LNPageControl * pageControl; // 小圆点

@end

@implementation LNScrollView

#pragma mark - init Methods
- (UIScrollView *)scrollView
{
    if(_scrollView== nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.backgroundColor = [UIColor redColor];
        _scrollView.contentSize = CGSizeMake(3 * kviewWidth, kviewHeight);// 内容滚动大小
        _scrollView.pagingEnabled = YES;// 分页
        _scrollView.showsHorizontalScrollIndicator = NO;// 水平滚动条
        _scrollView.delegate = self;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClickIndex:)];
        [self.scrollView addGestureRecognizer:tap];
 
    }
    return _scrollView;
}

- (NSArray *)images
{
    if(_images == nil) {
        _images = [NSArray array];
    }
    return _images;
}


- (UILabel *)numberLabel
{
    if(_numberLabel == nil) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.backgroundColor = [UIColor lightGrayColor];
        _numberLabel.text = [NSString stringWithFormat:@"%ld / %ld",self.centerPage,self.images.count - 1];
        _numberLabel.textColor = [UIColor whiteColor];
        _numberLabel.textAlignment = NSTextAlignmentRight;
        [_numberLabel sizeToFit];
    }
    return _numberLabel;
}

// pageControl创建
- (UIPageControl *)pageControl
{
    if(_pageControl == nil) {
        _pageControl = [[LNPageControl alloc] init];
        _pageControl.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        _pageControl.numberOfPages = self.images.count; // 多少页码
        _pageControl.currentPage = self.centerPage; // 当前页码
        _pageControl.hidesForSinglePage = YES; // 单页时隐藏
        _pageControl.userInteractionEnabled = NO;
        _pageControl.pageWH = 20;// 设置圆点大小

        // 自定义小圆点颜色、图片(KVC 访问私有变量)
        //_pageControl.pageIndicatorTintColor = [UIColor lightGrayColor]; // 页码颜色
        //_pageControl.currentPageIndicatorTintColor = [UIColor whiteColor]; // 当前页码颜色
        [_pageControl setValue:[UIImage imageNamed:@"dot_1"] forKeyPath:@"_currentPageImage"];
        [_pageControl setValue:[UIImage imageNamed:@"dot"] forKeyPath:@"_pageImage"];
    }
    return _pageControl;
}


#pragma mark - 快速构造方法
- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images andIndexBlock:(LNBlock)index
{
    if (self = [super initWithFrame:frame]) {
        self.images = images;
        self.indexBlock = index; // 注解: 这里需要赋值一下,下面的判断才会有值 (局部属性赋值给全局属性)
        
        UIImageView *imageView;
        if (self.images.count <= 1) { // 优化: 单页时以下就不再创建,直接返回默认图片
            imageView = [[UIImageView alloc] initWithFrame:self.bounds];
            imageView.image = self.images.count == 1 ? self.images[0] : [UIImage imageNamed:@"pbw"];
            [self addSubview:imageView];
            return self;
        }
        
        [self addSubview:self.scrollView];
        [self addImageView];
        
        
        [self addSubview:self.pageControl];
        [self.pageControl makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.centerX.equalTo(self).offset(0);
            make.size.equalTo(CGSizeMake(kviewWidth - 200, 30));
        }];
        
        [self addSubview:self.numberLabel]; // 下标显示
        [self.numberLabel makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self).offset(-10);
        }];
 
        self.centerPage = 0; // 设置显示images[0]
        [self startTimer]; // 添加定时器

    }
    
    return self;
}
 


#pragma mark - addImageView Method
- (void)addImageView
{
    CGRect frame = self.bounds;
    self.leftImageView = [[UIImageView alloc] initWithFrame:frame];
    self.leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    frame.origin.x += kviewWidth;
    self.centerImageView = [[UIImageView alloc] initWithFrame:frame];
    
    frame.origin.x += kviewWidth;
    self.rightImageView = [[UIImageView alloc] initWithFrame:frame];
    
    [self.scrollView addSubview:self.leftImageView];
    [self.scrollView addSubview:self.centerImageView];
    [self.scrollView addSubview:self.rightImageView];
}



#pragma mark - setupImage & Page Method
- (void)setCenterPage:(NSInteger)centerPage
{
    _centerPage = centerPage;
    if (_centerPage < 0) { // 向右滑动显示左侧内容, 与0比较
        _centerPage = self.images.count - 1;
    } else if (_centerPage > self.images.count - 1) { // 向左滑动显示右侧内容, 与images.count - 1 比较
        _centerPage = 0;
    }
    
    // leftPage和rightPage 都以centerPage来表示
    NSInteger leftPage = _centerPage - 1 < 0 ? self.images.count - 1 : _centerPage - 1;
    NSInteger rightPage = _centerPage + 1 > self.images.count - 1 ? 0 : _centerPage + 1;
    
    
    // imageView赋值
    self.centerImageView.image = self.images[_centerPage];
    self.leftImageView.image = self.images[leftPage];
    self.rightImageView.image = self.images[rightPage];
    
    // 设置偏移量显示中间一页 (注解: 这里不要采用 setContentOffset:animated:YES)
    self.scrollView.contentOffset = CGPointMake(kviewWidth, 0);
}



#pragma mark - timer Methods
// 开启定时器
- (void)startTimer
{
    // 添加timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

// 停止定时器
- (void)stopTimer
{
    if (self.timer) { // 销毁,置为nil
        [self.timer invalidate];
        self.timer = nil;
    }
}


// 代码滚动: 方法动画结束时调用 scrollViewDidEndScrollingAnimation:(仅当animated设置为YES时才调用)
- (void)nextPage
{
    CGPoint offset = self.scrollView.contentOffset;
    offset.x += kviewWidth;
    [self.scrollView setContentOffset:offset animated:YES];
}




#pragma mark - pageControl添加点击事件




#pragma mark - scrollView Delegate Method
// 只要滑动就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%.2f",scrollView.contentOffset.x);
}

// 手指滑动: 将要开始拖动调用, 停止定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
    NSLog(@"手指滑动: 将要开始拖动调用, 停止定时器");
}

// 手指滑动: 减速完成调用, 开启定时器 (只要设置了 paggingEnabled 分页显示,手指滑动后就会调用)
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 判断contentOffsest.x
    NSString * str = [NSString stringWithFormat:@"%ld / %ld",self.centerPage,self.images.count - 1];;
    if (scrollView.contentOffset.x > kviewWidth) { // 下一张
        self.centerPage++;
        str = [NSString stringWithFormat:@"%ld / %ld",self.centerPage,self.images.count - 1];
        
    } else if (scrollView.contentOffset.x < kviewWidth) { // 上一张
        self.centerPage--;
        str = [NSString stringWithFormat:@"%ld / %ld",self.centerPage,self.images.count - 1];
    } else if (scrollView.contentOffset.x == kviewWidth) {
        self.centerPage = self.pageControl.currentPage;
    }

    self.numberLabel.text = str;
    self.pageControl.currentPage = self.centerPage;
    
    [self startTimer];
    NSLog(@"手指减速完成,开启定时器 当前 %ld 页",self.centerPage);
}


// 代码滚动: setContentOffset: animated:YES 时才会调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.centerPage++;
    self.pageControl.currentPage = self.centerPage;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld / %ld",self.centerPage,self.images.count - 1];
}


#pragma mark - tapClickIndex
- (void)tapClickIndex:(UITapGestureRecognizer *)tap
{
    if (self.indexBlock) {
        self.indexBlock(self.centerPage); // 回调传值 (这里会回调到外部调用的位置)
    }
}


// 是否允许同时支持多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

 
@end



























