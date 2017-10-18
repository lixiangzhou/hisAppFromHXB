//
//  HXBFinModel_AddRecortdModel_LoanTruansfer.h
//  hoomxb
//
//  Created by HXB on 2017/7/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseModel.h"

@interface HXBFinModel_AddRecortdModel_LoanTruansfer : HXBBaseModel
/**
债权出售人
 */
@property (nonatomic,copy) NSString *fromUserId;
/**
债权购买人
 */
@property (nonatomic,copy) NSString *toUserId;
/**
 债权出售人名字
 */
@property (nonatomic,copy) NSString *fromUserName;
/**
 债权购买人名字
 */
@property (nonatomic,copy) NSString *toUserName;
/**
交易金额
 */
@property (nonatomic,copy) NSString *amount;
/**
转让时间
 */
@property (nonatomic,copy) NSString *createTime;

@property (nonatomic,copy) NSString *index;
@end
