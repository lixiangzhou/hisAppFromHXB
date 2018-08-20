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
 解析url中的path和？后面的参数
 
 @param resultCall 通过block回调解析结果
 */
- (void)parseUrlParam:(void (^)(NSString* path, NSDictionary* paramDic))resultCall
{
    NSString* path = nil;
    NSMutableDictionary* resultDic = nil;
    if(self.length > 0) {
        NSURL* url = [NSURL URLWithString:self];
        //获取路径
        path = url.path;
        //获取参数
        NSString* query = url.query;
        if(query.length > 0){
            resultDic = [[NSMutableDictionary alloc] init];
            NSArray* paramList = [query componentsSeparatedByString:@"&"];
            for(NSString* param in paramList) {
                NSArray* tempList = [param componentsSeparatedByString:@"="];
                if(2 == tempList.count){
                    [resultDic setObject:tempList[1] forKey:tempList[0]];
                }
            }
        }
    }
    
    if(resultCall) {
        resultCall(path, resultDic);
    }
}

- (CGSize)caleFontSize:(UIFont *)font forMaxSize:(CGSize)maxSize lineBreakMode:(NSLineBreakMode)lineBreakMode{
    CGSize properSize = CGSizeZero;
    int lineSpace = 0;
    if (self != nil && ![self isEqualToString:@""])
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = lineBreakMode;
        paragraphStyle.lineSpacing = lineSpace;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        properSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    }
    
    if([UIDevice currentDevice].systemVersion.intValue >= 7.0){
        if(properSize.height > 0){
            properSize.height += 1;
        }
    }
    return properSize;
}

/**
 转成字典
 
 @return 字典
 */
- (NSDictionary*)toDictionary {
    NSData *jsonTempData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonTempData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        dic = nil;
    }
    return dic;
}

- (NSString *)URLEncoding
{
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *upSign = [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    
    return upSign;
}

- (NSString *)URLDecoding
{
    NSMutableString *outputStr = [NSMutableString stringWithString:self];
    [outputStr replaceOccurrencesOfString:@"+" withString:@"" options:NSLiteralSearch range:NSMakeRange(0,[outputStr length])];
    
    return [outputStr stringByRemovingPercentEncoding];
}

- (NSString *)notRounding:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundBankers scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *ouncesDecimal  = [[NSDecimalNumber alloc] initWithString:self];
    
    NSDecimalNumber *roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    
    return [NSString stringWithFormat:@"%@",roundedOunces];
    
}

+ (NSString *)notRounding:(int)position price:(float)price {
    NSDecimalNumberHandler* roundingBehavior = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundBankers scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *ouncesDecimal  = [[NSDecimalNumber alloc] initWithFloat:price];
    
    NSDecimalNumber *roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    
    return [NSString stringWithFormat:@"%@",roundedOunces];
}
@end
