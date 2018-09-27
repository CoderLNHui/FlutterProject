//
//  LNMainTableVC.m
//
//  Pbulic/jianshu_不知名开发者, Created by https://github.com/CoderLN
//  🏃🏻‍♂️ ◕ 尊重熬夜整理的作者，该模块将系统化学习，后续替换、补充文章内容 ~.
//

#import "LNMainTableVC.h"

@interface LNMainTableVC ()

@end

@implementation LNMainTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    cell.textLabel.text = @"不知名开发者";
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"我是中间VC";
}

@end
