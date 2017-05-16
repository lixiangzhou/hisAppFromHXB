//
//  HXBFinDatailModel_LoanDetail.m
//  hoomxb
//
//  Created by HXB on 2017/5/11.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinDatailModel_LoanDetail.h"

@implementation HXBFinDatailModel_LoanDetail

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"loanVo":[HXBFinDatailModel_LoanDetail_loanVo class],
             @"userLoanRecord":[HXBFinDatailModel_LoanDetail_userLoanRecord class],
             @"idCardInfo":[HXBFinDatailModel_LoanDetail_idCardInfo class],
             @"creditInfo":[HXBFinDatailModel_LoanDetail_creditInfo class],
             @"userVo":[HXBFinDatailModel_LoanDetail_userVo class]
             };
}
@end



@implementation HXBFinDatailModel_LoanDetail_loanVo
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}
@end


@implementation HXBFinDatailModel_LoanDetail_userLoanRecord
@end


@implementation HXBFinDatailModel_LoanDetail_idCardInfo
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}
@end


@implementation HXBFinDatailModel_LoanDetail_creditInfo
@end


@implementation HXBFinDatailModel_LoanDetail_userVo
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}
@end









