//
//  LNRootViewController.m
//  个人详情页11.11
//
//  Created by LN on 16/11/11.
//  Copyright © 2016年 LearningPoint. All rights reserved.
/*
 1.设置导航栏透明(必须用Default,传个空图片(不传nil))
 2.scrollViewDidScroll:只要滚动就会调用*+
 */

#import "LNRootViewController.h"

// 添加上这个宏定义就不用加mas前缀了
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#import "UIImage+Image.h"

#define cellID @"cellID"
#define oriOffsetY -200
#define oriImageH 200
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define Screenheight [UIScreen mainScreen].bounds.size.height

@interface LNRootViewController ()<UITableViewDataSource,UITableViewDelegate>

/** 表格视图 */
@property (nonatomic, strong) UITableView *tableView;
/** bgView */
@property (nonatomic, strong) UIView *bgView;
/** bgImageView */
@property (nonatomic, strong) UIImageView *bgImageView;


@end

@implementation LNRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.navigationItem.title = @"gen";
    //[self createTableView];
    
    //self.tableView = [self tableView];
    
    // 1.注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [self topImageView];
}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, Screenheight)];
        
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self.view addSubview:self.tableView];
        
        // 设置导航栏透明(必须用Default,传个空图片(不传nil))
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        // setShadowImage:去掉导航栏底边的线
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        
        // 设置偏移量(取消系统默认偏移量64,坐标点是圆点(0,0))
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
        // 右侧滚动条
        //_tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);
        
        
        //[self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
        //让导航栏隐藏
        //self.navigationController.navigationBar.hidden = YES;
        //self.navigationController.navigationBarHidden = YES;
        
        
        //self.navigationController.navigationBar.translucent = NO;
        //[self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
        
        // 自定义设置导航栏标题
        UILabel *title = [[UILabel alloc] init];
        title.text = @"个人详情页";
        [title sizeToFit];// 自适应大小
        title.textColor = [UIColor colorWithWhite:0 alpha:0];// 透明
        self.navigationItem.titleView = title;
    }
    return _tableView;
}
- (void)topImageView{
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = [UIColor redColor];
    self.bgView.clipsToBounds = YES;// 超出部分剪切掉
    [self.view addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view).offset(0);
        make.height.equalTo(@200);
    }];
 

    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    self.bgImageView = bgImageView;
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;// 等比例拉伸
    [self.bgView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.bgView);
        make.height.equalTo(self.bgView);
    }];
    
    UIImageView *headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"火影"]];
    [self.bgView addSubview:headImageView];
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bgView.bottom).offset(-20);
        make.centerX.equalTo(self.bgView.centerX).offset(0.5);
        make.size.equalTo(CGSizeMake(100, 100));
    }];
}



#pragma mark tableVeiwDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 2.cell复用队列(访问缓存池)
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    // 3.设置数据(赋值)
    cell.textLabel.text = @"Learning Point";
    cell.backgroundColor = [UIColor grayColor];
    return cell;
}


#pragma mark 只要滚动就会调用*+
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    // 求偏移量(当前点 - 最原始点)
    CGFloat offset = scrollView.contentOffset.y - oriOffsetY;
    NSLog(@"===%f",scrollView.contentOffset.y);
 

    // 变化高度
    CGFloat changeH = oriImageH - offset;
    if (changeH < 64) {
        changeH = 64;
        NSLog(@"1--%f",changeH);

    }
    // 更新约束
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(changeH);
        NSLog(@"2--%f",changeH);
    }];

    // 根据透明度来生成图片*+
    // 1.找最大值
    CGFloat alpha = offset *1 / (200 - 64);
    if (alpha >= 1) {
        alpha = 0.99;
    }
    // 2.把颜色生成图片
    UIColor *alphaColor = [UIColor colorWithWhite:1 alpha:alpha];
    UIImage *alphaImage = [UIImage imageWithColor:alphaColor];
    // 3.设置导航栏背景图片
    [self.navigationController.navigationBar setBackgroundImage:alphaImage forBarMetrics:UIBarMetricsDefault];
    
    // 4.拿到标题
    UILabel *titleL = (UILabel *)self.navigationItem.titleView;
    titleL.textColor = [UIColor colorWithWhite:0 alpha:alpha];
    
    //NSLog(@"%.2f",scrollView.contentOffset.y);
}
 

@end













