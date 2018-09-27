
//
//  LNLeftTableVC.m
//
//  Pbulic/jianshu_不知名开发者, Created by https://github.com/CoderLN
//  🏃🏻‍♂️ ◕ 尊重熬夜整理的作者，该模块将系统化学习，后续替换、补充文章内容 ~.
//

#import "LNLeftTableVC.h"

@interface LNLeftTableVC ()

@end

@implementation LNLeftTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor grayColor];
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
    
    cell.textLabel.text = @"jianshu";
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"我是左侧VC";
}

@end
