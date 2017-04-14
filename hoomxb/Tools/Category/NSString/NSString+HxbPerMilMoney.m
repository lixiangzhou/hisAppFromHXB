//
//  NSString+PerMilMoney.m
//  HongXiaoBao
//
//  Created by 牛严 on 16/7/13.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import "NSString+HxbPerMilMoney.h"

@implementation NSString (HxbPerMilMoney)

+(NSString *)GetPerMilWithDouble:(double)number
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:number]];
    
    return formattedNumberString;
}

@end
