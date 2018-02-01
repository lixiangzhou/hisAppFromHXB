//
//  HXBFinHomePageViewModel_LoanList.m
//  hoomxb
//
//  Created by HXB on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinHomePageViewModel_LoanList.h"
#import "HXBFinHomePageModel_LoanList.h"
/**
 * 状态枚举
 */
typedef enum : NSUInteger {
    ///投标中
    HXBFinHomePageViewModel_LoanList_OPEN,
    ///已满标
    HXBFinHomePageViewModel_LoanList_READY,
    ///已流标
    HXBFinHomePageViewModel_LoanList_FAILED,
    ///收益中
    HXBFinHomePageViewModel_LoanList_IN_PROGRESS,
    ///逾期
    HXBFinHomePageViewModel_LoanList_OVER_DUE,
    ///坏账
    HXBFinHomePageViewModel_LoanList_BAD_DEBT,
    ///已结清
    HXBFinHomePageViewModel_LoanList_CLOSED,
    ///新申请
    HXBFinHomePageViewModel_LoanList_FIRST_APPLY,
    ///已满标
    HXBFinHomePageViewModel_LoanList_FIRST_READY,
    ///预售
    HXBFinHomePageViewModel_LoanList_PRE_SALES,
    ///等待招标
    HXBFinHomePageViewModel_LoanList_WAIT_OPEN,
    ///放款中
    HXBFinHomePageViewModel_LoanList_FANGBIAO_PROCESSING,
    ///流标中
    HXBFinHomePageViewModel_LoanList_LIUBIAO_PROCESSING,
} HXBFinHomePageViewModel_LoanList_TYPE;

@implementation HXBFinHomePageViewModel_LoanList
- (void) setLoanListModel:(HXBFinHomePageModel_LoanList *)loanListModel {
    _loanListModel = loanListModel;
    //状态的处理
    [self setupStatusWithLoanListModelStatus:loanListModel.status];
    NSString *str = [NSString stringWithFormat:@"%.2f%%",loanListModel.interest.floatValue];
    self.expectedYearRateAttributedStr = [self setupExpectedYearRateAttributedStrWithStr:str  WithFont:kHXBFont_PINGFANGSC_REGULAR(24) andColor:kHXBColor_Red_090202 andRange:NSMakeRange(0, str.length)];
}



///状态的处理
- (void)setupStatusWithLoanListModelStatus: (NSString *) status{
    [self setUPAddButtonColorWithType:YES];
    if ([status isEqualToString:@"OPEN"]) {
        self.status = @"立即投标";//投标中
        [self setUPAddButtonColorWithType:NO];
    }
    
    if ([status isEqualToString:@"READY"]) self.status = @"已满标";//已满标
    if ([status isEqualToString:@"FAILED"]) self.status = @"已流标";//已流标
    if ([status isEqualToString:@"IN_PROGRESS"]) self.status = @"收益中";//收益中
    if ([status isEqualToString:@"OVER_DUE"]) self.status = @"逾期";//逾期
    if ([status isEqualToString:@"BAD_DEBT"]) self.status = @"坏账";//坏账
    if ([status isEqualToString:@"CLOSED"]) self.status = @"";//已结清
    if ([status isEqualToString:@"FIRST_APPLY"]) self.status = @"新申请";//新申请
    if ([status isEqualToString:@"FIRST_READY"]) self.status = @"已满标";//已满标
    if ([status isEqualToString:@"PRE_SALES"]) self.status = @"预售"; //预售
    if ([status isEqualToString:@"WAIT_OPEN"]) self.status = @"等待招标";//等待招标
    if ([status isEqualToString:@"FANGBIAO_PROCESSING"]) self.status = @"放款中";//放款中
    if ([status isEqualToString:@"LIUBIAO_PROCESSING"]) self.status = @"流标中";//流标中
}
- (void)setUPAddButtonColorWithType:(BOOL) isSelected {
    if (isSelected) {
        self.addButtonTitleColor = kHXBColor_Font0_6;
        self.addButtonBackgroundColor = kHXBColor_Grey090909;
        self.addButtonBorderColor = kHXBColor_Font0_5;
        return;
    }
    self.addButtonTitleColor = [UIColor whiteColor];
    self.addButtonBackgroundColor = kHXBColor_Red_090303;
    self.addButtonBorderColor = kHXBColor_Red_090303;
    
}

- (NSMutableAttributedString *)setupExpectedYearRateAttributedStrWithStr: (NSString *)str WithFont: (UIFont *)font andColor: (UIColor *)color andRange: (NSRange)range{
    NSMutableAttributedString *expecetedAttributedStr = [[NSMutableAttributedString alloc]initWithString:str];
    [expecetedAttributedStr addAttribute:NSFontAttributeName value:font range:range];
    [expecetedAttributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    return expecetedAttributedStr;
}



@end
