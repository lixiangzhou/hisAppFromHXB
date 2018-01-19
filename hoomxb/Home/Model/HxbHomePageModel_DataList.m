//
//  HxbHomePageModel_DataList.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#define kHXBUnitConversionToSeconds(Millisecond) (Millisecond/1000.0)
#define kHXBSecond 1
#define kHXBMinute (60 * kHXBSecond)
#define kHXBHour    (60 * kHXBMinute)


#import "HxbHomePageModel_DataList.h"

@implementation HxbHomePageModel_DataList

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

//- (void)setUnifyStatus:(NSString *)unifyStatus
//{
//    _unifyStatus = unifyStatus;
//    _unifyStatus = [self judgmentStateValue:unifyStatus];
//}


- (NSString *)fixExtraInterestRate {
    
    if ([self.extraInterestRate doubleValue] > 0) {
        _fixExtraInterestRate = [NSString stringWithFormat:@" + %.1f%%",[self.extraInterestRate doubleValue]];
    }
    return _fixExtraInterestRate?:@"0";
}

- (NSString *)subsidyInterestRate {
    if ([_subsidyInterestRate doubleValue] > 0) {
        _subsidyInterestRate = [NSString stringWithFormat:@" + %.1f%%",[_subsidyInterestRate doubleValue]];
    }
    return _subsidyInterestRate?:@"0";
}

/**
 剩余时间
 */
- (NSString *) countDownLastStr {
    if (!_countDownLastStr) {
        _countDownLastStr = @(kHXBUnitConversionToSeconds(self.diffTime.doubleValue)).description;
        if (_countDownLastStr.doubleValue <= kHXBHour && _countDownLastStr.doubleValue >= 0) {
            NSLog(@"%@倒计时",_countDownLastStr);
            //会有倒计时
        }else if (self.isremainTime) {
            //显示的是数字 12日12：12
            self.remainTimeString = [[HXBBaseHandDate sharedHandleDate] stringFromDate:_countDownLastStr andDateFormat:@"MM月dd日 HH:mm开售"];
        }
    }
    return _countDownLastStr;
}

- (BOOL)isCountDown {
    
    if ((kHXBUnitConversionToSeconds(self.diffTime.doubleValue)) <= kHXBHour && self.diffTime.doubleValue > 0) {
        _isCountDown = YES;
    } else {
        _isCountDown = NO;
    }
    return _isCountDown;
}

- (BOOL)isremainTime
{

    if ((kHXBUnitConversionToSeconds(self.diffTime.doubleValue)) > kHXBHour) {
        return YES;
    }
    return NO;
}

- (NSString *)cellBtnTitle
{
    if (self.diffTime.doubleValue < 0) {
        _cellBtnTitle = [self judgmentStateValue:self.unifyStatus];;
    }else if (self.isremainTime)
    {
        _cellBtnTitle = [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:self.beginSellingTime andDateFormat:@"MM月dd日 HH:mm开售"];
    }else
    {
        _cellBtnTitle = [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:self.diffTime andDateFormat:@"mm分ss秒后开始加入"];
    }

    return _cellBtnTitle;
}

- (void)setCountDownString:(NSString *)countDownString {
    if (!countDownString.integerValue && !self.remainTimeString) {
        self.isHidden = YES;
    }else {
        self.isHidden = NO;
    }
    _countDownString = [[HXBBaseHandDate sharedHandleDate] stringFromDate:countDownString andDateFormat:@"mm分ss秒后开始加入"];
}



- (NSString *)judgmentStateValue:(NSString *)unifyStatus
{
    switch ([unifyStatus integerValue]) {
        case 0:
        case 1:
        case 4:
        case 5:
            return [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:self.beginSellingTime andDateFormat:@"MM月dd日 HH:mm开售"];//等待预售开始超过60分
            break;
//        case 1:
//            return @"等待开放";//等待预售开始小于30分钟
//            break;
        case 2:
            return @"预定";//预定
            break;
        case 3:
            return @"预定满额";//预定满额
            break;
//        case 4:
//            return @"等待开放";//等待开放购买大于30分钟
//            break;
//        case 5:
//            return @"等待开放";//等待开放购买小于30分钟
//            break;
        case 6:
            return @"立即加入";
            break;
        case 7:
            return @"销售结束";
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
