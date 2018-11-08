//
//  LNTopicCollectionViewCell.m
// 「Public_不知名开发者 | https://github.com/CoderLN | https://www.jianshu.com/u/fd745d76c816」
//  各位厂友, 由于「时间 & 知识」有限, 总结的文章难免有「未全、不足」, 该模块将系统化学习, 后续「坚持新增文章, 替换、补充文章内容」.
//

#import "LNTopicCollectionViewCell.h"

@interface LNTopicCollectionViewCell () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LNTopicCollectionViewCell

//static NSString * const ID = @"cellID";
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //[self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UITableViewCell class]) bundle:nil] forCellReuseIdentifier:ID];
}

// 循环利用过来
- (void)setMoudle:(NSString *)moudle
{
    _moudle = [moudle copy];
    [self.tableView reloadData];// 刷新表格
}


#pragma mark ------------------
#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %zd", self.moudle, indexPath.row];
    
    return cell;
}

@end
