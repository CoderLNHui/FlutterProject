//
//  NSString+String.h
//  LNInputAccessoryView
//
//  Created by LN on 2016/10/23.
//  Copyright © 2016年 Public_CoderLN. All rights reserved.
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
