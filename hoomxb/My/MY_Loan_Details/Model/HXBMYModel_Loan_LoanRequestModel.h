//
//  HXBMYModel_Loan_LoanRequestModel.h
//  hoomxb
//
//  Created by HXB on 2017/6/30.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
///账户内散标资产接口
@interface HXBMYModel_Loan_LoanRequestModel : NSObject
/**
 int	持有资产(元)
 */
@property (nonatomic,copy) NSString * loanlenderPrincipal;
/**
 累计收益(元)
 */
@property (nonatomic,copy) NSString * loanlenderEarned;
/**
 收益中
 */
@property (nonatomic,copy) NSString * rePayingTotalCount;
/**
 投标中
 */
@property (nonatomic,copy) NSString * BIDTotalCount;
/**
 	已结清;
 */
@property (nonatomic,copy) NSString * finishTotalCount;
/**
 转让中
 */
@property (nonatomic,copy) NSString *transferingCount;
@end
