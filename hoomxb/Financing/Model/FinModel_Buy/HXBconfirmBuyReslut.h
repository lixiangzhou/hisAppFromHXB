//
//  HXBconfirmBuyReslut.h
//  hoomxb
//
//  Created by HXB on 2017/6/16.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXBconfirmBuyReslut_context;
@class HXBconfirmBuyReslut_stateInput;
@class HXBconfirmBuyReslut_context_transInput;
@class HXBconfirmBuyReslut_context_transInput_reserve2;


@interface HXBconfirmBuyReslut : NSObject
@property (nonatomic,copy) NSString *orderNo;
@property (nonatomic,strong) HXBconfirmBuyReslut_context *context;
@property (nonatomic,strong) HXBconfirmBuyReslut_stateInput *stateInput;
@end


@interface HXBconfirmBuyReslut_stateInput: NSObject
///": "100",
@property (nonatomic,copy) NSString *amount;
///;///": "PC",
@property (nonatomic,copy) NSString *tradeMethodType;
///;///": "1111L0053764770601142044HG34YGTI",
@property (nonatomic,copy) NSString *orderNo;
///;///": "S",
@property (nonatomic,copy) NSString *escrowTransOutputType;
///": 5376477,
@property (nonatomic,copy) NSString *userId;
///": false,
@property (nonatomic,copy) NSString *isAuto;
///": 761025
@property (nonatomic,copy) NSString *loanId;

@end

@interface HXBconfirmBuyReslut_context : NSObject
///':'L761025',
@property (nonatomic,copy) NSString *prdCode;
///':'人人U学1号标',
@property (nonatomic,copy) NSString *prdName;
///':'100.0',
@property (nonatomic,copy) NSString *amt;
///':'0',
@property (nonatomic,copy) NSString *redAmt;
///':'0',
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
///':
@property (nonatomic,strong) HXBconfirmBuyReslut_context_transInput *transInput;
@end

@interface HXBconfirmBuyReslut_context_transInput : NSObject
///':'',
@property (nonatomic,copy) NSString *version;
///':'1111L0053764770601142044HG34YGTI',
@property (nonatomic,copy) NSString *orderId;
///':'0007',
@property (nonatomic,copy) NSString *secuNo;
///':'P2P_T000011',
@property (nonatomic,copy) NSString *transCode;
///':'0'
@property (nonatomic,copy) NSString *usrId;
///':'',
@property (nonatomic,copy) NSString *fundAcc;
///':'UTF-8',
@property (nonatomic,copy) NSString *charSet;
///':'',
@property (nonatomic,copy) NSString *priDomain;
///':'http://localhost:26131/loanBid/callback',
@property (nonatomic,copy) NSString *notifyUrl;
///':'http://localhost/trade/confirm.action?orderId\\u003d1111L0053764770601142044HG34YGTI\\u0026tradeType\\u003dL\\u0026bussinessId\\u003d761025',
@property (nonatomic,copy) NSString *returnUrl;
///':'',
@property (nonatomic,copy) NSString *channel;
///':'',
@property (nonatomic,copy) NSString *branchNo;
///':'',
@property (nonatomic,copy) NSString *operNo;
///':'20170601',
@property (nonatomic,copy) NSString *transDate;
///':'142044',
@property (nonatomic,copy) NSString *transTime;
///':'',
@property (nonatomic,copy) NSString *remark;
///':'',
@property (nonatomic,copy) NSString *reserve1;
///':'
@property (nonatomic,strong) HXBconfirmBuyReslut_context_transInput_reserve2 *reserve2;
@end
@interface HXBconfirmBuyReslut_context_transInput_reserve2 : NSObject
@property (nonatomic,copy) NSString *loanId;///:761025,
@property (nonatomic,copy) NSString *userId;///:5376477

@end
