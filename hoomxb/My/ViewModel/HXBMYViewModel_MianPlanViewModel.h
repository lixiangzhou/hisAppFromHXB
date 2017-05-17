//
//  HXBMYViewModel_MianPlanViewModel.h
//  hoomxb
//
//  Created by HXB on 2017/5/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBRequestType_MYManager.h"
@class HXBMYModel_MainPlanModel_DataList;
///我的 plan 主界面的ViewModel
@interface HXBMYViewModel_MianPlanViewModel : NSObject
///viewModel里的数据Model
@property (nonatomic,strong) HXBMYModel_MainPlanModel_DataList *planModelDataList;
///请求的类型 （持有中， 正在推出， 已经推出）
@property (nonatomic,assign) HXBRequestType_MY_PlanRequestType requestType;
/// 相应后数据的状态
@property (nonatomic,assign) HXBRequestType_MY_PlanResponseStatus responseStatus;
/// 红利计划 的状态
@property (nonatomic,copy) NSString *status;
@end
