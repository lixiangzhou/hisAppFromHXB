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
@property (nonatomic, copy) NSString* isInviteActivityShow;
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

@end
