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
    
    [self calNameAttributeString];
    [self calTagAttributeString];
    [self setupExpectedYearRateAttributedStr];// 红利计划列表页的cell里面的年利率
    [self calHapppyNeed];
}

- (void)calHapppyNeed {
    self.hasHappyThing = self.planListModel.hasDiscountCoupon || self.planListModel.hasMoneyOffCoupon;
}

- (void)calTagAttributeString {
    if (self.planListModel.tag.length > 0) {
        NSMutableAttributedString *tagAttributeString = [NSMutableAttributedString new];
        [tagAttributeString appendAttributedString:[[NSAttributedString alloc] initWithString:@"  "]];
        
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        attachment.image = [UIImage imageNamed:@"tag_present"];
        attachment.bounds = CGRectMake(0, -2, attachment.image.size.width, attachment.image.size.height);
        [tagAttributeString appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
        [tagAttributeString appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
        [tagAttributeString appendAttributedString:[[NSAttributedString alloc] initWithString:self.planListModel.tag]];
        [tagAttributeString appendAttributedString:[[NSAttributedString alloc] initWithString:@"  "]];
        self.tagAttributeString = tagAttributeString;
    } else {
        self.tagAttributeString = [[NSAttributedString alloc] initWithString:@""];
    }
}

- (void)calNameAttributeString {
    NSString *periodString = @"";
    if (self.planListModel.lockPeriod.integerValue <= 3) {
        periodString = @"短期";
    } else if (self.planListModel.lockPeriod.integerValue <= 6) {
        periodString = @"中期";
    } else if (self.planListModel.lockPeriod.integerValue <= 12) {
        periodString = @"中长期";
    } else {
        periodString = @"长期";
    }
    NSMutableAttributedString *nameAttributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@-%@个月", periodString, self.planListModel.lockPeriod] attributes:@{NSFontAttributeName: kHXBFont_28, NSForegroundColorAttributeName: kHXBColor_333333_100}];
    [nameAttributeString appendAttributedString:[[NSAttributedString alloc] initWithString:@" | " attributes:@{NSFontAttributeName: kHXBFont_28, NSForegroundColorAttributeName: kHXBColor_D8D8D8_100}]];
    [nameAttributeString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元起投", self.planListModel.minRegisterAmount] attributes:@{NSFontAttributeName: kHXBFont_24, NSForegroundColorAttributeName: kHXBColor_333333_100}]];
    _nameAttributeString = nameAttributeString;
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
    self.isCountDown = NO;
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
- (NSAttributedString *)lockPeriod {
    NSString *lock = nil;
    if (self.planListModel.lockPeriod.length) {
        if (self.planListModel.novice == 1) {
            lock = self.planListModel.lockPeriod;
        } else {
            lock = self.planListModel.extendLockPeriod;
        }
    } else if (self.planListModel.lockDays) {
        lock = [NSString stringWithFormat:@"%d", self.planListModel.lockDays];
    }
    
    if (lock) {
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:lock attributes:@{NSFontAttributeName: kHXBFont_34}];
        [attr appendAttributedString:[[NSAttributedString alloc] initWithString:@"个月" attributes:@{NSFontAttributeName: kHXBFont_24}]];
        return attr;
    }
    
    return [[NSMutableAttributedString alloc] initWithString:@"--" attributes:@{NSFontAttributeName: kHXBFont_34}];;
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
        case 11:
            [self setupAddButtonColorWithType:YES];
            return @"退出中";
    }
    return nil;
}
- (void)setupAddButtonColorWithType:(BOOL) isSelected {
    if (isSelected) {
        self.addButtonTitleColor = UIColorFromRGB(0x9295A2);
        self.addButtonBackgroundImage = [UIImage imageNamed:@"list_bt_bg_dis"];
        return;
    } else {
        self.addButtonBackgroundImage = [UIImage imageNamed:@"bt_bg_nor"];
        self.addButtonTitleColor = [UIColor whiteColor];
    }
}
//红利计划列表的年利率计算
- (void)setupExpectedYearRateAttributedStr {

    if (self.planListModel.novice && self.planListModel.expectedRate.floatValue) {
        NSString *numberStr = [NSString stringWithFormat:@"%.1f%%",self.planListModel.expectedRate.floatValue];
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
    } else {
        NSString *numberStr = [NSString stringWithFormat:@"%.1f%%",self.planListModel.baseInterestRate.floatValue];
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
        } else {
            self.expectedYearRateAttributedStr = numberAttributeString;
        }
    }
}

///监听是否倒计时了
- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
}
@end
