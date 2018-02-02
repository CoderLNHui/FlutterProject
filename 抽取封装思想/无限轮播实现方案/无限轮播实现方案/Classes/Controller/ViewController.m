//
//  ViewController.m
//  🔍白开水ln（https://github.com/CustomPBWaters）
//
//  Created by 【🔍Plain Boiled Water ln】 on Elegant programming16.
//  Copyright © Unauthorized shall（https://githubidea.github.io）not be reproduced reprinted.
//
//  @PBWLN_LICENSE_HEADER_END@


#import "ViewController.h"
#import "LNScrollView.h"

#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i = 7; i <= 8; i++) {
        [imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d",i]]];
    }
    LNScrollView *scrollView = [[LNScrollView alloc] initWithFrame:CGRectMake(0, 20,kScreenWidth, 200) andImageArray:imageArray index:^(NSInteger index) {
        NSLog(@"返回点击对应下标 %ld 做后续处理",index);
    }];
    [self.view addSubview:scrollView];
    
    
    NSMutableArray *imageArray1 = [NSMutableArray array];
    for (int i = 1; i <= 6; i++) {
        [imageArray1 addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d",i]]];
    }
    CGFloat scrollViewY = CGRectGetMaxY(scrollView.frame) + 5;
    LNScrollView *scrollView1 = [[LNScrollView alloc] initWithFrame:CGRectMake(20, scrollViewY,kScreenWidth - 40, kScreenHeight - scrollViewY) andImageArray:imageArray1 index:^(NSInteger index) {
        NSLog(@"返回点击对应下标 %ld 做后续处理",index);
    }];
    [self.view addSubview:scrollView1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
