/*
 * LNPageControl.m
 * 简/众_不知名开发者 | https://github.com/CoderLN
 *
 * 各位厂友, 由于「时间 & 知识」有限, 总结的文章难免有「未全、不足」, 该模块将系统化学习, 后续「坚持新增文章, 替换、补充文章内容」.
 */

/**
 场景: 自定义PageControl小圆点大小
 */

#import "LNPageControl.h"

@implementation LNPageControl


// 方法一: 重新设置子控件frame
- (void)layoutSubviews {
    [super layoutSubviews];
 
    // 外部设置frame 和 pageW ,效果是圆点平分frame显示
    CGFloat spacingW = (self.frame.size.width - self.subviews.count * self.pageWH) /(self.subviews.count +1);
    for (NSInteger index = 0; index < self.subviews.count; index++) {
        
        UIImageView * pageView = [self.subviews objectAtIndex:index];
        CGFloat pageViewX = (index + 1) * spacingW + index * self.pageWH + self.pageWH/2;
        CGFloat pageViewY = self.frame.size.height /2;
        
        if (index == self.currentPage)  {
            pageView.bounds = CGRectMake(0, 0, self.pageWH + 5, self.pageWH + 5);
            pageView.center = CGPointMake(pageViewX, pageViewY);
            
        } else {
            pageView.bounds = CGRectMake(0, 0, self.pageWH, self.pageWH);
            pageView.center = CGPointMake(pageViewX, pageViewY);
        }
        
        pageView.backgroundColor = [UIColor grayColor];
        NSLog(@"%@", NSStringFromCGRect(pageView.frame));
    }
}



// 方法二: 重写CurrentPage,设置圆点的大小
- (void)setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];
    
    [self layoutSubviews];
}


 


@end




































