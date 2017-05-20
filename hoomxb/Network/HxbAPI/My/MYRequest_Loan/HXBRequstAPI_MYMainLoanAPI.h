//
//  HXBRequstAPI_MYMainLoanAPI.h
//  hoomxb
//
//  Created by HXB on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "NYBaseRequest.h"
#import "HXBRequestType_MYManager.h"
///关于  我的 loanlist api
@interface HXBRequstAPI_MYMainLoanAPI : NYBaseRequest
@property (nonatomic,assign) BOOL isUPData;

///请求的类型
@property (nonatomic,assign) HXBRequestType_MY_LoanRequestType requestType;
@end
