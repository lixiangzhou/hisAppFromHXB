//
//  ViewController.h
//  MY_Additions
//
//  Created by 李鹏跃 on 16/12/26.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Addition)

/// 使用字典创建模型对象
///
/// @param dict 字典
///
/// @return 模型对象
+ (instancetype)addition_objectWithDict:(NSDictionary *)dict;

@end
