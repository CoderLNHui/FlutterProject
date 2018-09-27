//
//  LNDrawerViewController.h
//
//  Pbulic/jianshu_不知名开发者, Created by https://github.com/CoderLN
//  🏃🏻‍♂️ ◕ 尊重熬夜整理的作者，该模块将系统化学习，后续替换、补充文章内容 ~.
//

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
