//
//  LNPersonalDetailsPageVC.m
// 「Public_不知名开发者 | https://github.com/CoderLN | https://www.jianshu.com/u/fd745d76c816」
//  各位厂友, 由于「时间 & 知识」有限, 总结的文章难免有「未全、不足」, 该模块将系统化学习, 后续「坚持新增文章, 替换、补充文章内容」.
//


#import "LNPersonalDetailsPageVC.h"

// 添加上这个宏定义就不用加mas前缀了
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#import "UIImage+Image.h"

#define LNHeaderH 200
#define LNADH 35
#define LNMinH    64
#define ScreenWidth   [UIScreen mainScreen].bounds.size.width
#define Screenheight  [UIScreen mainScreen].bounds.size.height

// CellID标识; (static 只分配一份内存,const 不可改)
static NSString * const CellID = @"CellID";
@interface LNPersonalDetailsPageVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;// 表格视图
@property (nonatomic, strong) UIView *bgView;// 头部背景view
@property (nonatomic, strong) UIImageView *bgImageView;// 头部底部图片
@end

@implementation LNPersonalDetailsPageVC

#pragma mark - 懒加载tableView
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, Screenheight) style:UITableViewStylePlain];

        _tableView.dataSource = self;
        _tableView.delegate = self;
        // 1.注册
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
        // 设置偏移量
        _tableView.contentInset = UIEdgeInsetsMake(LNHeaderH + LNADH, 0, 0, 0);
        _tableView.scrollIndicatorInsets = self.tableView.contentInset;

        
        // 设置导航条背景(必须得要使用默认的模式UIBarMetricsDefault)
        // 当背景图片设置为Nil,系统会自动生成一张半透明的图片,设置为导航条背景
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        // 可以去掉导航栏下面的线
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        
        // 设置偏移量（取消系统默认偏移量64,坐标点是圆点(0,0)）,iOS11弃用
        //self.automaticallyAdjustsScrollViewInsets = NO;
        
        // 导航条上的View不允许直接设为透明，可以把文字的颜色搞成透明.
        UILabel *navTitle = [[UILabel alloc] init];
        navTitle.text = @"个人详情页";
        [navTitle sizeToFit];// 自适应大小
        navTitle.textColor = [UIColor colorWithWhite:0 alpha:0];// 透明
        self.navigationItem.titleView = navTitle;
        
        //设置导航条隐藏
        //但是我们这里导航条隐藏不是直接隐藏的,而是有一个透明度, 根据滚到的位置,设置透明度的.
        //self.navigationController.navigationBar.hidden = YES;
    
    }
    return _tableView;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self.view addSubview:self.tableView];
    // 创建头部控件
    [self topImageView];
}

#pragma mark - 创建头部控件
- (void)topImageView
{
    // 头部背景视图
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = [UIColor redColor];
    self.bgView.clipsToBounds = YES;// 超出部分剪切掉
    [self.view addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view).offset(0);
        make.height.equalTo(@200);
    }];
 
    // 头部底部图片
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    self.bgImageView = bgImageView;
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;// 显示模式等比例拉伸
    [self.bgView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.bgView);
        make.height.equalTo(self.bgView);
    }];
    
    // 头部中间图片
    UIImageView *headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"不知名开发者"]];
    [self.bgView addSubview:headImageView];
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bgView.bottom).offset(-60);
        make.centerX.equalTo(self.bgView.centerX).offset(0.5);
        make.size.equalTo(CGSizeMake(100, 100));
    }];
    
    // 广告条
    UILabel *advertLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    advertLabel.text = @"不知名开发者-悬停,这里不是tableHeaderView";
    advertLabel.textAlignment = NSTextAlignmentCenter;
    advertLabel.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:advertLabel];
    [advertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bgView);
        make.top.mas_equalTo(self.bgView.mas_bottom);
        make.height.mas_equalTo(35);
    }];
}


#pragma mark - tableVeiwDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 2.cell复用队列(访问缓存池)
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    // 3.设置数据(赋值)
    cell.textLabel.text = @"public-CoderLN";
    return cell;
}

#pragma mark - tableVeiwDelegate
// 只要滚动就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    // 求偏移量(当前点 - 最原始点)
    CGFloat originH = -(LNHeaderH + LNADH);
    CGFloat offset = scrollView.contentOffset.y - originH;
 
    // 变化高度
    CGFloat changeH = LNHeaderH - offset;
    NSLog(@"偏移量 %f %f %f",scrollView.contentOffset.y,offset,changeH);

    if (changeH < LNMinH) {
        changeH = LNMinH;
        NSLog(@"变化高度 %f",changeH);
    }
    // 更新约束
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(changeH);
        NSLog(@"更新约束 %f",changeH);
    }];

    // NOTE：根据透明度来生成图片
    CGFloat alpha = offset *1 / (LNHeaderH - LNMinH);// 等比例，找最大值
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













