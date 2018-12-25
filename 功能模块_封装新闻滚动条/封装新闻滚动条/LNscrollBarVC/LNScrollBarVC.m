//
//  LNScrollBarVC.m
// 「 Public_不知名开发者 | https://github.com/CoderLN 」
//  各位厂友, 由于「时间 & 知识」有限, 总结的文章难免有「未全、不足」, 该模块将系统化学习, 后续「坚持新增文章, 替换、补充文章内容」.
//

#import "LNScrollBarVC.h"
#import "UIView+View.h"
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface LNScrollBarVC ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *titleScrollView;
@property (nonatomic, strong) UIButton *titleBtn;// 标题按钮
@property (nonatomic, strong) UIView * underLineView;// 下滑线
@property (nonatomic, weak) UIScrollView *contentScrollView;
@property (nonatomic, weak) UIButton *selectBtn;// 记录选中的按钮
@property (nonatomic, strong) NSMutableArray *titleButtons;// 记录标题数组
@property (nonatomic, assign) BOOL isInitialize;// 记录标题是否初始化

@end

@implementation LNScrollBarVC

-(NSMutableArray *)titleButtons {
    if (_titleButtons == nil) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (_isInitialize == NO) {
        // 设置所有标题
        [self setupAllTitle];
        self.isInitialize = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"新闻";
    // iOS7以后,导航控制器中scollView顶部会添加64的额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = NO;
    
    
    // 添加标题滚动视图
    [self setuptitleScrollViewollView];
    // 添加内容滚动视图
    [self setupContenScrollView];
    // 添加所有子控制器
    //[self setupAllChildViewController];
    // 设置所有标题
//    [self setupAllTitle];
}

#pragma mark - 添加标题滚动视图
- (void)setuptitleScrollViewollView {
    
    UIScrollView *titleScrollView = [[UIScrollView alloc] init];
    // 这里的 y 值，既然是封装,要考虑严谨一点,要判断有导航条就是64,无导航条就是20.
    CGFloat y = self.navigationController.navigationBar.hidden ? 20:64;
    titleScrollView.frame = CGRectMake(0, y, ScreenW, 44);
    [self.view addSubview:titleScrollView];
    self.titleScrollView = titleScrollView;
//    titleScrollView.backgroundColor = [UIColor darkGrayColor];
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    self.titleScrollView.showsVerticalScrollIndicator = NO;
}

#pragma mark - 添加内容滚动视图
- (void)setupContenScrollView {

    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    
    CGFloat y = CGRectGetMaxY(self.titleScrollView.frame);
    // 这里的 y 值，就是titleScrollView Y值的最大值
    contentScrollView.frame = CGRectMake(0, CGRectGetMaxY(self.titleScrollView.frame), ScreenW, ScreenH- y);
    self.contentScrollView = contentScrollView;
    [self.view addSubview:contentScrollView];
    
    // 设置contentScrollView的属性
    self.contentScrollView.pagingEnabled = YES;// 分页
    self.contentScrollView.bounces = NO;// 弹簧
    self.contentScrollView.showsHorizontalScrollIndicator = NO;// 指示器
    
    // 设置代理,目的:监听滚动视图什么时候滚动完成
    self.contentScrollView.delegate = self;
}


#pragma mark - 添加所有标题按钮
- (void)setupAllTitle {
    
    // 提示1:我们写一个功能点的时候，也没有必须非得 第一步干嘛/第二步干嘛。多数情况下是采用逆向思维，先考虑你要干什么，缺什么补什么。
    // 提示2:定了方向，不要太过多考虑细节。先写出来把内容展示上去，再根据展示的效果是否是我们想要的(调整细节)。
    
    // 添加所有标题按钮
    NSInteger count = self.childViewControllers.count;
    CGFloat btnW = 100;
    CGFloat btnH = self.titleScrollView.frame.size.height;
   
    for (NSInteger i= 0; i < count; i++) {
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIViewController *vc = self.childViewControllers[i];
        [titleBtn setTitle:vc.title forState:UIControlStateNormal];
        titleBtn.frame = CGRectMake(btnW * i, 0, btnW, btnH);
        
        // 1.标题颜色 为黑色
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
        // 3.监听按钮的点击
        [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleScrollView addSubview:titleBtn];
        
        // 添加到标题数组
        self.titleBtn = titleBtn;
        [self.titleButtons addObject:titleBtn];
    }

    // 添加下划线
    UIView * underLineView = [[UIView alloc] init];
    underLineView.backgroundColor = [UIColor redColor];
    underLineView.ln_height = 2;
    underLineView.ln_y = self.titleScrollView.ln_height - underLineView.ln_height;
    self.underLineView = underLineView;
    [self.titleScrollView addSubview:underLineView];

    // 2.设置标题的滚动范围（需要让titleScrollView可以滚动）
    self.titleScrollView.contentSize = CGSizeMake(count * btnW, 0);
    // 3.设置内容的滚动范围（需要让contentScrollView可以滚动）
    self.contentScrollView.contentSize = CGSizeMake(count * ScreenW, 0);
    
    // 默认选中(手动调用)
    [self setupDefaultSelectTitleBtn];
}


#pragma mark - 添加子控制器的View
- (void)setupViewController:(NSInteger)index {
    UIViewController *vc = self.childViewControllers[index];
//    if (vc.viewIfLoaded) {// 判断控制器是否加载 NS_AVAILABLE_IOS(9_0);
//        return;
//    }
    
    if (vc.view.superview) {// 避免重复加载
        return;
    }
    vc.view.frame = CGRectMake(index * ScreenW, 0, ScreenW, self.contentScrollView.frame.size.height);
    [self.contentScrollView addSubview:vc.view];
}

#pragma mark - 按钮的点击事件

- (void) titleClick:(UIButton *)btn {
    // 获取下标
    NSInteger index = [self.titleButtons indexOfObject:btn];
    NSLog(@"index = %zd",index);
    
    // 1.标题颜色 变成 红色（抽取方法）
    [self selectButton:btn];
    // 2.把对应子控制器的view添加上去
    [self setupViewController:index];
    // 3.内容滚动视图滚动到对应的位置
    self.contentScrollView.contentOffset = CGPointMake(index * ScreenW, 0);
}

#pragma mark - 设置默认选中按钮、默认添加第0个子控制器的View
- (void)setupDefaultSelectTitleBtn
{
    UIButton * btn = self.titleButtons[0];
    // Btn点击切换状态（三步）
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.transform = CGAffineTransformMakeScale(1.3, 1.3);// 字体缩放
    [btn.titleLabel sizeToFit];
    self.underLineView.ln_width = btn.titleLabel.ln_width;
    self.underLineView.ln_centerX = btn.ln_centerX;
    self.underLineView.transform = CGAffineTransformMakeScale(1.5, 1.0);// 一定先计算，后形变
  
    //NSLog(@"默认选中按钮 %f,%f",self.underLineView.ln_width,btn.titleLabel.ln_width);
    // 把对应子控制器的view添加上去
    [self setupViewController:0];
    
    // 记录选中的按钮
    self.selectBtn = btn;
}

#pragma mark - 选中标题按钮
/**
 btn点击切换（三步）
    1.取消上次选中按钮
    2.选中当前点击的按钮
    3.记录当前选中的按钮
 
 这里不是button.selected切换，而是采用的transform 放大和复原，根据点击的是哪个btn切换显示，滚动是改变titleScrollView的offset
 */
- (void)selectButton:(UIButton *)btn
{
    // 字体恢复原始状态
    self.selectBtn.transform = CGAffineTransformIdentity;
    [self.selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.transform = CGAffineTransformMakeScale(1.3, 1.3);// 字体缩放

    self.underLineView.transform = CGAffineTransformIdentity;
    self.underLineView.ln_width = btn.titleLabel.ln_width;
    self.underLineView.ln_centerX = btn.ln_centerX;
    self.underLineView.transform = CGAffineTransformMakeScale(1.5, 1.0);
    //NSLog(@"%f,%f",self.underLineView.ln_width,btn.titleLabel.ln_width);
    
    // 标题居中
    [self setupTitleCenter:btn];
    // 记录选中的按钮
    self.selectBtn = btn;
}



#pragma mark - 标题居中处理
- (void)setupTitleCenter:(UIButton *)btn {
    // 本质:修改titleScrollView偏移量
    CGFloat offsetX = btn.center.x - ScreenW * 0.5;
    
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - ScreenW;
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    //NSLog(@"%f",offsetX);

    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}


#pragma mark - <UIScrollViewDelegate>
/**
 这里有个隐藏问题:-->获取标题按钮
 self.titleScrollView.subviews[i]
 
 原因:UIScrollView默认有两个子控件,这里的subVeiws有可能把两个子控件给取出来,造成与标题不对应。
 解决:提供一个数组专门存放添加的标题（纯洁数组）
 */

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 获取当前角标
    NSInteger i = self.contentScrollView.contentOffset.x / ScreenW;
    // 获取标题按钮
    //UIButton *titleBtn = self.titleScrollView.subviews[i];
    UIButton *titleBtn = self.titleButtons[i];
    
    // 1.把标题颜色 改成红色
    [self selectButton:titleBtn];
    
    // 2.把对应子控制器的view添加上去
    [self setupViewController:i];
}


#pragma mark - 只要一滚动就需要字体渐变
// 分析字体缩放 1.缩放比例 2.缩放那两个按钮
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 获取角标
    NSInteger leftI = scrollView.contentOffset.x / ScreenW;
    NSInteger rightI = leftI + 1;
    //NSLog(@"%ld %ld",leftI,rightI);
    
    // 获取左边的按钮
    UIButton *leftBtn = self.titleButtons[leftI];
    
    // 获取右边的按钮
    NSInteger count = self.titleButtons.count;
    UIButton *rightBtn;
    if (rightI < count) {// 加判断,防止越界
        rightBtn = self.titleButtons[rightI];
    }
    
    // 右边缩放比例（0 ~ 1 => 放大0.3）
    CGFloat scaleR = scrollView.contentOffset.x / ScreenW;
    scaleR -= leftI;
    
    // 左边缩放比例
    CGFloat scaleL = 1 - scaleR;
    
    // 缩放按钮
    leftBtn.transform = CGAffineTransformMakeScale(scaleL * 0.3 + 1, scaleL * 0.3 + 1);
    rightBtn.transform = CGAffineTransformMakeScale(scaleR * 0.3 + 1, scaleR * 0.3 + 1);
    
    // 颜色渐变
    UIColor *leftColor = [UIColor colorWithRed:scaleL green:0 blue:0 alpha:1];// R 1-0
    UIColor *rightColor = [UIColor colorWithRed:scaleR green:0 blue:0 alpha:1];// R 0-1
    [leftBtn setTitleColor:leftColor forState:UIControlStateNormal];
    [rightBtn setTitleColor:rightColor forState:UIControlStateNormal];
}


//--------------------------- <#我是分割线#> ------------------------------//
//

#pragma mark - 标题文字缩放
/**
 解决:1.字体放大(做不到下面要做的颜色渐变效果) 2.改形变
 1.字体放大(做不到下面要做的颜色渐变效果)
 2.改形变
 */

@end
