//
//  LNViewController.m
//
//  Pbulic/jianshu_不知名开发者, Created by https://github.com/CoderLN
//  🏃🏻‍♂️ ◕ 尊重熬夜整理的作者，该模块将系统化学习，后续替换、补充文章内容 ~.
//

#import "LNViewController.h"
#import "LNMainTableVC.h"
#import "LNLeftTableVC.h"
#import "LNRightTableVC.h"
@interface LNViewController ()

@end

@implementation LNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 当一个控制器的View添加到另一个控制器的View上的时候，那此时View所在的控制器也应该成为上一个控制器的子控制器
    // 中间主控制器
    LNMainTableVC *mainVC = [[LNMainTableVC alloc] init];
    mainVC.view.frame = self.mainView.bounds;
    [self.mainView addSubview:mainVC.view];
    [self addChildViewController:mainVC];
    
    // 左侧主控制器
    LNLeftTableVC *leftVC = [[LNLeftTableVC alloc] init];
    leftVC.view.frame = self.leftView.bounds;
    [self.leftView addSubview:leftVC.view];
    [self addChildViewController:leftVC];
    
    // 右侧主控制器
    LNRightTableVC *rightVC = [[LNRightTableVC alloc] init];
    rightVC.view.frame = self.leftView.bounds;
    [self.rightView addSubview:rightVC.view];
    [self addChildViewController:rightVC];
} 
 

@end
