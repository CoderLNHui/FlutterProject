//
//  LNInputView.h
//  LNInputAccessoryView
//
// 「Public|Jshu_不知名开发者 | https://github.com/CoderLN」
//  各位厂友, 由于「时间 & 知识」有限, 总结的文章难免有「未全、不足」, 该模块将系统化学习, 后续「坚持新增文章, 替换、补充文章内容」
//
/**
 UITextView占位文字颜色+键盘上附图自适应高度
 */

#import <UIKit/UIKit.h>

@interface LNInputView : UITextView

/**
  圆角
 */
@property (nonatomic, assign) NSUInteger cornerRadius;
/**
  占位文字
 */
@property (nonatomic, strong) NSString * placeholder;
/**
  占位文字颜色
 */
@property (nonatomic, strong) UIColor * placeholderColor;


/**
  textView最大显示行数
 */
@property (nonatomic, assign) NSUInteger maxNumberOfLines;


/**
  文字高度改变会自动调用Block text:文字内容, textHeight:文字高度
 */
@property (nonatomic, strong) void(^ln_textHeightChangeBlock)(NSString *text, CGFloat textHeight);






//--------------------------- 【LN使用】 ------------------------------//
//

/*
- (LNInputView *)textView
{
    if(_textView == nil) {
        _textView = [[LNInputView alloc] init];
        
        // 设置文本框占位文字
        _textView.placeholder = @"Public_不知名开发者";
        _textView.placeholderColor = [UIColor redColor];
        
        
        // 监听文本框文字高度改变, 高度改变会自动执行这个Block,可在这里修改底部View的高度
        __weak __typeof(self) weakSelf = self;
        _textView.ln_textHeightChangeBlock = ^(NSString *text, CGFloat textHeight) {
            
            NSLog(@"监听文本框文字高度改变 %@ %f" ,text ,textHeight);
            weakSelf.textHeight = textHeight;// 记录文字高度的改变
            
            
            // 告诉self.view约束需要更新
            [weakSelf.view setNeedsUpdateConstraints];
            // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新
            [weakSelf.view updateConstraintsIfNeeded];
            [weakSelf.view layoutIfNeeded];
        };
        
        // 设置最大显示行数
        _textView.maxNumberOfLines = 4;
    }
    return _textView;
}


#pragma mark - updateViewConstraints
// 重写该方法来更新约束
- (void)updateViewConstraints
{
    [self.inputBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        // 这里写需要更新的约束，不用更新的约束将继续存在
        // 底部ViewHeight = 文字高度 + textView距离上下间距的约束
        make.height.mas_equalTo(self.textHeight + 5 + 5);
    }];
    
    [super updateViewConstraints];
}

*/


















//--------------------------- 【自适应】 ------------------------------//
//

/*
1.
// 自适应
[self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height



2.
// 根据一定宽度和字体计算高度
[self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;


3.
// numberlines用来控制输入的行数
NSInteger numberLines = textView.contentSize.height / textView.font.lineHeight;

4.
 [self sizeToFit]; 
*/





@end
