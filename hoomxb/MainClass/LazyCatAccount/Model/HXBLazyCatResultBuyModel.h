//
//  HXBLazyCatResultBuyModel.h
//  hoomxb
//
//  Created by caihongji on 2018/5/2.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBLazyCatResultPageModel.h"

@interface HXBLazyCatResultBuyModel : HXBLazyCatResultPageModel
/**通用购买字段***************************************/

//是否显示邀请好友
@property (nonatomic, assign) BOOL isInviteActivityShow;
//邀请好友描述
@property (nonatomic, copy) NSString* inviteActivityDesc;

/**计划购买专用字段************************************/
//1524971100000， 时间戳
@property (nonatomic, copy) NSString* lockStart;

/**债转购买专用字段************************************/
@property (nonatomic, assign) NSInteger principal;
@property (nonatomic, assign) NSInteger interest;
@property (nonatomic, assign) BOOL isRepayed;
@property (nonatomic, copy) NSString* buyAmount;
@property (nonatomic, copy) NSString* nextRepayDate;
@property (nonatomic, copy) NSString* tips;

/**
 下一个还款日_new
 */
@property (nonatomic,copy) NSString *nextRepayDate_new;
/**
 投资金额_new
 */
@property (nonatomic,copy) NSString *buyAmount_new;
/**
 公允利息_new
 */
@property (nonatomic,copy) NSString *interest_new;
/**
 实际买入本金_new
 */
@property (nonatomic,copy) NSString *principal_new;

@end
