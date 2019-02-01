//
//  ViewController.m
//  简/众_不知名开发者 | https://github.com/CoderLN
//  各位厂友, 由于「时间 & 知识」有限, 总结的文章难免有「未全、不足」, 该模块将系统化学习, 后续「坚持新增文章, 替换、补充文章内容」.
//

#import "ViewController.h"
#import "LNTextField.h"
#import "LNCopyLabel.h"
#import "UIButton+Button.h"
#import "LNButton.h"


// 只能输入数字和换行，请注意这个\n，如果不写这个Done按键将不会触发
#define NUMBERS @"0123456789\n"

// 只能输入英文和数字的话，就可以把这个定义为
#define kAlphaNum @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kScreenW [UIScreen mainScreen].bounds.size.width
@interface ViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) LNTextField * textField;

@property (weak, nonatomic) IBOutlet LNCopyLabel *cLabel;
@property (weak, nonatomic) IBOutlet LNCopyLabel *noCopyLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self textField];
//
//    [self setupLabel];
    
    [self setupButton];
}



/** 文本框 */
- (UITextField *)textField
{
    if(_textField == nil) {
        _textField = [[LNTextField alloc] initWithFrame:CGRectMake(0, kScreenH - 50, kScreenW, 40)];
        _textField.backgroundColor = [UIColor grayColor];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.font = [UIFont systemFontOfSize:16.f];
        _textField.placeholder = @"Public_不知名开发者";
        //_textField.textColor = [UIColor whiteColor];
        _textField.delegate = self;
//        _textField.keyboardType = UIKeyboardTypeNumberPad;
//        _textField.clearButtonMode = UITextFieldViewModeAlways;
        
        // 监听键盘将要显示或隐藏的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowHide:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowHide:) name:UIKeyboardWillHideNotification object:nil];
    
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
 
        [self.view addSubview:_textField];
    }
    return _textField;
}


//--------------------------- 【场景：监听键盘弹起下落】 ------------------------------//



/**
 监听键盘Frame将要改变的通知
 UIKeyboardWillChangeFrameNotification
 */

- (void)keyboardWillChangeFrame:(NSNotification *)noti
{
    // 获取键盘的Frame
    CGRect keyboardFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 获取键盘弹起持续时间
    float duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];

    [UIView animateWithDuration:duration animations:^{
        CGFloat ty = keyboardFrame.origin.y != [UIScreen mainScreen].bounds.size.height ? keyboardFrame.size.height : 0;
        _textField.transform = CGAffineTransformMakeTranslation(0, -ty);
    }];
    
    NSLog(@"keyboardWillChangeFrame键盘弹起高度：%f",keyboardFrame.size.height);
}

//- (void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
//}


/**
 监听键盘将要显示或隐藏的通知
 UIKeyboardWillShowNotification
 UIKeyboardWillHideNotification
 */

- (void)keyboardWillShowHide:(NSNotification *)noti
{
    // 获取键盘的Frame
    CGRect keyboardFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 获取键盘弹起持续时间
    float duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    if ([[noti name] isEqualToString:UIKeyboardWillShowNotification]) {
        [UIView animateWithDuration:duration animations:^{
            self.textField.transform = CGAffineTransformMakeTranslation(0, -keyboardFrame.size.height);
        }];
    } else if ([[noti name] isEqualToString:UIKeyboardWillHideNotification]) {
        [UIView animateWithDuration:duration animations:^{
            self.textField.transform = CGAffineTransformIdentity;
        }];
    }
    
    NSLog(@"keyboardWillShowHide键盘弹起高度：%f",keyboardFrame.size.height);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}






- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}





//--------------------------- 【场景：限制只能输入特定的字符】 ------------------------------//


#pragma mark ------------------
#pragma mark -【UITextFieldDelegate】
/*
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
    // 按cs分离出数组,数组按@""分离出字符串
    NSString *textFile = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];

    // 当然，你还可以在以上方法return之前，做一提示的，比如提示用户只能输入数字之类的。如果你觉得有需要的话。

    return [string isEqualToString:textFile];
}
**/





//--------------------------- 【场景：限制只能输入一定长度的字符】 ------------------------------//


#pragma mark ------------------
#pragma mark -【UITextFieldDelegate】

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"location、length == %@",NSStringFromRange(range));// range {location = 10, length = 0}
    
    // 限制字符输入, 返回YES表示接受输入的字符 NO表示不接收。
    if([string isEqualToString:@"0"]) {
        return NO;
    }
    
    // 限制最多输入10个字符, 超过不接收不响应
    if ([[textField text] length] + string.length > 20) {
        
        [[[UIAlertView alloc] initWithTitle:nil message:@"超过输入字数限制不能输入了" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
 
        return NO;
    }
    return YES;
}







//--------------------------- 【场景：LNTextfield(Runtime交换方法设置占位文字颜色)】 ------------------------------//











//--------------------------- 【给UILabel添加复制功能】 ------------------------------//
//
- (void)setupLabel
{
    self.cLabel.isCopyable = YES;
    self.noCopyLabel.isCopyable = NO;
}

- (void)setupButton
{
    LNButton *button = [LNButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, self.view.bounds.size.height - 200, 100, 100);
    button.backgroundColor = [UIColor grayColor];
    
    [button setImage:[UIImage imageNamed:@"appIcon"] forState:UIControlStateNormal];
    [button setTitle:@"Button" forState:UIControlStateNormal];
    
 
    
    [self.view addSubview:button];
}

@end






