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
@property (nonatomic, copy) NSString *statusText;
/**
 预计到账时间
 */
@property (nonatomic, copy) NSString *arrivalTimeText;
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
@property (nonatomic, copy) NSString *status;
/**
 提现状态描述
 */
@property (nonatomic, copy) NSString *logText;
/**
 提现银行卡
 */
@property (nonatomic, copy) NSString *bankNum;

/********************辅助字段****************************/
/**
 控制按钮颜色
 */
@property (nonatomic, assign) BOOL isBlueColor;
/**
 银行卡尾号截取
 */
@property (nonatomic, copy) NSString *bankLastNum;
/**
 转换时间时间抽
 */
@property (nonatomic, copy) NSString *applyTimeStr;
@end
