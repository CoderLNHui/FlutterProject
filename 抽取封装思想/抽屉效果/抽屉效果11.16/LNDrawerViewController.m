//
//  LNDrawerViewController.m
//  抽屉效果11.16
//
//  Created by LN on 16/11/16.
//  Copyright © 2016年 Learning Point. All rights reserved.
//

#import "LNDrawerViewController.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface LNDrawerViewController ()

@end

@implementation LNDrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setUpView];
    
    // 添加拖动手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self.redMainView addGestureRecognizer:panGesture];
    
    // 添加点击手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [self.view addGestureRecognizer:tapGesture];
}

#pragma mark 创建视图View
- (void)setUpView{
    UIView *blueView = [[UIView alloc] initWithFrame:self.view.bounds];
    _leftBlueView = blueView;
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    
    UIView *yellowView = [[UIView alloc] initWithFrame:self.view.bounds];
    _rightYellowView = yellowView;
    yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellowView];
    
    UIView *redView = [[UIView alloc] initWithFrame:self.view.bounds];
    _redMainView = redView;
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
}

#define targetL -275
#define targetR 275

#pragma mark UIPanGesture拖动
- (void)panGesture:(UIPanGestureRecognizer *)pan{
    // 偏移量
    CGPoint transPan = [pan translationInView:self.redMainView];
    
    /*
     为什么不使用transform,是因为我们还要去修改高度,使用transform,只能修改x y
     */
    //self.redMainView.transform = CGAffineTransformTranslate(self.redMainView.transform, transPan.x, 0);
    
    self.redMainView.frame = [self frameWithOffsetX:transPan.x];
    // 判断拖动方向
    if (self.redMainView.frame.origin.x > 0) {
        // 向右
        self.rightYellowView.hidden = YES;
    } else {
        // 向左
        self.rightYellowView.hidden = NO;
    }
    
    // 当手指松开时,做自动定位
    CGFloat target = 0;
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        if (self.redMainView.frame.origin.x > ScreenW *0.5) {
            // 1.判断在右侧(当前View的X大于屏幕宽度的一半,就是在右侧)
            target = targetR;
        } else if (CGRectGetMaxX(self.redMainView.frame) < ScreenW *0.5){
            // 2.判断在右侧(当前View的X大于屏幕宽度的一半,就是在右侧)
            target = targetL;
        }
        
        // 计算当前的View的frame
        CGFloat offset = target - self.redMainView.frame.origin.x;
        self.redMainView.frame = [self frameWithOffsetX:offset];
        
    }
    // 由于手势效果会累加,所以需要给他复位
    [pan setTranslation:CGPointZero inView:self.redMainView];
}

#define maxY 100
// 根据偏移量计算redMainView的frame
- (CGRect)frameWithOffsetX:(CGFloat)offsetX{
    CGRect frame = self.redMainView.frame;
    frame.origin.x += offsetX;
    
    // 当拖动的View的x值等于屏幕宽度时,maxY为最大,最大为100
    // 375 *100 / 375
    // 对计算的结果取绝对值fabs
    CGFloat y = fabs(frame.origin.x *maxY / ScreenW);
    frame.origin.y = y;
    
    // 屏幕的高度减去两倍的Y值
    frame.size.height = [UIScreen mainScreen].bounds.size.height - (2* frame.origin.y);
    
    return frame;
}

#pragma mark tapGesture点击手势
- (void)tapGesture:(UITapGestureRecognizer *)tap{
    // 让redMainView复位
    [UIView animateWithDuration:0.2 animations:^{
        self.redMainView.frame = self.view.bounds;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end














