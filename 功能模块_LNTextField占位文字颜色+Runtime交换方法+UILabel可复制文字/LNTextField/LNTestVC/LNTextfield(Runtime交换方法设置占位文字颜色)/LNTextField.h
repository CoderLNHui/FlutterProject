//
//  LNTextField.h
//  简/众_不知名开发者 | https://github.com/CoderLN
//  各位厂友, 由于「时间 & 知识」有限, 总结的文章难免有「未全、不足」, 该模块将系统化学习, 后续「坚持新增文章, 替换、补充文章内容」.
//

/**
 登录注册输入框
 */
#import <UIKit/UIKit.h>

@interface LNTextField : UITextField

/*
 LN使用
 
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
        
        [self.view addSubview:_textField];
    }
    return _textField;
}


*/


@end
