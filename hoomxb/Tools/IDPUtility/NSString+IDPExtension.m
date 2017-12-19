//
//  NSString+FMExtension.m
//
//  NSString+IDPExtension.m
//  IDP
//
//  Created by douj on 13-3-6.
//  Copyright (c) 2012年 baidu. All rights reserved.
//

#import "NSString+IDPExtension.h"

#pragma mark -

@implementation NSString(IDPExtension)

/**
 解析形如key1=""&key2=""的url参数
 
 @return 以字典形式返回
 */
- (NSDictionary*)parseUrlParam
{
    NSMutableDictionary* resultDic = [[NSMutableDictionary alloc] init];
    if(self.length > 0){
        NSArray* paramList = [self componentsSeparatedByString:@"&"];
        for(NSString* param in paramList) {
            NSArray* tempList = [param componentsSeparatedByString:@"="];
            if(2 == tempList.count){
                [resultDic setObject:tempList[1] forKey:tempList[0]];
            }
        }
    }
    return resultDic;
}

@end
