//
//  LNScrollView.h
//  ☕️（https://github.com/CustomPBWaters）
//
//  Created by 【Plain Boiled Water ln】 on 16/-/-.
//  Copyright © 2016年（https://custompbwaters.github.io）All rights reserved.
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
