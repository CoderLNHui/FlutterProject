
//
//  clockView.m
//  手势解锁11.22
//
//  Created by LN on 16/11/22.
//  Copyright © 2016年 Learning Point. All rights reserved.
/*
 1.手指监听
 方法一:使用Touch触摸监听
 
 2.九宫格计算*+
 
 3.学写代码:
 低耦合(控制器)
 高内聚(方法)
 抽方法(功能点,功能要单一性)
 */

#import "ClockView.h"

@interface ClockView ()

/** 选中按钮 */
@property (nonatomic, strong) NSMutableArray *selectBtnArray;
/** 记录当前手指点 */
@property (nonatomic, assign) CGPoint curP;
@end
@implementation ClockView

// 懒加载
- (NSMutableArray *)selectBtnArray{
    if (!_selectBtnArray) {
        _selectBtnArray = [NSMutableArray array];
    }
    return _selectBtnArray;
}
- (void)awakeFromNib{
    // 搭建界面添加按钮
    [self setUp];
}

// 1.添加子控件
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 初始化
        [self setUp];
    }
    return self;
}
// 初始化
- (void)setUp{
    for (int i = 0; i < 9; i++) {
        // 添加按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        // 设置按钮图片
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        btn.tag = i;
        // 添加按钮
        [self addSubview:btn];
        
        // 要把btn的交互设置为NO,不然btn就会处理事件,就不会交给父控件touch处理事件*+
        btn.userInteractionEnabled = NO;
    }
}

// 2.设置子控件的frame
// 九宫格计算*+
- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 总列数
    int cloumn = 3;
    CGFloat btnWH = 74;
    // 每列之间的间距
    CGFloat margin = (self.bounds.size.width - cloumn *btnWH) / (cloumn +1);
    // 当前所在列
    int curCloumn = 0;
    // 当前所在的行
    int curRow = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    // 取出所有的控件
    for (int i = 0; i <self.subviews.count; i++) {
        // 计算当前所在的列
        curCloumn = i % cloumn;
        // 计算当前所在的行
        curRow = i / cloumn;
        // 计算x,y
        x = margin + (btnWH +margin) *curCloumn;
        y = (btnWH + margin) *curRow;
        
        UIButton *btn = self.subviews[i];
        btn.frame = CGRectMake(x, y, btnWH, btnWH);
    }
}


#pragma mark - Touch触摸

// 获取当前手指点*+//📚
- (CGPoint)getCurrentPoint:(NSSet *)touches{
    
    UITouch *touch = [touches anyObject];
    CGPoint curP = [touch locationInView:self];
    return curP;
}

/**
 给点一个点,判断点在不在按钮身上
 如果在按钮身上,返回当前所在的按钮,如果不在,返回nil
 */
- (UIButton *)btnRectContainsPoint:(CGPoint)point{
    
    for (UIButton *btn in self.subviews) {
        // CGRectContainsPoint(btn.frame, point) 判断点在不在Rect范围内(BooL)*+
        if (CGRectContainsPoint(btn.frame, point)) {//📚
            // 让当前按钮成为选中状态
            //btn.selected = YES;
            return btn;
        }
    }
    return nil;
}

// 触摸开始(手指点击时让按钮成选中状态)
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //当前的手指所在的点在不在按钮上,如果在 让按钮成为选中状态
    // 1.获取当前手指所在的点*+
    CGPoint curP = [self getCurrentPoint:touches];
    // 2.判断当前点在不在按钮身上
    UIButton *btn = [self btnRectContainsPoint:curP];
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        // 保存当前选中按钮
        [self.selectBtnArray addObject:btn];
    }
    
}
// 触摸移动(手指移动时,按钮选中,连线到当前选中的按钮)
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 1.获取当前手指所在的点*+
    CGPoint curP = [self getCurrentPoint:touches];
    // 2.判断当前点在不在按钮身上
    UIButton *btn = [self btnRectContainsPoint:curP];
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        [self.selectBtnArray addObject:btn];
        
    }
    // 画线(重绘)
    [self setNeedsDisplay];
    self.curP = curP;
}
// 触摸结束(手指松开时,按钮取消选中状态,清空所有的连线)
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 1.取消所有选中的按钮,查看选中按钮的顺序(拼接字符串)
    NSMutableString *str = [NSMutableString string];
    for (UIButton *btn in self.selectBtnArray) {
        [str appendFormat:@"%ld",btn.tag];//📚拼接字符串
        btn.selected = NO;
    }
    // 2.清空路径
    [self.selectBtnArray removeAllObjects];
    [self setNeedsDisplay];
    
    // 3.查看当前选中的顺序
    NSString *keyPwd = [[NSUserDefaults standardUserDefaults] objectForKey:@"keyPwd"];
    if (!keyPwd) {// 先看有没有,没有的话就保存
        [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"keyPwd"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"第一次输入密码");
    } else {
        if ([keyPwd isEqualToString:str]) {
            NSLog(@"密码正确");
            UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"手势输入正确" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertV show];
          
        } else {
            NSLog(@"密码错误");
            UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"手势输入错误" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertV show];
        }
    }
    NSLog(@"选中按钮顺序为:%@",str);


}

- (void)drawRect:(CGRect)rect{
    if (self.selectBtnArray.count) {
        // 1.创建路径
        UIBezierPath *path = [UIBezierPath bezierPath];
        // 2.取出所有保存的选中的按钮
        for (int i = 0; i < self.selectBtnArray.count; i++) {
            UIButton *btn = self.selectBtnArray[i];
            // 判断按钮是不是第一个按钮
            if (i == 0) {
                // 如果是,设置成路径的起点
                [path moveToPoint:btn.center];
            } else {
                // 添加一根线到按钮的中心
                [path addLineToPoint:btn.center];
            }
        }
        
        // 添加一根线到按钮的中心
        [path addLineToPoint:self.curP];
        
        // 设置线
        [path setLineWidth:10];
        [[UIColor redColor] set];
        //设置线的连接样式
        [path setLineJoinStyle:kCGLineJoinRound];
        
        // 3.绘制路径
        [path stroke];
    }
    

}
@end




























