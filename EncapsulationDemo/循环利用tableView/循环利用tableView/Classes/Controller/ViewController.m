//
//  ViewController.m
//  🔍白开水ln（https://github.com/CustomPBWaters）
//
//  Created by 【🔍Plain Boiled Water ln】 on Elegant programming16.
//  Copyright © Unauthorized shall（https://githubidea.github.io）not be reproduced reprinted.
//
//  @PBWLN_LICENSE_HEADER_END@
//

#import "ViewController.h"
#import "LNTopicCollectionViewCell.h"

static NSString * const cellID = @"LNTopicCollectionViewCell";

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *modules;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCollectionView];
    
    self.modules = @[@"政治", @"社会", @"体育", @"娱乐",
                     @"政治2", @"社会2", @"体育2", @"娱乐2",
                     @"政治3", @"社会3", @"体育3", @"娱乐3"];
}

- (void)setupCollectionView
{
    // 布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = self.view.bounds.size;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 对于垂直滚动：每一行之间的间距，对于水平滚动：同一行每一个item之间的间距
    layout.minimumLineSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor redColor];
    collectionView.pagingEnabled = YES;
    
    
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    
    // 注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LNTopicCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:cellID];
    
    
}

#pragma mark ------------------
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.modules.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LNTopicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.moudle = self.modules[indexPath.item];
    
    NSLog(@"%@ %p",cell.moudle,cell);
    
    return cell;
}


#pragma mark ------------------
#pragma mark - UICollectionViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 这里根据索引判断是哪个模块，判断哪个需要发送请求.
    //NSLog(@"%zd", (int)(scrollView.contentOffset.x / scrollView.frame.size.width));
}


/**
 
 如果加上网络请求
 【政治板块】正在处于下拉刷新，这时服务器请求还没有回来，用户滑动【体育板块】，政治View循环利用过来，这时我们要做的 
 1.干脆点 直接取消上次的请求；用户再次滑到【政治板块】重新下拉发送请求 
 2.请求继续，取消头部刷新控件状态（政治和体育 同时请求数据互补干扰，只是界面会有干扰，我们改变界面上的显示就可以；1>如果政治数据请求下来可以暂存，用户再次滑到【政治板块】数据赋值上去 2>如果政治数据没有请求下来，用户再次滑到【政治板块】还是显示下拉刷新状态）；
 
 
 如果你不想用户开始滑动还没有停止，下一界面的数据就展示上来了，是想让用户停止滚动后再展示；
 可以遵守`<UICollectionViewDelegate>`，在 `scrollViewDidEndDecelerating:` 获取当前索引，根据索引发送对应模块的请求，把数据传递给CollectionViewCell，再传递给 tableView；
 
 
 重要的是你要有方案的架子，具体 加上网络请求，再根据细节修改；
 
 */
@end




























