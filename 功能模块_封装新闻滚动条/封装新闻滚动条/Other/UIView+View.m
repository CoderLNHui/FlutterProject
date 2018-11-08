//
//  UIView+View.m
 

#import "UIView+View.h"

@implementation UIView (View)

#pragma mark - 【UIView扩展属性】

- (void)setLn_width:(CGFloat)ln_width
{
    CGRect rect = self.frame;
    rect.size.width = ln_width;
    self.frame = rect;
}

- (void)setLn_height:(CGFloat)ln_height
{
    CGRect rect = self.frame;
    rect.size.height = ln_height;
    self.frame = rect;
}

-(CGFloat)ln_width
{
    return self.frame.size.width;
}

- (CGFloat)ln_height
{
    return self.frame.size.height;
}


// - - -


- (void)setLn_x:(CGFloat)ln_x
{
    CGRect rect = self.frame;
    rect.origin.x = ln_x;
    self.frame = rect;
}

- (void)setLn_y:(CGFloat)ln_y
{
    CGRect rect = self.frame;
    rect.origin.y = ln_y;
    self.frame = rect;
}

- (CGFloat)ln_x
{
    return self.frame.origin.x;
}

- (CGFloat)ln_y
{
    return self.frame.origin.y;
}


// - - -


- (void)setLn_size:(CGSize)ln_size
{
    CGRect rect = self.frame;
    rect.size = ln_size;
    self.frame = rect;
}


- (void)setLn_origin:(CGPoint)ln_origin
{
    CGRect rect = self.frame;
    rect.origin = ln_origin;
    self.frame = rect;
}


- (CGSize)ln_size
{
    return self.frame.size;
}

- (CGPoint)ln_origin
{
    return self.frame.origin;
}


// - - -


-(void)setLn_centerX:(CGFloat)ln_centerX {
    CGPoint center = self.center;
    center.x = ln_centerX;
    self.center = center;
}

- (void)setLn_centerY:(CGFloat)ln_centerY {
    CGPoint center = self.center;
    center.y = ln_centerY;
    self.center = center;
}

- (CGFloat)ln_centerX {
    return self.center.x;
}

- (CGFloat)ln_centerY {
    return self.center.y;
}


// - - -

 
- (void)setLn_maxX:(CGFloat)ln_maxX
{
    self.ln_x = ln_maxX - self.ln_width;
}
- (CGFloat)ln_maxX
{
    return CGRectGetMaxX(self.frame);
}

- (void)setLn_maxY:(CGFloat)ln_maxY
{
    self.ln_y = ln_maxY - self.ln_height;
}
- (CGFloat)ln_maxY
{
    return CGRectGetMaxY(self.frame);
}




#pragma mark - 快速加载view类名对应的Xib
/**
 快速加载view类名对应的Xib
 */
+ (instancetype)ln_loadViewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}









@end
