//
//  HXBFinanctingViewModel_PlanList.m
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinHomePageViewModel_PlanList.h"
#import "HXBFinHomePageModel_PlanList.h"
#import "HXBBaseHandDate.h"
#import "HXBColorMacro.h"
#import "HXBFontMacro.h"
#import "HXBScreenAdaptation.h"
/**
 * 关于代售状态的枚举
 */
typedef enum : NSUInteger {
    ///等待预售开始超过30分
    HXBFinHomePageViewModel_PlanList_BOOKFAR,
    ///等待预售开始小于30分钟
    HXBFinHomePageViewModel_PlanList_BOOKNEAR,
    ///预定
    HXBFinHomePageViewModel_PlanList_BOOK,
    ///预定满额
    HXBFinHomePageViewModel_PlanList_BOOKFULL,
    ///等待开放购买大于30分钟
    HXBFinHomePageViewModel_PlanList_WAIT_OPEN,
    ///等待开放购买小于30分钟
    HXBFinHomePageViewModel_PlanList_WAIT_RESERVE,
    ///开放加入
    HXBFinHomePageViewModel_PlanList_OPENING,
    ///加入满额
    HXBFinHomePageViewModel_PlanList_OPEN_FULL,
    ///收益中
    HXBFinHomePageViewModel_PlanList_PERIOD_LOCKING,
    ///开放期
    HXBFinHomePageViewModel_PlanList_PERIOD_OPEN,
    ///已退出
    HXBFinHomePageViewModel_PlanList_PERIOD_CLOSED,
} HXBFinHomePageViewModel_PlanList_Status;


@implementation HXBFinHomePageViewModel_PlanList



- (void)setPlanListModel:(HXBFinHomePageModel_PlanList *)planListModel {
    _planListModel = planListModel;
    [self setupExpectedYearRateAttributedStr];// 红利计划列表页的cell里面的年利率
}

- (void)setCountDownString:(NSString *)countDownString {
    _countDownString = countDownString;
    if (!countDownString.integerValue && !self.remainTimeString.length) {
        self.isHidden = YES;
    }else {
        self.isHidden = NO;
    }
//    _countDownString = [[HXBBaseHandDate sharedHandleDate] stringFromDate:countDownString andDateFormat:@"mm:ss"];
    _countDownLastStr = @(self.planListModel.diffTime.integerValue / 1000.0).description;
    if (_countDownLastStr.integerValue <= 3600 && _countDownLastStr.integerValue >= 0) {
        NSLog(@"%@倒计时",_countDownLastStr);
        self.isCountDown = YES;
        //会有倒计时
        _countDownString = [[HXBBaseHandDate sharedHandleDate] stringFromDate:countDownString andDateFormat:@"mm:ss"];
    }else if (_countDownLastStr.integerValue > 3600) {
        //显示的是数字 12日12：12
        NSDate *date = [[HXBBaseHandDate sharedHandleDate] returnDateWithOBJ:self.planListModel.beginSellingTime  andDateFormatter:@"yyyy-MM-dd HH:mm:ss"];
        NSString *datestr = @(date.timeIntervalSince1970).description;
        self.isHidden = NO;
        self.remainTimeString = [[HXBBaseHandDate sharedHandleDate] stringFromDate:datestr andDateFormat:@"dd日HH:mm"];
    }
}

// 期限
- (NSString *)lockPeriod {
    if (self.planListModel.lockPeriod.length) {
        return [NSString stringWithFormat:@"%@", self.planListModel.extendLockPeriod];
    }
    if (self.planListModel.lockDays) {
        return [NSString stringWithFormat:@"%d", self.planListModel.lockDays];
    }
    return  @"--";
}

- (PlanType)planType {
    if (self.planListModel.novice) {
        return planType_newComer;
    } else {
        if ([self.planListModel.cashType isEqualToString:@"HXB"]) {
            return playType_HXB;
        } else {
            return planType_invest;
        }
    }
}

#pragma mark - getter
//红利计划状态
- (NSString *)unifyStatus {
    return [self setupUnifyStatus];
}


//红利计划状态
- (NSString *)setupUnifyStatus {
   [self setupAddButtonColorWithType:YES];
    switch (self.planListModel.unifyStatus.integerValue) {
        case 0:
//            return @"等待预售开始超过30分";
        case 1:
//            return @"等待预售开始小于30分钟";
        case 2:
//            return @"预定";
        case 3:
//            return @"预定满额";
        case 4:
//            return @"等待开放购买大于30分钟";
        case 5:
//            return @"等待开放购买小于30分钟";
//            _isCountDown = YES;
            [self setupAddButtonColorWithType:YES];
            return @"等待加入";
        case 6:
            [self setupAddButtonColorWithType:NO];
            return @"立即加入";
        case 7:
        {
            NSString *str = nil;
//            /*
//             账户外：
//             1、	销售截止时间之前，如果满额：【已满额】。
//             2、	到销售截止时间之后，锁定期之前：【销售结束】。
//             */
//            CGFloat millisecond = [[HXBServerAndClientTime getCurrentTime_Millisecond] floatValue];
//            if (self.planListModel.endSellingTime.floatValue >= millisecond) {
//                str = @"已满额";
//            }else {
            str = @"销售结束"; //需求换了,现在只有销售结束
            [self setupAddButtonColorWithType:YES];
//            }
            return str;
        }
        case 8:
            [self setupAddButtonColorWithType:YES];
            return @"收益中";
        case 9:
            return @"开放期";
        case 10:
            [self setupAddButtonColorWithType:YES];
            return @"已退出";
    }
    return nil;
}
- (void)setupAddButtonColorWithType:(BOOL) isSelected {
    if (isSelected) {
        self.addButtonTitleColor = kHXBColor_Font0_6;
        self.addButtonBackgroundColor = kHXBColor_Grey090909;
        self.addButtonBorderColor = kHXBColor_Font0_5;
        return;
    }
    if (self.planListModel.novice) {
        self.addButtonBackgroundColor = kHXBColor_FF7D2F_100;
        self.addButtonBorderColor = kHXBColor_FF7D2F_100;
    } else {
        self.addButtonBackgroundColor = kHXBColor_Red_090303;
        self.addButtonBorderColor = kHXBColor_Red_090303;
    }
    self.addButtonTitleColor = [UIColor whiteColor];

}
//红利计划列表的年利率计算
- (void)setupExpectedYearRateAttributedStr {

    if (self.planListModel.novice && self.planListModel.expectedRate.floatValue) {
        NSString *numberStr = [NSString stringWithFormat:@"%.1lf%%",self.planListModel.expectedRate.floatValue];
        NSMutableAttributedString *numberAttributeString = [[NSMutableAttributedString alloc] initWithString:numberStr];
        if (self.planListModel.subsidyInterestRate.floatValue) {
            NSString *subsidyInterestRate = [NSString stringWithFormat:@"+%.1f%%",self.planListModel.subsidyInterestRate.doubleValue];
            NSMutableAttributedString *subsidyInterestRateAtt = [[NSMutableAttributedString alloc] initWithString:subsidyInterestRate];
            NSRange range = NSMakeRange(0, subsidyInterestRateAtt.length);
            UIFont *font = kHXBFont_PINGFANGSC_REGULAR(14);
            [subsidyInterestRateAtt addAttribute:NSFontAttributeName value:font range:range];
            [numberAttributeString appendAttributedString:subsidyInterestRateAtt];
        }
        // 新手利息为基准利率和贴息利率之和
        self.expectedYearRateAttributedStr = numberAttributeString;
        return;
    }
    NSString *numberStr = [NSString stringWithFormat:@"%.1lf%%",self.planListModel.baseInterestRate.floatValue];
    NSMutableAttributedString *numberAttributeString = [[NSMutableAttributedString alloc] initWithString:numberStr];
    //加息利率
    if (self.planListModel.extraInterestRate.floatValue) {
        NSString *extraInterestRateStr = [NSString stringWithFormat:@"+%.1f%%",self.planListModel.extraInterestRate.doubleValue];
        NSMutableAttributedString *extraInterestRate = [[NSMutableAttributedString alloc]initWithString:extraInterestRateStr];
        NSRange range = NSMakeRange(0, extraInterestRateStr.length);
        UIFont *font = kHXBFont_PINGFANGSC_REGULAR(14);
        [extraInterestRate addAttribute:NSFontAttributeName value:font range:range];
        //合并
        [numberAttributeString appendAttributedString:extraInterestRate];
        self.expectedYearRateAttributedStr = numberAttributeString;
    }
    self.expectedYearRateAttributedStr = numberAttributeString;
   
}

///监听是否倒计时了
- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
}
@end
