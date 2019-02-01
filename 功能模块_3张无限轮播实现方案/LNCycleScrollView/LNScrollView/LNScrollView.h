/*
 * LNScrollView.h
 * 简/众_不知名开发者 | https://github.com/CoderLN
 *
 * 各位厂友, 由于「时间 & 知识」有限, 总结的文章难免有「未全、不足」, 该模块将系统化学习, 后续「坚持新增文章, 替换、补充文章内容」.
 */

/**
 UIScrollView 滚动视图
 
 1.需求效果
   scrollView循环滚动,小圆点,点击对应下标回调
 
 2.实现方案
   Viewframe images index
 
 ScrollView循环滚动轮播原理:
     1.三张图片:left cneter right,始终显示中间一张
     2.设置圆点样式大小、间距(pageControl的大小)
     3.自定义小圆点(颜色、图片)
     4.返回点击对应下标做后续处理
 */


#import <UIKit/UIKit.h>

typedef void(^LNBlock)(NSInteger index);

@interface LNScrollView : UIView

@property (nonatomic, copy) LNBlock indexBlock; 


/**
 * 快速构造方法
 *
 * @参数 frame :ViewFrame
 * @参数 images :图片数组
 * @参数 index :图片对应下标
 */
- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images andIndexBlock:(LNBlock)index;// 【方法】










//----------------------- <#使用步骤#> ------------------------//
//
#pragma mark - 使用步骤
/**
NSMutableArray *images = [NSMutableArray array];
for (int i = 0; i < 5; i++) {
    [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d",i]]];
}

self.scrollView = [[LNScrollView alloc] initWithFrame:CGRectMake(0, 64,kScreenWidth, 300) images:images andIndexBlock:^(NSInteger index) {
    
    NSLog(@"返回点击对应下标 %ld 做后续处理",index);
    if (index == 0) {
        [self presentViewController:[[LNTestController alloc] init] animated:YES completion:nil];
    }
}];

[self.view addSubview:self.scrollView];

 */
























@end
