//
//  FinModel_AddRecortdModel_Loan.h
//  hoomxb
//
//  Created by HXB on 2017/5/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXBFinModel_AddRecortdModel_loanLenderRecord_list_Loan;
@interface FinModel_AddRecortdModel_Loan : NSObject

///	int	记录总条数
@property (nonatomic,copy) NSString *joinCount;

@property (nonatomic,copy) NSString *myJoinCount;
@property (nonatomic,strong) NSArray <HXBFinModel_AddRecortdModel_loanLenderRecord_list_Loan *> *loanLenderRecord_list;
@end


@interface HXBFinModel_AddRecortdModel_loanLenderRecord_list_Loan : NSObject
///	int	投资人名称
@property (nonatomic,copy) NSString *username;
///	int	投资金额
@property (nonatomic,copy) NSString *amount;
///	int	投资时间
@property (nonatomic,copy) NSString *lendTime;

///": -2,
@property (nonatomic,copy) NSString *index;
///": "NORMAL_BID",
@property (nonatomic,copy) NSString *loanLenderType;
///": "ALL"
@property (nonatomic,copy) NSString *type;
@end

