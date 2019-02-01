//
//  LNCopyLabel.m
//  简/众_不知名开发者 | https://github.com/CoderLN
//  各位厂友, 由于「时间 & 知识」有限, 总结的文章难免有「未全、不足」, 该模块将系统化学习, 后续「坚持新增文章, 替换、补充文章内容」.
//

#import "LNCopyLabel.h"

@implementation LNCopyLabel

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self attachTapHandler];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self attachTapHandler];
    }
    return self;
}


// 初始化设置
- (void)attachTapHandler
{
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    longPress.minimumPressDuration = 0.5;
    [self addGestureRecognizer:longPress];
}


 
/**
 UIResponder：通过这个类实现UILabel可以响应事件(我们知道UIlabel是不能成为响应者的，所以这里需要重写)，控制需要响应的事件
 */
// 使label能够成为响应事件
- (BOOL)canBecomeFirstResponder {
    return [objc_getAssociatedObject(self, @selector(isCopyable)) boolValue];
}

// 控制响应的方法
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return action == @selector(copyText:);
}



- (BOOL)isCopyable {
    return [objc_getAssociatedObject(self, @selector(isCopyable)) boolValue];
}

- (void)setIsCopyable:(BOOL)number {
    objc_setAssociatedObject(self, @selector(isCopyable), [NSNumber numberWithBool:number], OBJC_ASSOCIATION_ASSIGN);
    [self attachTapHandler];
}





/**
 UIPasteboard：该类支持写入和读取数据，类似剪贴板
 */
- (void)copyText:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    //  有些时候只想取UILabel的text中的一部分
    if (objc_getAssociatedObject(self, @"expectedText")) {
        pasteboard.string = objc_getAssociatedObject(self, @"expectedText");
    } else {
        
        // 因为有时候 label 中设置的是attributedText, 而 UIPasteboard 的string只能接受 NSString 类型, 所以要做相应的判断
        if (self.text) {
            pasteboard.string = self.text;
        } else {
            pasteboard.string = self.attributedText.string;
        }
    }
}



/**
 UIMenuController：可以通过这个类实现在点击内容，或者长按内容时展示出复制、剪贴、粘贴等选择的项，每个选项都是一个UIMenuItem对象
 */
- (void)handleTap
{
    [self becomeFirstResponder];
    UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyText:)];
    UIMenuItem *copyItem1 = [[UIMenuItem alloc] initWithTitle:@"选择" action:@selector(copyText:)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:copyItem,copyItem1, nil]];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}
















//--------------------------- 【注解】 ------------------------------//
//
/*
 1.
UIResponderStandardEditActions：这是苹果给NSObject写的一个分类，其中包含了我们常用的复制，粘贴，全选等方法

- (void)cut:(nullable id)sender     NS_AVAILABLE_IOS(3_0);
- (void)copy:(nullable id)sender     NS_AVAILABLE_IOS(3_0);
- (void)paste:(nullable id)sender     NS_AVAILABLE_IOS(3_0);
- (void)select:(nullable id)sender     NS_AVAILABLE_IOS(3_0);
- (void)selectAll:(nullable id)sender     NS_AVAILABLE_IOS(3_0);
- (void)delete:(nullable id)sender         NS_AVAILABLE_IOS(3_2);

 2.
 以下是剪贴板中可以放置的内容（除了字符串，也可以拷贝图片，URL等）
 1.UIPasteboardTypeListString 字符串数组, 包含kUTTypeUTF8PlainText
 2.UIPasteboardTypeListURL URL数组，包含kUTTypeURL
 3.UIPasteboardTypeListImage 图形数组, 包含kUTTypePNG 和kUTTypeJPEG
 4.UIPasteboardTypeListColor 颜色数组
 
*/



@end




 
    
