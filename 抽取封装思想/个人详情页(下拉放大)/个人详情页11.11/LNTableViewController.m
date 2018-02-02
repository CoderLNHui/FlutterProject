//
//  LNTableViewController.m
//  个人详情页11.10
//
//  Created by 孙慧 on 16/11/10.
//  Copyright © 2016年 iOS技术部. All rights reserved.
//

#import "LNTableViewController.h"

@interface LNTableViewController ()

@end

@implementation LNTableViewController

static NSString *cellID = @"cellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
    // 1.凡是在导航栏下面的ScrollerView,系统会默认设置偏移量64
    //self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    // 不要设置默认偏移量
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    // 让导航栏隐藏
    //self.navigationController.navigationBar.hidden = YES;
    
    // 导航栏或是导航栏上的控件设置透明度没有效果❌
    //self.navigationController.navigationBar.alpha = 0;
    
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    
    // 设置导航条背景(必须得要使用默认的模式UIBarMetricsDefault)
    // 当背景图片设置为Nil,系统会自动生成一张半透明的图片,设置为导航条背景
    //[self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    // 设置导航栏透明(setShadowImage:(可以去掉导航栏下面的线))
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

    NSLog(@"%@",NSStringFromCGRect(self.tableView.frame));

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath { 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    NSLog(@"%p",cell);

    cell.textLabel.text = @"LNiosLearningPoint";
    return cell;
}


 @end
















