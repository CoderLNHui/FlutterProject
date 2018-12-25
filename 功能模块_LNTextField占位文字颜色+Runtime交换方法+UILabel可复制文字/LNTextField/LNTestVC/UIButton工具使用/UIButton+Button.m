//
//  UIButton+Button.m
// 「 Public_不知名开发者 | https://github.com/CoderLN 」
//  各位厂友, 由于「时间 & 知识」有限, 总结的文章难免有「未全、不足」, 该模块将系统化学习, 后续「坚持新增文章, 替换、补充文章内容」.
//

#import "UIButton+Button.h"

@implementation UIButton (Button)

/**
 快速构造方法
 */
- (void)setIconInTop
{
    
}

- (void)setIconInLeft
{
    
}

- (void)setIconInBottom
{
    
}

- (void)setIconInRight
{
    
}

- (void)setIconInTopWithSpacing:(CGFloat)spacing
{
    
}

- (void)setIconInLeftWithSpacing:(CGFloat)spacing
{
    
}

- (void)setIconInBottomWithSpacing:(CGFloat)spacing
{
    
}

- (void)setIconInRightWithSpacing:(CGFloat)spacing
{
    CGFloat img_W = self.imageView.frame.size.width;
    CGFloat tit_W = self.titleLabel.frame.size.width;
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - (img_W + spacing / 2), 0, - (img_W + spacing / 2));
    self.imageEdgeInsets = UIEdgeInsetsMake(0, - (tit_W + spacing / 2), 0, - (tit_W + spacing / 2));
}




@end
