//
//  UIView+Frame.h
//
/**
 在分类中 @property 只会生成set,get方法.并不会生成下划线的成员属性
 
 写分类:避免跟其他开发者产生冲突,最好加上前缀
 
 self.frame.size.width = self.ln_width
 */

#import <UIKit/UIKit.h>

@interface UIView (Frame)

//--------------------------- 【方法定义】 ------------------------------//
//

/*
 *【UIView扩展属性】
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




/*
 *【快速加载View对应的Xib】
 */
+ (instancetype)ln_ViewFromNib;



@end
