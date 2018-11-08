//
//  UIView+View.h
 
/**
 作用：UIView常用扩展属性
 */

#import <UIKit/UIKit.h>

@interface UIView (View)

#pragma mark - 常用扩展属性
/**
 UIView常用扩展属性
 */
@property (nonatomic, assign) CGFloat ln_x;
@property (nonatomic, assign) CGFloat ln_y;
@property (nonatomic, assign) CGFloat ln_width;
@property (nonatomic, assign) CGFloat ln_height;
@property (nonatomic, assign) CGFloat ln_centerX;
@property (nonatomic, assign) CGFloat ln_centerY;
@property (nonatomic, assign) CGSize  ln_size;
@property (nonatomic, assign) CGPoint ln_origin;
@property (nonatomic, assign) CGFloat ln_maxX;
@property (nonatomic, assign) CGFloat ln_maxY;
 


#pragma mark - 快速加载view类名对应的Xib
/**
 快速加载view类名对应的Xib
 */
+ (instancetype)ln_loadViewFromXib;





@end
