//
//  NSString+General.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "NSString+General.h"

@implementation NSString (General)
//根据字符串长度获取label的size
//+(CGSize)getSizeWithText:(NSString*)text fontOfSize:(int)fontSize boundingRectSize:(CGSize)rectSize
//{
//    CGSize size;
//    NSDictionary *attribute = @{NSFontAttributeName: HXB_Text_Font(fontSize)};
//    size = [text boundingRectWithSize:rectSize options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
//    
//    return size;
//}

//获取版本号
+(NSString*)getAppVersionNum
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    //    app_Version = [app_Version stringByReplacingOccurrencesOfString:@"." withString:@""];
    return app_Version;
}

//手机号加密算法
+(NSString*)encryptRegisterNum:(NSString*)rNum {
    NSMutableString *encryptedNum = [NSMutableString stringWithString:rNum];
    
    NSMutableString *reverseNum = [[NSMutableString alloc] initWithCapacity:rNum.length];
    for (NSInteger i = rNum.length - 1; i >=0 ; i --) {
        unichar ch = [rNum characterAtIndex:i];
        [reverseNum appendFormat:@"%c", ch];
    }
    [encryptedNum appendString:reverseNum];
    
    NSArray *zeroArray = @[@"a",@"0",@"1",@"3",@"6"];
    NSArray *oneArray = @[@"b", @"k", @"2", @"4", @"7"];
    NSArray *twoArray = @[@"c", @"l", @"t", @"5", @"8"];
    NSArray *threeArray = @[@"d", @"m", @"u", @"B", @"9"];
    NSArray *fourArray = @[@"e", @"n", @"v", @"C", @"I"];
    NSArray *fiveArray = @[@"f", @"o", @"w", @"D", @"J", @"O"];
    NSArray *sixArray = @[@"g", @"p", @"x", @"E", @"K", @"P", @"T"];
    NSArray *sevenArray = @[@"h", @"q", @"y", @"F", @"L", @"Q", @"U", @"X"];
    NSArray *eightArray = @[@"i", @"r", @"z", @"G", @"M", @"R", @"V", @"Y"];
    NSArray *nineArray = @[@"j", @"s", @"A", @"H", @"N", @"S", @"W", @"Z"];
    
    NSArray *arrays = @[zeroArray,oneArray,twoArray,threeArray,fourArray,fiveArray,sixArray,sevenArray,eightArray,nineArray];
    
    for (int j=0; j<encryptedNum.length; j++) {
        int charIndex = [[encryptedNum substringWithRange:NSMakeRange(j, 1)] intValue];
        NSArray *numArray = [arrays objectAtIndex:charIndex];
        [encryptedNum replaceCharactersInRange:NSMakeRange(j, 1) withString:[numArray objectAtIndex:arc4random()%numArray.count]];
    }
    return encryptedNum;
}

+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9]|7[018]|47)\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[12378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56]|76)\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133、153、177、180、181、189、（1349卫通）、1700（虚拟运营商电信号段）
     22         */
    NSString * CT = @"^1((33|53|77|8[019])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark - 判断字符串是否包含字母
+ (BOOL)isStringContainNumberWith:(NSString *)str {
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger count = [numberRegular numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    //count是str中包含[A-Za-z]数字的个数，只要count>0，说明str中包含数字
    if (count > 0) {
        return YES;
    }
    return NO;
}

#pragma mark - 判断是否有中文字符
+ (BOOL)isChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}

#pragma mark - 判断字符串是否包含特殊字符
+ (BOOL)isIncludeSpecialCharact: (NSString *)str {
    //***需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€"]];
    if (urgentRange.location == NSNotFound)
    {
        return NO;
    }
    return YES;
}
@end
