
//
//  LNTopicCollectionViewCell.m
//  循环利用tableView
//
//  Created by LN on 17/5/11.
//  Copyright © 2017年 Learning point. All rights reserved.
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
