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
//pageNumber	否	string	第几页（默认1）
//pageSize	否	string	每页数据条数（默认20）
//version	否	string	版本号（默认1.0）
//order	否	string	升序(ASC)降序（DESC）
//orderBy	否	string	需要排序的字段名称 （见下表）
@end
