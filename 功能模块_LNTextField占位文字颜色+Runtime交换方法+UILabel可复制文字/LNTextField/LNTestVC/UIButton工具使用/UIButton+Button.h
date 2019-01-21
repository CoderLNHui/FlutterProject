//
//  UIButton+Button.h
// 「Public|Jshu_不知名开发者 | https://github.com/CoderLN」
//  各位厂友, 由于「时间 & 知识」有限, 总结的文章难免有「未全、不足」, 该模块将系统化学习, 后续「坚持新增文章, 替换、补充文章内容」.
//

#import <UIKit/UIKit.h>

@interface UIButton (Button)

/**
 快速构造方法
 */
- (void)setIconInTop;
- (void)setIconInLeft;
- (void)setIconInBottom;
- (void)setIconInRight;
- (void)setIconInTopWithSpacing:(CGFloat)spacing;
- (void)setIconInLeftWithSpacing:(CGFloat)spacing;
- (void)setIconInBottomWithSpacing:(CGFloat)spacing;
- (void)setIconInRightWithSpacing:(CGFloat)spacing;




@end
