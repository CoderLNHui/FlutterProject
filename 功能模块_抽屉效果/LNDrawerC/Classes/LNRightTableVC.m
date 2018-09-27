//
//  LNRightTableVC.m
//  LNDrawerC
//
//  Created by LN on 2018/9/26.
//  Copyright © 2018年 不知名开发者. All rights reserved.
//

#import "LNRightTableVC.h"

@interface LNRightTableVC ()

@end

@implementation LNRightTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor blueColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = @"public_CoderLN";
    return cell;
}

#pragma mark - Delegate
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 20;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"我是右侧VC";
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    UILabel * label = [[UILabel alloc] init];
    label.frame = CGRectMake(self.view.frame.size.width - 190, 0, 100, bgView.frame.size.height);
    label.text = @"我是右侧VC";
    [bgView addSubview:label];
    
    return bgView;
}

@end










