//
//  HXBFinModel_AddRecortdModel_LoanTruansfer.h
//  hoomxb
//
//  Created by HXB on 2017/7/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseModel.h"

@interface HXBFinModel_AddRecortdModel_LoanTruansfer : HXBBaseModel
/**
 用户名
 */
@property (nonatomic,copy) NSString * userName;
@property (nonatomic,copy) NSString *userName_Hidden;
/**
 待收本金
 */
@property (nonatomic,copy) NSString * principal;
@property (nonatomic,copy) NSString * principal_YUAN;
@end
