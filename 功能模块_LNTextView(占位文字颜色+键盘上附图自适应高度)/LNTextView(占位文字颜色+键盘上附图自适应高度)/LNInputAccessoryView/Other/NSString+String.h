//
//  NSString+String.h
//  LNInputAccessoryView
//
//  简/众_不知名开发者 | https://github.com/CoderLN
//  各位厂友, 由于「时间 & 知识」有限, 总结的文章难免有「未全、不足」, 该模块将系统化学习, 后续「坚持新增文章, 替换、补充文章内容」
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface NSString (String)


/**
 *  根据一定宽度和字体计算高度
 *
 *  @param maxWidth 最大宽度
 *  @param font  字体
 *
 *  @return 返回计算好高度的size
 */
- (CGSize)stringHeightWithMaxWidth:(CGFloat)maxWidth andFont:(UIFont*)font ;


/**
 *  根据一定高度和字体计算宽度
 *
 *  @param maxHeight 最大高度
 *  @param font      字体
 *
 *  @return 返回计算宽度的size
 */
- (CGSize)stringWidthWithMaxHeight:(CGFloat)maxHeight andFont:(UIFont*)font;

 

@end
