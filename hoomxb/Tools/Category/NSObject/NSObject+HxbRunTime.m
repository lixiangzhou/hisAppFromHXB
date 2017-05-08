//
//  NSObject+HxbRunTime.m
//  hoomxb
//
//  Created by HXB on 2017/4/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "NSObject+HxbRunTime.h"
#import <objc/runtime.h>//

@implementation NSObject (HxbRunTime)
    //返回类里面的所有属性
+ (NSArray *)hxb_runTimeGetporperty{
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
