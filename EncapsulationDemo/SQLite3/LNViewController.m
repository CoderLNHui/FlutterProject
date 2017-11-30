/*
 * File:  LNViewController.m
 * Author:  白开水ln（https://github.com/CustomPBWaters）
 *
 * Created by 【WechatPublic-Codeidea】 on Elegant programming16.
 * Copyright © Reprinted（https://githubidea.github.io）Please indicate the source.Mustbe.
 *
 * JaneBook:  http://www.jianshu.com/u/fd745d76c816
 *
 * @HEADER_WELCOME YOU TO JOIN_GitHub & Codeidea_END@
 */


#import "LNViewController.h"

// 2.导入头文件
#import <sqlite3.h>

#define STEP
@interface LNViewController ()

@property (weak, nonatomic) IBOutlet UILabel *tip; // 提示
@property (weak, nonatomic) IBOutlet UITextField *name; // 姓名
@property (weak, nonatomic) IBOutlet UITextField *score;// 地址
@property (weak, nonatomic) IBOutlet UITextField *age; // 年龄
@end

@implementation LNViewController

static sqlite3 *db; // 3.定义数据库



- (void)viewDidLoad {
    [super viewDidLoad];

    [self openSqlite];
}


#pragma mark --- 打开数据库
- (void)openSqlite
{
    // 获取沙盒路径
    NSString * documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    // 拼接存储路径
    NSString * dbPath = [documentPath stringByAppendingPathComponent:@"db.file"];
    NSLog(@"storePath: %@",dbPath);
    
    /**
     3.打开数据库
     open 会先判断数据库文件是否存在, 如果不存在会自动创建数据库文件, 然后再打开数据
     open 会返回一个int类型的值, 这个值代表着打开数据库是否成功
     */
    if (sqlite3_open(dbPath.UTF8String, &db) == SQLITE_OK) {
        NSLog(@"sqlite3_open_success");
        [self createTable];
    } else {
        NSLog(@"sqlite3_open_failure");
        self.tip.text = @"数据库打开失败";
        sqlite3_close(db);
    }
}


#pragma mark --- 创建表
- (void)createTable
{
    // 4.创建表 (sql语句其中id是主键, not null表示这些字段不能为NULL, default 0默认值)
    NSString * create_table_stmt = @"create table if not exists wechat_Codeidea (id integer primary key autoincrement, name text not null, score real default 0, age integer);";
    
    
#ifdef STEP
    [self sql_step:create_table_stmt];
    NSLog(@"sql_step - 1有宏定义执行");
#else
    [self sql_exec:create_table_stmt];
    NSLog(@"sql_exec - 0没有宏定义执行");
#endif
}


#pragma mark --- SQL执行语句
/*
 sqlite3_step 和 sqlite3_exec 都可以用于执行SQL语句
 他们的区别在于后者是sqlite3_prepare()、sqlite3_step() 和 sqlite3_finalize() 的封装
 能让程序多次执行sql语句而不要写许多重复的代码，然后提供一个回调函数进行结果的处理
 */
// 方式一:
- (void)sql_step:(NSString *)sql_stmt
{
    // 用于提取数据的变量
    sqlite3_stmt * stmt;
    sqlite3_prepare(db, sql_stmt.UTF8String, -1, &stmt, NULL);
    if (sqlite3_step(stmt) != SQLITE_DONE) {
        self.tip.text = @"sql_step 操作失败";
    } else {
        NSLog(@"sql_step 操作成功");
    }
    // 销毁stmt,防止内存泄漏
    sqlite3_finalize(stmt);
    
    [self clearMes];
}


// 方式二:
- (void)sql_exec:(NSString *)sql_stmt
{
    // 用来记录错误信息
    char * error;
    /*
     第1参数:需要执行sql语句的数据库
     第2参数:需要执行的sql语句
     第3参数:执行完sql语句之后的回调方法
     第4参数:回调方法的参数
     第5参数:错误信息
     */
    sqlite3_exec(db, sql_stmt.UTF8String, NULL, NULL, &error);
    if (error) {
        self.tip.text = [NSString stringWithFormat:@"sql_exec 操作失败: %s",error];
    } else {
        NSLog(@"sql_exec 操作成功");
    }
    [self clearMes];
}




#pragma mark --- 对数据表进行增删改查操作
#pragma mark --- 增加
- (IBAction)insert:(id)sender {
    if (self.name.text.length == 0 || self.score.text.length == 0 || self.age.text.length == 0) return;

    NSString *insert_stmt = [NSString stringWithFormat:
                             @"insert into wechat_Codeidea (name, score, age) values ('%@', '%d', '%d')",
                             self.name.text,
                             self.score.text.intValue,
                             self.age.text.intValue
                             ];
    
    
    NSString *selectName_stmt = [NSString stringWithFormat:
                                 @"select * from wechat_Codeidea where name = '%@' ",
                                 self.name.text];
    sqlite3_stmt *stmt;
    sqlite3_prepare_v2(db,selectName_stmt.UTF8String,-1,&stmt,NULL);
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        NSString *name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];

        if (name == self.name.text) {
            NSLog(@"where name = 该数据已存在");
            return;
        }
    }
    
    
    
#ifdef STEP
    [self sql_step:insert_stmt];
#else
    [self sql_exec:insert_stmt];
#endif
}



#pragma mark --- 删除
- (IBAction)delete:(id)sender {
    if (self.name.text.length == 0 || self.score.text.length == 0 || self.age.text.length == 0) return;

    NSString *delete_stmt = [NSString stringWithFormat:
                             @"delete from wechat_Codeidea where name = '%@' ",
                             self.name.text
                             ];
#ifdef STEP
    [self sql_step:delete_stmt];
#else
    [self sql_exec:delete_stmt];
#endif
}


#pragma mark --- 更改
- (IBAction)update:(id)sender {
    if (self.name.text.length == 0 || self.score.text.length == 0 || self.age.text.length == 0) return;
    
    NSString *update_stmt = [NSString stringWithFormat:
                             @"update wechat_Codeidea set name = '%@', score = '%d', age = %d where name = '%@';",
                             self.name.text,
                             self.score.text.intValue,
                             self.age.text.intValue,
                             self.name.text
                             ];
#ifdef STEP
    [self sql_step:update_stmt];
#else
    [self sql_exec:update_stmt];
#endif
}


#pragma mark --- 查询
// 根据条件查找
- (IBAction)selectName:(id)sender {
    NSString *selectName_stmt = [NSString stringWithFormat:
                             @"select * from wechat_Codeidea where name = '%@' ",
                             self.name.text];
   
    sqlite3_stmt *stmt;
    sqlite3_prepare_v2(db,selectName_stmt.UTF8String,-1,&stmt,NULL);
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        NSString *name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
        NSString *score = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
        NSString *age = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
        
        self.name.text = name;
        self.score.text = score;
        self.age.text = age;
    }
    
    // 销毁stmt, 防止内存泄漏
    sqlite3_finalize(stmt);
}

// 查找所有数据
- (IBAction)selectAll:(id)sender
{
    NSString *selectAll_stmt = [NSString stringWithFormat:
                                @"select * from wechat_Codeidea"];
    [self select_stmt:selectAll_stmt];
}


// 排序查找
- (IBAction)selectOrder_Desc:(id)sender
{
    NSString *selectOrder_stmt = [NSString stringWithFormat:
                                @"select * from wechat_Codeidea order by age desc"];
    [self select_stmt:selectOrder_stmt];
}



- (void)select_stmt:(NSString *)select_stmt
{
    sqlite3_stmt *stmt;
    sqlite3_prepare_v2(db,select_stmt.UTF8String,-1,&stmt,NULL);
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        NSString *name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
        NSString *score = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
        NSString *age = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
        
        NSLog(@"name = %@, score = %@, age = %@",name,score,age);
    }
    
    // 销毁stmt, 防止内存泄漏
    sqlite3_finalize(stmt);
    
    [self clearMes];
}



- (void)clearMes
{
    self.name.text = @"";
    self.score.text = @"";
    self.age.text = @"";
    self.tip.text = @"";
}
    
    
    
@end
















