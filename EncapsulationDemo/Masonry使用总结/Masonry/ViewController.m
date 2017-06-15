//
//  ViewController.m
//  ☕️（https://github.com/CustomPBWaters）
//
//  Created by 【Plain Boiled Water ln】 on 16/-/-.
//  Copyright © 2016年（https://custompbwaters.github.io）All rights reserved.
//

#import "ViewController.h"

#define MAS_SHORTHAND // 省略mas_前缀
#define MAS_SHORTHAND_GLOBALS // equalTo函数接收基本数据类型
#import "Masonry.h" //注意：这两个宏必须要在添加Masonry头文件之前导入进去才有效。

/**
 1.edges
 2.priority 优先级
 3.mas_updateConstraints Masonry的更新约束
 4.mas_remakeConstraints Masonry的重写约束
 */

@interface ViewController ()

@property (nonatomic, strong) UIView  *blueView;

@property (nonatomic, strong) UIButton *growingButton;
@property (nonatomic, assign) CGFloat scacle;

@property (nonatomic, assign) BOOL isExpanded;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self testView1];
//    [self testView2];
//    [self testView3];
//    [self testView4];
//    [self testView5];
    [self testView6];
   
}


//--------------------------- 【基本使用：设置内边距】 ------------------------------//
//
// 创建一个View，左右上下空出10个像素
- (void)testView1 {
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view1];

    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(150);
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(30);
        make.right.equalTo(self.view.mas_right).with.offset(30);
    }];
    

    //【通过insets简化设置内边距的方式】，一句代码代替上面的多行
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(150, 30, 30, 30));
    }];
}


//--------------------------- 【简单的动画 priority优先级】 ------------------------------//
//
// 优先级约束一般放在一个控件约束的最后面

- (void)testView2 {
    // 红色View
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    // 蓝色View
    self.blueView = [[UIView alloc]init];
    self.blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.blueView];
    
    // 黄色View
    UIView *yellowView = [[UIView alloc]init];
    yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellowView];
    
    // ---红色View--- 添加约束
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-80);
        make.height.equalTo([NSNumber numberWithInt:50]);
    }];
    
    // ---蓝色View--- 添加约束
    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(redView.mas_right).with.offset(40);
        make.bottom.width.height.mas_equalTo(redView);
    }];
    
    // ---黄色View--- 添加约束
    [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.blueView.mas_right).with.offset(40);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-20);
        make.bottom.width.height.mas_equalTo(redView);
        
        // 【优先级设置为250，最高1000（默认)】
        make.left.mas_equalTo(redView.mas_right).with.offset(100).priority(250);
    }];
    
     NSLog(@"%@",redView);
}

// 点击屏幕移除蓝色View
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.blueView removeFromSuperview];
    [UIView animateWithDuration:1.0 animations:^{
        [self.view layoutIfNeeded];
    }];
}
/**
 注解：
 这里的三个View的宽度是根据约束自动推断设置的，对黄色的View设置了一个与红色View有关的priority(250)的优先级，
 它同时有对蓝色View有个最高的优先级约束（make.left.mas_equalTo(self.blueView.mas_right).with.offset(40);）。
 当点击屏幕是，我将蓝色View移除，此时第二优先级就是生效。
 */



//--------------------------- 【Masonry的更新约束 mas_updateConstraints】 ------------------------------//
//

// 创建一个按钮，约束好它的位置（居中，宽高等于100且小于屏幕宽高值）。
// 每次点击一次这个按钮，其宽高将增大一定的倍数，最终其宽高等于屏幕宽高时将不再变化。
- (void)testView3 {
    self.growingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self setWithButton:self.growingButton title:@"mas_updateConstraints更新约束-点我放大"];
    [self.growingButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.growingButton];
    self.scacle = 1.0;
    
    [self.growingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        
        // 初始宽、高为100，优先级最低
        make.width.height.mas_equalTo(100 * self.scacle);
        
        // 最大放大到整个view +
        make.width.height.lessThanOrEqualTo(self.view);
    }];
}

- (void)buttonClick {
    self.scacle += 1.0;
    
    // 告诉self.view约束需要更新
    [self.view setNeedsUpdateConstraints];
    
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - updateViewConstraints
// 重写该方法来更新约束
//- (void)updateViewConstraints {
//    [self.growingButton mas_updateConstraints:^(MASConstraintMaker *make) {
//        // 这里写需要更新的约束，不用更新的约束将继续存在
//        // 不会被取代，如：其宽高小于屏幕宽高不需要重新再约束
//        make.width.height.mas_equalTo(100 * self.scacle);
//    }];
//    
//    [super updateViewConstraints];
//}





//--------------------------- 【Masonry的重写约束 mas_remakeConstraints】 ------------------------------//
//

// 创建一个按钮，约束好其位置（与屏幕上左右的距离为0，与屏幕底部距离为350），点击按钮后全屏展现（即与屏幕底部距离为0）。
- (void)testView4 {
    self.isExpanded = NO;
    self.growingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self setWithButton:self.growingButton title:@"mas_remakeConstraints重写约束-点我展开"];
    [self.growingButton addTarget:self action:@selector(testView4BtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.growingButton];
    [self.growingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-350);
    }];
    
}


- (void)testView4BtnClick {
    self.isExpanded = !self.isExpanded;
    if (!self.isExpanded) {
        [self.growingButton setTitle:@"mas_remakeConstraints重写约束-点我展开" forState:UIControlStateNormal];
    } else {
        [self.growingButton setTitle:@"mas_remakeConstraints重写约束-点我收起" forState:UIControlStateNormal];
    }
    // 告诉self.view约束需要更新
    [self.view setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - updateViewConstraints
- (void)updateViewConstraints {
    // 这里使用update也能实现效果
    // remake会将之前的全部移除，然后重新添加
    __weak __typeof(self) weakSelf = self;
    [self.growingButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        // 这里重写全部约束，之前的约束都将失效
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        if (weakSelf.isExpanded) {
            make.bottom.mas_equalTo(0);
        } else {
            make.bottom.mas_equalTo(-350);
        }
    }];
    [super updateViewConstraints];
}


/**
 注解：
 mas_remakeConstraints和 mas_updateConstraints 的区别在于
 前者重新对视图进行了约束（抛弃了之前的约束），后者是更新约束条件（保留未更新的约束)，
 如：这次更新了对 height 的约束，其他对X&Y以及宽的约束不变）。
 */




//--------------------------- 【Masonry的比例使用 multipliedBy】 ------------------------------//
//
// 使用multipliedBy必须是对同一个控件本身，如果修改成相对于其它控件会出导致Crash。
- (void)testView5 {
    UIView *topView = [[UIView alloc]init];
    [topView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:topView];
    
    UIView *topInnerView = [[UIView alloc]init];
    [topInnerView setBackgroundColor:[UIColor greenColor]];
    [topView addSubview:topInnerView];
    
    UIView *bottomView = [[UIView alloc]init];
    [bottomView setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:bottomView];
    
    UIView *bottomInnerView = [[UIView alloc]init];
    [bottomInnerView setBackgroundColor:[UIColor blackColor]];
    [bottomView addSubview:bottomInnerView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(bottomView);
    }];
    
    [topInnerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        
        // 求解❓
        make.width.mas_equalTo(topInnerView.mas_height).multipliedBy(2);
        make.center.mas_equalTo(topView);
    }];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(topView);
        make.top.mas_equalTo(topView.mas_bottom);
    }];
    
    [bottomInnerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(bottomView);
        make.height.mas_equalTo(bottomInnerView.mas_width).multipliedBy(4);
        make.center.mas_equalTo(bottomView);
    }];
    
    
//    NSLog(@"%@",NSStringFromCGRect(topInnerView.bounds));
}







//--------------------------- 【大于等于和小于等于某个值的约束】 ------------------------------//
// UILabel包裹约束

- (void)testView6 {
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.numberOfLines = 0;
    textLabel.backgroundColor = [UIColor colorWithRed:0.2 green:1 blue:1 alpha:1.0];
    [self.view addSubview:textLabel];
    
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        // 设置宽度小于等于200
        make.width.lessThanOrEqualTo(@200);
        // 设置高度大于等于10
        make.height.greaterThanOrEqualTo(@(10));
    }];
    
    textLabel.text = @"这是测试的字符串。自检 代码不会可以多敲几次，学习的重点是思想；思路都没有就去写代码这是没有意义的，也没有必须非得 第一步干嘛/第二步干嘛。多数情况下是采用逆向思维，先考虑你要干什么，缺什么补...。";
}



//--------------------------- 我是分割线 ------------------------------//
//
- (void)setWithButton:(UIButton *)button title:(NSString *)title {
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    button.layer.borderColor = UIColor.greenColor.CGColor;
    button.layer.borderWidth = 3;
    button.backgroundColor = [UIColor grayColor];
}











@end
