//
//  HXBWithdrawRecordModel.h
//  hoomxb
//
//  Created by HXB-C on 2017/10/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBWithdrawRecordModel : NSObject

/**
 银行名称
*/
@property (nonatomic, copy) NSString *bankName;
/**
 提现状态对应文案描述
 */
@property (nonatomic, copy) NSString *cashDrawName;
/**
 预计到账时间
 */
@property (nonatomic, copy) NSString *arrivalTime;
/**
 银行编码
 */
@property (nonatomic, copy) NSString *bankCode;
/**
 提现申请时间
 */
@property (nonatomic, copy) NSString *applyTime;
/**
 提现金额
 */
@property (nonatomic, copy) NSString *cashAmount;
/**
 提现状态码
 */
@property (nonatomic, copy) NSString *cashDrawStatus;
/**
 提现状态描述
 */
@property (nonatomic, copy) NSString *logDesc;
/**
 提现银行卡
 */
@property (nonatomic, copy) NSString *bankNum;

/********************辅助字段****************************/
/**
 控制按钮颜色
 */
@property (nonatomic, assign) BOOL isBlueColor;
@end
