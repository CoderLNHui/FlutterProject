/*
 * LNDrawerViewController.h
 *
 *「Public_不知名开发者 | https://github.com/CoderLN | https://www.jianshu.com/u/fd745d76c816」
 *
 * 各位厂友, 由于「时间 & 知识」有限, 总结的文章难免有「未全、不足」, 该模块将系统化学习, 后续「坚持新增文章, 替换、补充文章内容」.
 */

/**
 抽取封装：抽屉控制器
 */
#import <UIKit/UIKit.h>

@interface LNDrawerViewController : UIViewController

// 注解：暴露在外面的成员属性，又不想让外界修改，就可以在前面加readonly
@property (nonatomic, strong,readonly) UIView *mainView;// 中间主视图
@property (nonatomic, strong,readonly) UIView *leftView;// 左侧视图
@property (nonatomic, strong,readonly) UIView *rightView;// 右侧视图

@end
 



//----------------------- <#使用步骤#> ------------------------//
//
/**
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
 */
