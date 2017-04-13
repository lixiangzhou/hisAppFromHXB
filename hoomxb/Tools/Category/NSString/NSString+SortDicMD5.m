//
//  NSString+SortDicMD5.m
//  TR7TreesV3
//
//  Created by 牛严 on 16/6/4.
//  Copyright © 2016年 hoomsun. All rights reserved.
//

#import "NSString+SortDicMD5.h"
#import <CommonCrypto/CommonDigest.h>

//#define MD5KEY @"Fr46lwabMP6MNSNtJr3t8HjVNjzIVJeE"

@implementation NSString (SortDicMD5)

+ (NSString *)signStringBySortFromParamDict:(NSMutableDictionary *)dict {
    NSMutableDictionary *sortDict = [dict mutableCopy];
    NSArray *sortedKeys = [[sortDict allKeys] sortedArrayUsingSelector: @selector(caseInsensitiveCompare:)];
    
    NSMutableString *result = [NSMutableString string];

    if (sortedKeys.count != 0) {
        for(NSString *sortKey in sortedKeys){
            for(NSString *key in [sortDict allKeys]){
                if ([key isEqualToString:sortKey]) {
                    NSString *value = [NSString stringWithFormat:@"%@",[sortDict objectForKey:key]];
                    [result appendFormat:@"%@=%@&", key, value];
                }
            }
        }
    }
    NSString *resultStr = [NSString stringWithString:result];
//    resultStr = [resultStr stringByAppendingString:[KeyChain token]];
    
    NSLog(@"加密前 %@",resultStr);
    
    resultStr = (NSMutableString *)[resultStr stringFromMD5];
    if (resultStr == nil) {
        resultStr = @"";
    }
    NSLog(@"加密后 %@",resultStr);

    return resultStr;
}

- (NSString *)stringFromMD5{
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

+ (NSString *)stringMD5FromString:(NSString *)string
{
    if(string == nil || [string length] == 0)
        return nil;
    
    const char *value = [string UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;

}

@end
