//
//  ViewController.h
//  MY_Additions
//
//  Created by 李鹏跃 on 16/12/26.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "NSObject+Addition.h"

@implementation NSObject (Addition)

/// 使用字典创建模型对象
///
/// @param dict 字典
///
/// @return 模型对象
+ (instancetype)addition_objectWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

@end
