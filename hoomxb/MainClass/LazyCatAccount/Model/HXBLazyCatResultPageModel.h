//
//  HXBLazyCatResultPageModel.h
//  hoomxb
//
//  Created by caihongji on 2018/4/23.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const kPasswordedit; //修改交易密码
extern NSString* const kEscrow; //存管开户
extern NSString* const kBindcard; //绑定银行卡
extern NSString* const kUnbindcard; //解绑银行卡
extern NSString* const kWithdrawal; //提现
extern NSString* const kQuickrecharge; //快捷充值
extern NSString* const kLoan; //散标购买
extern NSString* const kPlan; //计划购买
extern NSString* const kTransfer; //债转
extern NSString* const kTransfersale; //债转转让

@interface HXBLazyCatResultPageModel : NSObject

///标题
@property (nonatomic, copy) NSString* title;
///提示内容
@property (nonatomic, copy) NSString* content;

@end
