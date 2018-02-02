//
//  LNScrollView.h
//  🔍白开水ln（https://github.com/CustomPBWaters）
//
//  Created by 【🔍Plain Boiled Water ln】 on Elegant programming16.
//  Copyright © Unauthorized shall（https://githubidea.github.io）not be reproduced reprinted.
//
//  @PBWLN_LICENSE_HEADER_END@
//

#import <UIKit/UIKit.h>

typedef void(^LNBlock)(NSInteger index);
@interface LNScrollView : UIView

@property (nonatomic, strong) LNBlock myBlock;

/**
 * 提供构造方法
 * 正反无限轮播
 */
- (instancetype)initWithFrame:(CGRect)frame andImageArray:(NSArray *)imageArray index:(LNBlock)indexBlock;



@end
