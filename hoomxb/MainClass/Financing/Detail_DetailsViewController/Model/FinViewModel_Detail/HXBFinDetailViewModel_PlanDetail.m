//
//  HXBFinDetailViewModel_PlanDetail.m
//  hoomxb
//
//  Created by HXB on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinDetailViewModel_PlanDetail.h"
#import "HXBFinDetailModel_PlanDetail.h"
@implementation HXBFinDetailViewModel_PlanDetail
- (void)setPlanDetailModel:(HXBFinDetailModel_PlanDetail *)planDetailModel {
    _planDetailModel = planDetailModel;

    [self setUPLockPeriod];///计划期限
    [self setUPUserRemainAmount];///剩余可追加金额
    [self setUPhxb_SingleMaxRegisterAmount];///本期计划加入上限
    [self setAddButtonStrValue];
}
-(NSString *)extendLockPeriod {
    if (self.planDetailModel.extendLockPeriod) {
        return [NSString stringWithFormat:@"%@个月",self.planDetailModel.extendLockPeriod];
    }
    return @"--";
}
///**
// 用户余额
// */
//- (NSString *) userRemainAmount {
//    if (!_userRemainAmount) {
//        _userRemainAmount = self.planDetailModel.userRemainAmount;
//    }
//    return _userRemainAmount;
//}
///**
// 剩余金额
// */
//- (NSString *) remainAmount {
//    if (!_remainAmount) {
//        _remainAmount = self.planDetailModel.remainAmount;
//    }
//    return _remainAmount;
//}
/**
 id
 */
- (NSString *) ID {
    if (!_ID) {
        _ID = self.planDetailModel.ID;
    }
    return _ID;
}
//加入上线
- (NSString *)singleMaxRegisterAmount {
    if (!_singleMaxRegisterAmount) {
        _singleMaxRegisterAmount = [NSString hxb_getPerMilWithIntegetNumber: self.planDetailModel.singleMaxRegisterAmount.doubleValue];
//        _singleMaxRegisterAmount = self.planDetailModel.remainAmount < self.planDetailModel.userRemainAmount ? self.planDetailModel.remainAmount : self.planDetailModel.userRemainAmount;
    }
    return _singleMaxRegisterAmount;
}

/**
 开始收益
 */
/**
 开始时间
 */
- (NSString *) beginSellingTime {
    if (!_beginSellingTime) {
        NSDate *date = [[HXBBaseHandDate sharedHandleDate] returnDateWithOBJ:self.planDetailModel.beginSellingTime andDateFormatter: @"yyyy-MM-dd HH:mm:ss"];
        _beginSellingTime = [[HXBBaseHandDate sharedHandleDate] stringFromDate:date andDateFormat:@"yyyy-MM-dd"];
    }
    return _beginSellingTime;
}

///退出时间
/**
开始收益时间
 */
- (NSString *) financeEndTime {
    if (!_financeEndTime) {
        NSDate *date = [[HXBBaseHandDate sharedHandleDate] returnDateWithOBJ:self.planDetailModel.endLockingTime andDateFormatter: @"yyyy-MM-dd HH:mm:ss"];
        _financeEndTime = [[HXBBaseHandDate sharedHandleDate] stringFromDate:date andDateFormat:@"yyyy-MM-dd"];
    }
    return _financeEndTime;
}

/**
 退出时间
 */
- (NSString *) endLockingTime_flow {
    if (!_endLockingTime_flow) {
        NSDate *date = [[HXBBaseHandDate sharedHandleDate] returnDateWithOBJ:self.planDetailModel.endLockingTime andDateFormatter: @"yyyy-MM-dd HH:mm:ss"];
        _endLockingTime_flow = [[HXBBaseHandDate sharedHandleDate] stringFromDate:date andDateFormat:@"yyyy-MM-dd"];
    }
    return _endLockingTime_flow;
}

/*
 开始收益时间 流程
 **/
- (NSString *) financeEndTime_flow {
    if (!_financeEndTime_flow) {
        NSDate *date = [[HXBBaseHandDate sharedHandleDate] returnDateWithOBJ:self.planDetailModel.financeEndTime andDateFormatter: @"yyyy-MM-dd HH:mm:ss"];
        _financeEndTime_flow  = [[HXBBaseHandDate sharedHandleDate] stringFromDate:date andDateFormat:@"MM-dd HH:mm"];
    }
    return _financeEndTime_flow;
}


/**
 开始加入时间
 */
- (NSString *) beginSellingTime_flow {
    if (!_beginSellingTime_flow) {
        NSDate *date =  [[HXBBaseHandDate sharedHandleDate] returnDateWithOBJ:self.planDetailModel.beginSellingTime andDateFormatter: @"yyyy-MM-dd HH:mm:ss"];
       _beginSellingTime_flow = [[HXBBaseHandDate sharedHandleDate] stringFromDate:date andDateFormat:@"MM-dd HH:mm"];
    }
    return _beginSellingTime_flow;
}

- (NSString *)description {
    return [self yy_modelDescription];
}
///计划期限（锁定期）
- (void)setUPLockPeriod {
    NSString *lockStr = [self.planDetailModel.novice isEqualToString:@"1"]&&self.planDetailModel.lockDays ? [NSString stringWithFormat: @"%@天",self.planDetailModel.lockDays] : [NSString stringWithFormat: @"%@个月",self.planDetailModel.lockPeriod];
    self.lockPeriod = lockStr;
}

/**
服务协议
 */
- (NSString *) contractName {
    if (!_contractName) {
        _contractName = @"《红利智投服务协议》";
    }
    return _contractName;
}
//- (NSString *) contractURL {
//    if (!_contractURL) {
//        _contractURL = kHXB_Negotiate_ServePlanURL;
//    }
//    return _contractURL;
//}
/**
 剩余金额 const
 */

/**
 剩余可投
 */
//- (NSString *) remainAmount  {
//    //剩余金额：不为0时显示剩余金额，为0时或状态不为可加入时，该字段变为【计划总金额：XXXXXX】
//    if (!_remainAmount) {
//     
//        if (self.planDetailModel.remainAmount.floatValue <= 0) {
//            _remainAmount = [NSString hxb_getPerMilWithDouble:self.planDetailModel.amount.floatValue];
//            _remainAmount_constStr = @"计划总金额";
//        } else {
//            _remainAmount = [NSString hxb_getPerMilWithDouble:self.planDetailModel.remainAmount.floatValue];
//            _remainAmount_constStr = @"剩余金额";
//        }
//    }
//    return _remainAmount;
//}



///剩余可追加金额
- (void)setUPUserRemainAmount {
    self.userRemainAmount = [NSString hxb_getPerMilWithDouble:self.planDetailModel.userRemainAmount.doubleValue];
}

///加入上线
- (void)setUPhxb_SingleMaxRegisterAmount {
    ///本期计划加入上线//1.加入上限：金额随用户实际的可加入金额变动，e.g.用户第一次投该期红利计划，显示为“本期计划加入上限50,000元”,用户投资30000元后，第二次追加进到该页面，显示“本期计划加入上限20,000元”，加入上限>计划剩余可投资金额时，显示计划剩余可投资金额
//    if (!self.planDetailModel.joinCount.integerValue) {
//        self.hxb_singleMaxRegisterAmount = @"本期计划加入上限50,000元";
//    }
//    if (self.planDetailModel.joinCount.integerValue == 1) {
//        self.hxb_singleMaxRegisterAmount = @"本期计划加入上限20,000元";
//    }
    NSString *str = [NSString hxb_getPerMilWithDouble:self.singleMaxRegisterAmount.doubleValue];
    self.hxb_singleMaxRegisterAmount = [NSString stringWithFormat:@"本期加入上限%@元",str];
}

- (void)setAddButtonStrValue {
    self.isAddButtonInteraction = NO;
    [self setUPAddButtonColorWithType:YES];
    switch ([self.planDetailModel.unifyStatus integerValue]) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
            self.isAddButtonInteraction = NO;
            self.addButtonStr = @"等待加入";
            break;
            
        case 6:
            [self setUPAddButtonColorWithType:NO];
            self.addButtonStr = @"立即加入";
            self.isAddButtonInteraction = YES;
            if (self.planDetailModel.isFirst.integerValue) {
                self.addButtonStr = @"立即加入";
                self.isAddButtonInteraction = YES;
            } else {
                if (self.planDetailModel.isAllowedRepeatPurchase) {
                    self.addButtonStr = @"追加";
                    self.isAddButtonInteraction = YES;
                } else {
                    self.addButtonStr = @"暂不支持重复购买";
                    [self setUPAddButtonColorWithType:YES];
                    self.isAddButtonInteraction = NO;
                }
            }
            break;
            
        case 7:{
            /*
             账户外：
             1、	销售截止时间之前，如果满额：【已满额】。
             2、	到销售截止时间之后，锁定期之前：【销售结束】。
             */
//            CGFloat millisecond = [[HXBServerAndClientTime getCurrentTime_Millisecond] doubleValue];
//            if (self.planDetailModel.endSellingTime.floatValue >= millisecond) {
//                self.addButtonStr = @"已满额";
//            }else {//需求更改
                self.addButtonStr = @"销售结束";
//            }
            self.isAddButtonInteraction = NO;
        }
            break;
        case 8:
            self.addButtonStr = @"收益中";
            self.isAddButtonInteraction = NO;
            break;
        case 9:
            self.addButtonStr = @"开放期";
            self.isAddButtonInteraction = NO;
            break;
        case 10:
            self.addButtonStr = @"已退出";
            self.isAddButtonInteraction = NO;
            break;
    }
    switch ([self.planDetailModel.unifyStatus integerValue]) {
        case 6://立即加入或者  追加
        case 5:
            if (self.planDetailModel.remainAmount.doubleValue <= 0) {
                _remainAmount = [NSString hxb_getPerMilWithIntegetNumber:self.planDetailModel.amount];
                _remainAmount_constStr = @"总金额";
            } else {
                _remainAmount = [NSString hxb_getPerMilWithIntegetNumber:self.planDetailModel.remainAmount.doubleValue];
                _remainAmount_constStr = @"剩余金额";
            }
            break;
            
        default:
            _remainAmount = [NSString hxb_getPerMilWithIntegetNumber:self.planDetailModel.amount];
            _remainAmount_constStr = @"总金额";
            break;
    }
}
- (void)setUPAddButtonColorWithType:(BOOL) isSelected {
    if (isSelected) {
        ///设置addbutton的颜色
        self.isAddButtonInteraction = YES;
        self.addButtonTitleColor = [UIColor whiteColor];
        self.addButtonBackgroundColor = COR26;
        self.addButtonBorderColor = kHXBColor_Grey_Font0_2;
        return;
    }
    self.isAddButtonInteraction = NO;
    self.addButtonTitleColor = [UIColor whiteColor];
    self.addButtonBackgroundColor = kHXBColor_Red_090303;
    self.addButtonBorderColor = kHXBColor_Red_090303;
}



/**
 投标下线
 */
- (NSString *) minRegisterAmount {
    if (!_minRegisterAmount) {
        _minRegisterAmount = self.planDetailModel.minRegisterAmount;
    }
    return _minRegisterAmount;
}
/**
 加入条件
 */
- (NSString *)addCondition {
    if (!_addCondition) {
        if (self.planDetailModel.isFirst.integerValue) {
            _addCondition = [NSString stringWithFormat:@"%@起投，%@递增",[NSString hxb_getPerMilWithIntegetNumber:self.minRegisterAmount.doubleValue],[NSString hxb_getPerMilWithIntegetNumber:self.planDetailModel.registerMultipleAmount.doubleValue]];
        } else {
            _addCondition = [NSString stringWithFormat:@"%@的倍数递增",[NSString hxb_getPerMilWithIntegetNumber:self.planDetailModel.registerMultipleAmount.doubleValue]];
            
        }
    }
    return _addCondition;
}
/**
 加入条件
 */
- (NSString *)addCondition_detail {
    if (self.minRegisterAmount.length && self.planDetailModel.registerMultipleAmount.length) {
        _addCondition_detail = [NSString stringWithFormat:@"%@起投，%@递增",[NSString hxb_getPerMilWithIntegetNumber:self.minRegisterAmount.doubleValue],[NSString hxb_getPerMilWithIntegetNumber:self.planDetailModel.registerMultipleAmount.doubleValue]];
    } else {
        _addCondition_detail = @"--起投，--递增";
    }
    return _addCondition_detail;
}

/**
 加入方式
 */
- (NSString *) profitType_UI {
    if (!_profitType_UI) {
        _profitType_UI = @"收益复投";
    }
    return _profitType_UI;
}
/**
  ///	string	处理方式 （HXB：当日提取至红小宝账户，INVEST：收益再投资）
 */
- (NSString *) profitType {
    if (!_profitType) {
        _profitType = @"INVEST";
    }
    return _profitType;
}

/**
 已经收益
 */
- (NSString *) earnInterest {
    if (!_earnInterest) {
        _earnInterest = self.planDetailModel.earnInterest;
    }
    return _earnInterest;
}
/**
 预期收益比例
 */
- (NSString *) totalInterest {
    if (!_totalInterest) {
        _totalInterest = self.planDetailModel.totalInterest;
    }
    return _totalInterest;
}
/**
 计划期限
 */
- (NSString *) lockPeriodStr {
    if (!_lockPeriodStr) {
        _lockPeriodStr = self.planDetailModel.lockPeriodStr;
    }
    return _lockPeriodStr;
}
/**
 剩余时间
 */
- (NSString *) countDownStr {
    if (!_countDownStr) {
        _countDownStr = @(self.planDetailModel.diffTime.integerValue / 1000.0).description;
        if (_countDownStr.integerValue <= 3600 && _countDownStr.integerValue >= 0) {
            NSLog(@"%@倒计时",_countDownStr);
            self.isContDown = YES;
            //会有倒计时
        }else if (_countDownStr.integerValue > 3600) {
//            显示的是数字 12日12：12
            self.isContDown = NO;
            NSDate *date = [[HXBBaseHandDate sharedHandleDate] returnDateWithOBJ:self.planDetailModel.beginSellingTime  andDateFormatter:nil];
            self.remainTimeString = [[HXBBaseHandDate sharedHandleDate] stringFromDate:date andDateFormat:@"MM月dd日 HH:mm开售"];
        }
    }
    
    return _countDownStr;
}

@end
