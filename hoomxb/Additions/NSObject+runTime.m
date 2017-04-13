//
//  NSObject+runTime.m
//  运行时  获取熟悉
//
//  Created by 李鹏跃 on 16/11/6.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "NSObject+runTime.h"
#import <objc/runtime.h>
@implementation NSObject (runTime)
//返回类里面的所有属性
+ (NSArray *)runTime_porperty{
    //获取属性长度 找文件里面的copy
    unsigned int outCount ;
    objc_property_t * plist = class_copyPropertyList([self class], &outCount);
    
    NSMutableArray * arrayM = [[NSMutableArray alloc]initWithCapacity:outCount];
    for (int i = 0; i < outCount; i ++) {
        objc_property_t property = plist[i];
        const char * propertyChar = property_getName(property);
        NSString *propertyString = [NSString stringWithUTF8String: propertyChar];
        [arrayM addObject:propertyString];
    }
    return arrayM.copy;
}





@end
