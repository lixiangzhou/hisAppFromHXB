//
//  NSString+IDPExtension.h
//  IDP
//
//  Created by douj on 13-3-6.
//  Copyright (c) 2012年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (IDPExtension)
/**
 解析形如key1=""&key2=""的url参数

 @return 以字典形式返回
 */
- (NSDictionary*)parseUrlParam;
@end
