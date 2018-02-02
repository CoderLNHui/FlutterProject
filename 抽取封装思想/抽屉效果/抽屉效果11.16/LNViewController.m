//
//  LNViewController.m
//  抽屉效果11.16
//
//  Created by 孙慧 on 16/11/16.
//  Copyright © 2016年 iOS技术部. All rights reserved.
/*
 1.抽屉效果封装使用
 // 当一个控制器的View添加到另一个控制器的View上的时候,那此时View所在的控制器也应该成为上一个控制器的子控制器
 LNTableViewController *vc1 = [[LNTableViewController alloc] init];
 vc1.view.frame = self.redMainView.bounds;
 [self.redMainView addSubview:vc1.view];
 [self addChildViewController:vc1];
 */

#import "LNViewController.h"
#import "LNTableViewController.h"
@interface LNViewController ()

@end

@implementation LNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 当一个控制器的View添加到另一个控制器的View上的时候,那此时View所在的控制器也应该成为上一个控制器的子控制器
    LNTableViewController *vc1 = [[LNTableViewController alloc] init];
    vc1.view.frame = self.redMainView.bounds;
    [self.redMainView addSubview:vc1.view];
    [self addChildViewController:vc1];
    
    LNTableViewController *vc2 = [[LNTableViewController alloc] init];
    vc2.view.frame = self.leftBlueView.bounds;
    vc2.view.backgroundColor = [UIColor grayColor];
    [self.leftBlueView addSubview:vc2.view];
    [self addChildViewController:vc2];
    
    LNTableViewController *vc3 = [[LNTableViewController alloc] init];
    vc3.view.frame = self.leftBlueView.bounds;
    vc3.view.backgroundColor = [UIColor blueColor];
    [self.rightYellowView addSubview:vc3.view];
    [self addChildViewController:vc3];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

@end
