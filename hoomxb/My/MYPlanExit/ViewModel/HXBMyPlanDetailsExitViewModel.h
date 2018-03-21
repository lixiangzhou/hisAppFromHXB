//
//  HXBMyPlanDetailsExitViewModel.h
//  hoomxb
//
//  Created by hxb on 2018/3/12.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBMyPlanDetailsExitModel.h"
#import "HXBMyPlanDetailsExitResultModel.h"
@interface HXBMyPlanDetailsExitViewModel : HXBBaseViewModel

@property (nonatomic,strong) HXBMyPlanDetailsExitModel *myPlanDetailsExitModel;
@property (nonatomic,strong) HXBMyPlanDetailsExitResultModel *myPlanDetailsExitResultModel;
/**
 获取账户内红利计划退出信息

 @param planID 计划ID
 @param inCoolingOffPeriod 是否是冷静期
 @param resultBlock resultBlock description
 */
- (void)loadPlanListDetailsExitInfoWithPlanID: (NSString *)planID
                           inCoolingOffPeriod: (BOOL)inCoolingOffPeriod
                                  resultBlock: (void(^)(BOOL isSuccess))resultBlock;

/**
 获取点击账户内红利计划确认退出结果
 
 @param planID 计划ID
 @param inCoolingOffPeriod 是否是冷静期
 @param smscode 短信验证码
 @param callBackBlock 成功回调
 */
- (void)exitPlanResultRequestWithPlanID: (NSString *)planID
                     inCoolingOffPeriod: (BOOL)inCoolingOffPeriod
                             andSmscode:(NSString *)smscode
                       andCallBackBlock:(void(^)(BOOL isSuccess))callBackBlock;

/**
 获取退出短验

 @param action 类型
 @param type 短信验证码或是语言验证码
 @param callbackBlock 请求回调
 */
- (void)getVerifyCodeRequesWithExitPlanWithAction:(NSString *)action
                                      andWithType:(NSString *)type
                                 andCallbackBlock: (void(^)(BOOL isSuccess,NSError *error))callbackBlock;

@end
