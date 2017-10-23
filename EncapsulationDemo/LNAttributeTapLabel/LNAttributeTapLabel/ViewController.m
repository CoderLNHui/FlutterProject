/*
 * File:  ViewController.m
 * Framework:  UIKit
 * Author:  白开水ln（https://github.com/CustomPBWaters）
 *
 * Created by 【WechatPublic-Codeidea】 on Elegant programming16.
 * Copyright © Reprinted（https://githubidea.github.io）Please indicate the source.Mustbe.
 *
 * JaneBook:  http://www.jianshu.com/u/fd745d76c816
 *
 * @HEADER_WELCOME YOU TO JOIN_GitHub & Codeidea_END@
 */

#import "ViewController.h"
#import "UILabel+YBAttributeTextTapAction.h"

#define LNRGBA(R, G, B, A) [UIColor colorWithRed:(R) / 256.0 green:(G) / 256.0 blue:(B) / 256.0 alpha:(A)]

#define LNAlertShow(messageText,buttonName) \
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"可点击Label提示" message:(messageText) \
delegate:nil cancelButtonTitle:(buttonName) otherButtonTitles: nil];\
[alert show];

@interface ViewController ()<YBAttributeTapActionDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LNRGBA(230, 230, 230, 1.0);
    
    [self setupAttributeBlcokTapLabel];
    [self setupAttributeDelegateTapLabel];
}



//--------------------------- 【给文本添加点击事件Block回调】 ------------------------------//
//
- (void)setupAttributeBlcokTapLabel
{
    NSString * str = @"你好，我是白开水ln，欢迎关注我的微众:Codeidea";

    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.f] range:NSMakeRange(0, str.length)];
    [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, 5)];
    [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(str.length - 11, 11)];
    
    UILabel * attributeTapLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 30)];
    attributeTapLabel.attributedText = attriStr;
    [self.view addSubview:attributeTapLabel];
    
    [attributeTapLabel yb_addAttributeTapActionWithStrings:@[@"白开水ln",@"微众:Codeidea"] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        NSString * message = [NSString stringWithFormat:@"\n Block 点击了“%@”字符\nrange: %@\nindex: %ld",string,NSStringFromRange(range),index];
        LNAlertShow(message, @"取消");
        
 
        switch (index) {
            case 0:
                NSLog(@"%@",message);
                break;
            case 1:
            {
                NSURL * url = [NSURL URLWithString:@"http://www.jianshu.com/u/fd745d76c816"];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url options:@{ } completionHandler:nil];
                }
            }
                break;
            default:
                break;
        }
    }];
}


//--------------------------- 【给文本添加点击事件Delegate回调】 ------------------------------//
//
- (void)setupAttributeDelegateTapLabel
{
    NSString * str = @"欢迎免费订阅我的《电子码书》";
    
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.f] range:NSMakeRange(0, str.length)];
    [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(str.length - 6, 6)];
    
    // 行高
    NSMutableParagraphStyle * paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.alignment = NSTextAlignmentCenter;
    paraStyle.lineSpacing = 20;
    [attriStr addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, str.length)];
    
    UILabel * attributeTapLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, 60, 200)];
    attributeTapLabel.attributedText = attriStr;
    attributeTapLabel.numberOfLines = 0;
    [self.view addSubview:attributeTapLabel];
    
    [attributeTapLabel yb_addAttributeTapActionWithStrings:@[@"《电子码书》"] delegate:self];
}

- (void)yb_attributeTapReturnString:(NSString *)string range:(NSRange)range index:(NSInteger)index
{
    NSString * message = [NSString stringWithFormat:@"\n Delegate 点击了“%@”字符\nrange: %@\nindex: %ld",string,NSStringFromRange(range),index];
    LNAlertShow(message, @"取消");
}


@end









