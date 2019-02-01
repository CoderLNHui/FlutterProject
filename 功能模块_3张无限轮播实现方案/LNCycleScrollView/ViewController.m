/*
 * ViewController.m
 * 简/众_不知名开发者 | https://github.com/CoderLN
 *
 * 各位厂友, 由于「时间 & 知识」有限, 总结的文章难免有「未全、不足」, 该模块将系统化学习, 后续「坚持新增文章, 替换、补充文章内容」.
 */

#import "ViewController.h"
#import "LNScrollView.h"
#import "LNTestController.h"



@interface ViewController ()
@property (nonatomic, strong) LNScrollView *scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d",i]]];
    }
    
    self.scrollView = [[LNScrollView alloc] initWithFrame:CGRectMake(0, 64,kScreenWidth, 300) images:images andIndexBlock:^(NSInteger index) {
        
        NSLog(@"返回点击对应下标 %ld 做后续处理",index);
        if (index == 0) {
            [self presentViewController:[[LNTestController alloc] init] animated:YES completion:nil];
        }
    }];
    
    [self.view addSubview:self.scrollView];
}


@end
