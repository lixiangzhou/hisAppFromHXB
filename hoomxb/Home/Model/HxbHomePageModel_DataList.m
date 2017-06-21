//
//  HxbHomePageModel_DataList.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbHomePageModel_DataList.h"

@implementation HxbHomePageModel_DataList

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

- (void)setUnifyStatus:(NSString *)unifyStatus
{
    _unifyStatus = [self judgmentStateValue:unifyStatus];
}


- (void)setExtraInterestRate:(NSString *)extraInterestRate
{
    _extraInterestRate = extraInterestRate;
    if ([extraInterestRate doubleValue] > 0) {
        _extraInterestRate = [NSString stringWithFormat:@"+%.2f%@",[extraInterestRate doubleValue],@"%"];
    }
}

- (NSString *)judgmentStateValue:(NSString *)unifyStatus
{
    switch ([unifyStatus integerValue]) {
        case 0:
            return @"等待预售开始超过30分";
            break;
        case 1:
            return @"等待预售开始小于30分钟";
            break;
        case 2:
            return @"预定";
            break;
        case 3:
            return @"预定满额";
            break;
        case 4:
            return @"等待开放购买大于30分钟";
            break;
        case 5:
            return @"等待开放购买小于30分钟";
            break;
        case 6:
            return @"开放加入";
            break;
        case 7:
            return @"加入满额";
            break;
        case 8:
            return @"收益中";
            break;
        case 9:
            return @"开放期";
            break;
        case 10:
            return @"已退出";
            break;
        default:
            return nil;
            break;
    }
    return nil;
}

@end
