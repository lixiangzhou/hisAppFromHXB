//
//  HXBFinModel_BuyResoult_LoanModel.h
//  hoomxb
//
//  Created by HXB on 2017/6/21.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class
HXBFinModel_BuyResoult_LoanModel_StateInput,
HXBFinModel_BuyResoult_LoanModel_Context,
HXBFinModel_BuyResoult_LoanModel_Context_TransInput
;
@interface HXBFinModel_BuyResoult_LoanModel : NSObject



@property (nonatomic,copy) NSString *orderNo;///": "1111L0053764770601142044HG34YGTI",
///输入状态
@property (nonatomic,strong) HXBFinModel_BuyResoult_LoanModel_StateInput *stateInput;///
///context
@property (nonatomic,strong) HXBFinModel_BuyResoult_LoanModel_Context *context;

@end


@interface HXBFinModel_BuyResoult_LoanModel_StateInput : NSObject

/// ": "100",
@property (nonatomic,copy) NSString *amount;
///贸易方式类型": "PC",
@property (nonatomic,copy) NSString *tradeMethodType;
///订单号 ": "1111L0053764770601142044HG34YGTI",
@property (nonatomic,copy) NSString *orderNo;
///托管式输出式 ": "S",
@property (nonatomic,copy) NSString *escrowTransOutputType;
///": 5376477,
@property (nonatomic,copy) NSString *userId;
///": false,
@property (nonatomic,copy) NSString *isAuto;
///": 761025
@property (nonatomic,copy) NSString *loanId;
@end

@interface HXBFinModel_BuyResoult_LoanModel_Context : NSObject
///':'L761025',
@property (nonatomic,copy) NSString *prdCode;
///':'人人U学1号标',
@property (nonatomic,copy) NSString *prdName;
///':'100.0','redAmt':'0',
@property (nonatomic,copy) NSString *amt;
///':'0'[,
@property (nonatomic,copy) NSString *loanerUsrId;
///':'',
@property (nonatomic,copy) NSString *loanerAcc;
///':null,
@property (nonatomic,copy) NSString *loanerName;
///':null,
@property (nonatomic,copy) NSString *feeCode1;
///':null,
@property (nonatomic,copy) NSString *feeName1;
///':null,
@property (nonatomic,copy) NSString *fee1;
///':null,
@property (nonatomic,copy) NSString *feeCode2;
///':null,
@property (nonatomic,copy) NSString *feeName2;
///':null,
@property (nonatomic,copy) NSString *fee2;
///':null,
@property (nonatomic,copy) NSString *feeCode3;
///':null,
@property (nonatomic,copy) NSString *feeName3;
///':null,
@property (nonatomic,copy) NSString *fee3;
///':'1',
@property (nonatomic,copy) NSString *frozenFlag;

@property (nonatomic,strong) HXBFinModel_BuyResoult_LoanModel_Context_TransInput *transInput;


@end


@interface HXBFinModel_BuyResoult_LoanModel_Context_TransInput : NSObject
@property (nonatomic,copy) NSString *version;
///orderId 订单':'',
@property (nonatomic,copy) NSString *orderId;
///安全 ':'1111L0053764770601142044HG34YGTI',
@property (nonatomic,copy) NSString *secuNo;
///反式 编码':'0007',
@property (nonatomic,copy) NSString *transCode;
///':'P2P_T000011',
@property (nonatomic,copy) NSString *usrId;
///基金会 ':'0',
@property (nonatomic,copy) NSString *fundAcc;
///字符集':'',
@property (nonatomic,copy) NSString *charSet;
///优先级域 ':'UTF-8',
@property (nonatomic,copy) NSString *priDomain;
///通知URL':'',
@property (nonatomic,copy) NSString *notifyUrl;
///':'http://localhost:26131/loanBid/callback',
///返回的URL
@property (nonatomic,copy) NSString *returnUrl;
///通道':'http://localhost/trade/confirm.action?orderId\\u003d1111L0053764770601142044HG34YGTI\\u0026tradeType\\u003dL\\u0026bussinessId\\u003d761025',
@property (nonatomic,copy) NSString *channel;
///分支':'',
@property (nonatomic,copy) NSString *branchNo;
// 操作':'',
@property (nonatomic,copy) NSString *operNo;
///':'',
@property (nonatomic,copy) NSString *transDate;
///':'20170601',
@property (nonatomic,copy) NSString *transTime;
///':'142044',
@property (nonatomic,copy) NSString *remark;
///储备':'',
@property (nonatomic,copy) NSString *reserve1;
///':'',
@property (nonatomic,copy) NSString *reserve2;
///':'{loanId:761025,userId:5376477}'
@end

@interface  HXBFinModel_BuyResoult_LoanModel_Context_TransInput_reserve2 : NSObject
///:761025,
@property (nonatomic,copy) NSString *loanId;
///:5376477
@property (nonatomic,copy) NSString *userId;
@end
