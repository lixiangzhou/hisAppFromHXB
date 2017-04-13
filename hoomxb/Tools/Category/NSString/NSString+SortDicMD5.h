//
//  NSString+SortDicMD5.h
//  TR7TreesV3
//
//  Created by 牛严 on 16/6/4.
//  Copyright © 2016年 hoomsun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SortDicMD5)

+ (NSString *)signStringBySortFromParamDict:(NSMutableDictionary *)dict;

+ (NSString *)stringMD5FromString:(NSString *)string;

@end
