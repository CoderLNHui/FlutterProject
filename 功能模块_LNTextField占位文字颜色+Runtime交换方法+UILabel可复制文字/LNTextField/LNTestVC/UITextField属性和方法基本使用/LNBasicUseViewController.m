//
//  LNBasicUseViewController.m
//  简/众_不知名开发者 | https://github.com/CoderLN
//  各位厂友, 由于「时间 & 知识」有限, 总结的文章难免有「未全、不足」, 该模块将系统化学习, 后续「坚持新增文章, 替换、补充文章内容」.
//
 

#import "LNBasicUseViewController.h"

@interface LNBasicUseViewController ()

@end

@implementation LNBasicUseViewController


- (void)setupTextField
{
    // 1.初始化textfield并设置位置及大小
    UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    textField.center = self.view.center;
    
    
    // 1.设置边框样式，只有设置了才会显示边框样式
    textField.borderStyle = UITextBorderStyleBezel;
    typedef NS_ENUM(NSInteger, UITextBorderStyle) {
        UITextBorderStyleNone,// 没有任何边框
        UITextBorderStyleLine,// 线性边框
        UITextBorderStyleBezel,// 阴影效果边框
        UITextBorderStyleRoundedRect// 原型效果边框
    }; // 输入框类型
    
    
    // 1.设置输入框的背景颜色，此时设置为白色 如果使用了自定义的背景图片边框会被忽略掉
    textField.backgroundColor = [UIColor greenColor];
    
    
    // 1.设置背景图片(边框类型为None使用(对于圆角没效果))
    textField.background = [UIImage imageNamed:@"bg.png"];
    // 1.设置失效状态背景图片
    textField.disabledBackground = [UIImage imageNamed:@"disable.png"];
    
    // 1.给文本输入框设置背景图(拉伸)
    [textField setBackground:[[UIImage imageNamed:@"textBG"] stretchableImageWithLeftCapWidth:10 topCapHeight:20]];
    
    // 1.设置占位符，当输入框没有内容时，默认灰色
    textField.placeholder = @"请输入密码";
    
    // 1.字体大小
    textField.font = [UIFont systemFontOfSize:13.0f];
    // 1.字体加粗
    textField.font = [UIFont boldSystemFontOfSize:13.0f];
    
    // 1.设置字体颜色
    textField.textColor = [UIColor redColor];
    
    // 1.自动调整字体的大小以适应整个的区域，默认是保持原来大小,而让长文本滚动
    textField.adjustsFontSizeToFitWidth = YES;
    // 1.设置自动缩小显示的最小字体大小
    textField.minimumFontSize = 8;
    
    // 1.内容对齐方式
    textField.textAlignment = NSTextAlignmentCenter;
    
    // 1.内容的垂直对齐方式  UITextField继承自UIControl,此类中有一个属性contentVerticalAlignment
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    // 1.暗文
    textField.secureTextEntry = NO;
    
    // 1.当再次编辑时,是否把上次编辑的内容清掉
    textField.clearsOnBeginEditing = YES;
    
    // 1.编辑后是否显示删除标识X,可以把文本一次性的删除
    textField.clearButtonMode = UITextFieldViewModeAlways;
    typedef enum {
        UITextFieldViewModeNever,           //永不显示
        UITextFieldViewModeUnlessEditing,   //当不编辑的时候显示
        UITextFieldViewModeWhileEditing,    //当编辑的时候显示(编辑时会出现修改X)
        UITextFieldViewModeAlways           //一直显示
    } UITextFieldViewMode;
    
    // 1.是否自动纠错
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    typedef NS_ENUM(NSInteger, UITextAutocorrectionType) {
        UITextAutocorrectionTypeDefault,// 默认
        UITextAutocorrectionTypeNo,// 不自动纠错
        UITextAutocorrectionTypeYes,// 自动纠错
    };
    
    
    // 1.首字母是否大写
    textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    typedef NS_ENUM(NSInteger, UITextAutocapitalizationType) {
        UITextAutocapitalizationTypeNone, // 不自动大写
        UITextAutocapitalizationTypeWords, //  单词首字母大写
        UITextAutocapitalizationTypeSentences, //  句子的首字母大写
        UITextAutocapitalizationTypeAllCharacters, //  所有字母都大写
    };
    
    
    // 1.设置键盘的类型
    textField.keyboardType = UIKeyboardTypeTwitter;
    typedef NS_ENUM(NSInteger, UIKeyboardType) {
        UIKeyboardTypeDefault,                // 默认键盘，支持所有字符
        UIKeyboardTypeASCIICapable,           // 支持ASCII的默认键盘
        UIKeyboardTypeNumbersAndPunctuation,  // 标准电话键盘，支持＋＊＃字符
        UIKeyboardTypeURL,                    // URL键盘，支持.com按钮 只支持URL字符
        UIKeyboardTypeNumberPad,              // 数字键盘 Suitable for PIN entry.
        UIKeyboardTypePhonePad,               // 电话键盘
        UIKeyboardTypeNamePhonePad,           // 电话键盘，也支持输入人名
        UIKeyboardTypeEmailAddress,           // 用于输入电子 邮件地址的键盘
        UIKeyboardTypeDecimalPad NS_ENUM_AVAILABLE_IOS(4_1),   // 数字键盘 有数字和小数点
        UIKeyboardTypeTwitter NS_ENUM_AVAILABLE_IOS(5_0),      // 优化的键盘，方便输入@、#字符
    };
    
    
    // 1.设置return的类型
    textField.returnKeyType = UIReturnKeyNext;
    typedef NS_ENUM(NSInteger, UIReturnKeyType) {
        UIReturnKeyDefault, // 默认 灰色按钮，标有Return
        UIReturnKeyGo, // 标有Go的蓝色按钮
        UIReturnKeyGoogle, // 标有Google的蓝色按钮，用语搜索
        UIReturnKeyJoin, // 标有Join的蓝色按钮
        UIReturnKeyNext, // 标有Next的蓝色按钮
        UIReturnKeyRoute, // 标有Route的蓝色按钮
        UIReturnKeySearch, // 标有Search的蓝色按钮
        UIReturnKeySend, // 标有Send的蓝色按钮
        UIReturnKeyYahoo, // 标有Yahoo的蓝色按钮
        UIReturnKeyDone, // 标有Yahoo的蓝色按钮
        UIReturnKeyEmergencyCall, // 紧急呼叫按钮
        UIReturnKeyContinue NS_ENUM_AVAILABLE_IOS(9_0),
    };
    
    
    // 1.键盘外观
    textField.keyboardAppearance = UIKeyboardAppearanceDefault;
    typedef NS_ENUM(NSInteger, UIKeyboardAppearance) {
        UIKeyboardAppearanceDefault,          // 默认外观，浅灰色
        UIKeyboardAppearanceLight NS_ENUM_AVAILABLE_IOS(7_0), //
    };
    
    // 1.设置代理,用于实现协议
    textField.delegate = self;
    
    
    // 1.让输入框成为第一响应者,这样键盘自动弹出
    [textField becomeFirstResponder];
    // 1.要让键盘消失,就是让textField失去第一相应者,这样键盘就会消失
    [textField resignFirstResponder];
    
    
    // 1.设置编辑框左边的view和右边的view
    textField.rightView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"test.png"]];
    textField.rightViewMode = UITextFieldViewModeAlways;
    
    // 1.设置光标的颜色为白色
    textField.tintColor = [UIColor whiteColor];
    
    
    [self.view addSubview:textField];
    
    
    //--------------------------- 【场景：UITextField左边的距离】 ------------------------------//
    //
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, textField.frame.size.height)];
    textField.leftView = leftview;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



//【return键模式调用：UIReturnKeyNext】
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];// 失去第一响应
    return YES;
}



@end
