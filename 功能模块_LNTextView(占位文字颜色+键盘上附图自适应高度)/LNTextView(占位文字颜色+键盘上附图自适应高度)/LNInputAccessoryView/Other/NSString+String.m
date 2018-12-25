//
//  NSString+String.m
//  LNInputAccessoryView
//
//  Created by LN on 2016/10/23.
//  Copyright © 2016年 Public_CoderLN. All rights reserved.
//

#import "NSString+String.h"

@implementation NSString (String)


/**
 *  根据一定宽度和字体计算高度
 */
- (CGSize)stringHeightWithMaxWidth:(CGFloat)maxWidth andFont:(UIFont*)font  {
    
    return  [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
}




/**
 *  根据一定高度和字体计算宽度
 */
- (CGSize)stringWidthWithMaxHeight:(CGFloat)maxHeight andFont:(UIFont*)font {
    
    return  [self boundingRectWithSize:CGSizeMake(MAXFLOAT, maxHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
}

 

@end
