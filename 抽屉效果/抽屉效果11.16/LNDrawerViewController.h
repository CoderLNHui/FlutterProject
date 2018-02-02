//
//  LNDrawerViewController.h
//  抽屉效果11.16
//
//  Created by LN on 16/11/16.
//  Copyright © 2016年 Learning Point. All rights reserved.
/*
 注:暴露在外面的成员属性,又不想让外界修改,就可以在前面加readonly
 */

#import <UIKit/UIKit.h>

@interface LNDrawerViewController : UIViewController

/** 红色 */
@property (nonatomic, strong,readonly) UIView *redMainView;
/** 蓝色 */
@property (nonatomic, strong,readonly) UIView *leftBlueView;
/** 黄色 */
@property (nonatomic, strong,readonly) UIView *rightYellowView;
@end
