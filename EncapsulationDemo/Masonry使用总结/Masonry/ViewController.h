//
//  ViewController.h
//  Masonry（https://github.com/CustomPBWaters）
//
//  Created by 白开水ln on 16/-/-.
//  Copyright © 2016年（https://custompbwaters.github.io）All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController



//--------------------------- 【Masonry约束】 ------------------------------//
// 提供了3种方法，分别为设置约束、更新约束、重写设置约束

/*
// 设置约束
- (NSArray *)mas_makeConstraints:(void(^)(MASConstraintMaker *make))block;

// 更新约束
- (NSArray *)mas_updateConstraints:(void(^)(MASConstraintMaker *make))block;

// 重新设置约束
- (NSArray *)mas_remakeConstraints:(void(^)(MASConstraintMaker *make))block;


 注解：
 mas_makeConstraints: 初次设置约束使用。
 mas_updateConstraints: 更新约束时使用。如果找不着这条约束，会新增，相当于mas_makeConstraints。
 mas_remakeConstraints: 重新设置约束。先将view上所有约束移除，再新增约束

 
 注意：
 mas_updateConstraints只能更新已有约束。如果第一次使用的是left, right设置的相对宽度。
 更新的时候想换成使用width。不能使用mas_updateConstraints，因为已有约束里面没有width的约束，新增width之后会跟原有left, right约束冲突。
 此时应该使用mas_remakeConstraints
*/





//--------------------------- 【小技巧:】 ------------------------------//
//
/**
 如果等式2边的Attribute是一样的，我们可以省略等式右边的Attribute
 如果是等于关系，并且右边的view是父View。连equalTo也可以省略
 如果equalTo里面传的是NSValue类型，效果跟设置offset是一样的
 如果offset为0，其实也是可以省略的...
 下面所有代码实际效果是一样的：
 
 
 // 完整的
 make.left.equalTo(view1.superview.mas_left).offset(0);
 
 //省略Attribute的
 make.left.equalTo(view1.superview).offset(0);
 
 //省略equalTo的
 make.left.offset(0);
 
 //使用equalTo替代offset的
 make.left.equalTo(@0);
 
 //终极大招，省略所有的... 可惜会有warning
 make.left;
 */

@end

