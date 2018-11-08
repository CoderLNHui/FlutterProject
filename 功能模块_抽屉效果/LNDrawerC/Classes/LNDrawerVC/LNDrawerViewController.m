/*
 * LNDrawerViewController.m
 *
 *「Public_不知名开发者 | https://github.com/CoderLN | https://www.jianshu.com/u/fd745d76c816」
 *
 * 各位厂友, 由于「时间 & 知识」有限, 总结的文章难免有「未全、不足」, 该模块将系统化学习, 后续「坚持新增文章, 替换、补充文章内容」.
 */

#import "LNDrawerViewController.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
@interface LNDrawerViewController ()

@end

@implementation LNDrawerViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
 
    // 创建视图View
    [self setUpView];

    // 添加拖动手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self.mainView addGestureRecognizer:panGesture];
    
    // 添加点击手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [self.mainView addGestureRecognizer:tapGesture];
}

#pragma mark - 创建视图View
- (void)setUpView
{
    UIView *blueView = [[UIView alloc] initWithFrame:self.view.bounds];
    _leftView = blueView;
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    
    UIView *yellowView = [[UIView alloc] initWithFrame:self.view.bounds];
    _rightView = yellowView;
    yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellowView];
    
    UIView *redView = [[UIView alloc] initWithFrame:self.view.bounds];
    _mainView = redView;
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
}

// 左右拖动定位后可见宽度为100
#define targetR (ScreenW - 100)
#define targetL -targetR
#pragma mark - UIPanGesture拖动调用方法
- (void)panGesture:(UIPanGestureRecognizer *)pan
{
    // 偏移量
    CGPoint transPan = [pan translationInView:self.mainView];
    
    // 为什么不使用transform❓是因为我们还要去修改高度,使用transform,只能修改x y
    //self.mainView.transform = CGAffineTransformTranslate(self.mainView.transform, transPan.x, 0);
    
    self.mainView.frame = [self frameWithOffsetX:transPan.x];
    // 判断拖动方向
    if (self.mainView.frame.origin.x > 0) {
        // 向右
        self.rightView.hidden = YES;
        self.leftView.hidden = NO;
    } else {
        // 向左
        self.rightView.hidden = NO;
        self.leftView.hidden = YES;
    }
    
    // NOTE：当手指松开时,做自动定位
    CGFloat target = 0;// 目标停止位置
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        if (self.mainView.frame.origin.x > ScreenW *0.5) {
            // 1.判断在右侧(当前View的X大于屏幕宽度的一半,就是在右侧)
            target = targetR;
        } else if (CGRectGetMaxX(self.mainView.frame) < ScreenW *0.5){
            // 2.判断在左侧(当前View的最大X值小于屏幕宽度的一半,就是在左侧)
            target = targetL;
        }
        
        // 拖动结束,目标位置和当前x位置的偏移量
        CGFloat offset = target - self.mainView.frame.origin.x;
        [UIView animateWithDuration:0.5 animations:^{
            // 计算当前的View的frame
            self.mainView.frame = [self frameWithOffsetX:offset];
        }];
    }
    
    // 由于手势效果会累加,所以需要给他复位
    [pan setTranslation:CGPointZero inView:self.mainView];
}

#define maxY 100
// 根据偏移量计算mainView的frame
- (CGRect)frameWithOffsetX:(CGFloat)offsetX
{
    CGRect frame = self.mainView.frame;
    // x值变化：加等上拖动偏移量
    frame.origin.x += offsetX;
    
    // NOTE：计算数值变化，找最大值，等比例计算。
    // y值变化：当拖动mainView.origin.x为ScreenW时，此时maxY值最大，对计算的结果取绝对值fabs。
    frame.origin.y = fabs(frame.origin.x * maxY / ScreenW);
    
    // height值变化：屏幕的高度减去两倍的Y值
    frame.size.height = ScreenH - 2*frame.origin.y;
    return frame;
}

#pragma mark - tapGesture点击手势
- (void)tapGesture:(UITapGestureRecognizer *)tap
{
    // 让mainView复位
    [UIView animateWithDuration:0.2 animations:^{
        self.mainView.frame = self.view.bounds;
    }];
}

@end














