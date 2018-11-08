//
//  LNButton.m
// 「Public_不知名开发者 | https://github.com/CoderLN | https://www.jianshu.com/u/fd745d76c816」
//  各位厂友, 由于「时间 & 知识」有限, 总结的文章难免有「未全、不足」, 该模块将系统化学习, 后续「坚持新增文章, 替换、补充文章内容」.
//

#import "LNButton.h"
#import "UIView+Frame.h"
@implementation LNButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置图片的位置
    self.imageView.ln_y = 0;
    self.imageView.ln_centerX = self.ln_width * 0.5;
    
    // 设置标题的位置
    self.titleLabel.ln_y = self.ln_height - self.titleLabel.ln_height;
    [self.titleLabel sizeToFit]; // 自适应计算文字宽度
    self.titleLabel.ln_centerX = self.ln_width * 0.5; // 先计算,后修改center
}


@end
