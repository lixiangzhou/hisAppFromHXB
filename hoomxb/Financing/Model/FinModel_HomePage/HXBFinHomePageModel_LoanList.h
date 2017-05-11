//
//  HXBFinHomePageModel_LoanList.h
//  hoomxb
//
//  Created by HXB on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBFinHomePageModel_LoanList : NSObject

///总金额,本期开放的额度,计划金额（元）
@property (nonatomic,copy) NSString *amount;
///锁定期限(月),计划期限
@property (nonatomic,copy) NSString *months;
///计划名称
@property (nonatomic,copy) NSString *title;
///状态
@property (nonatomic,copy) NSString *status;
///兴趣
@property (nonatomic,copy) NSString *interest;
///证书类型
@property (nonatomic,copy) NSString *certificateType;
///借款人的水平
@property (nonatomic,copy) NSString *borrowerLevel;
///成品率
@property (nonatomic,copy) NSString *finishedRatio;
///贷款ID
@property (nonatomic,copy) NSString *loanId;
@end
