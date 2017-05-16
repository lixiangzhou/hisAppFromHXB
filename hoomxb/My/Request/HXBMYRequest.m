//
//  HXBMYRequest.m
//  hoomxb
//
//  Created by HXB on 2017/5/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMYRequest.h"
#import "HXBRequestType_MYManager.h"//关于我的界面的 网络 相关的枚举管理类
// --------- 主界面
#import "HXBRequstAPI_MYMainPlanAPI.h"//主界面 plan API
#import "HXBMYViewModel_MianPlanViewModel.h"//主界面 planViewModel
#import "HXBMYModel_MainPlanModel.h"//主界面的 planModel


@interface HXBMYRequest ()
///持有中
@property (nonatomic,strong) NSMutableArray <HXBMYViewModel_MianPlanViewModel *>*hold_Plan_array;
@property (nonatomic,assign) NSInteger holdPlanPage;//用于记录页数的字段
///plan 推出中
@property (nonatomic,strong) NSMutableArray <HXBMYViewModel_MianPlanViewModel *>*exiting_Plan_array;
@property (nonatomic,assign) NSInteger exitingPage;//记录了退出中的页数字段

///plan 已退出
@property (nonatomic,strong) NSMutableArray <HXBMYViewModel_MianPlanViewModel *>*exit_Plan_array;
@property (nonatomic,assign) NSInteger exitPage;//记录了推出的页数字段

@end


@implementation HXBMYRequest
//创建单利对象
+ (instancetype) sharedMYRequest {
    static dispatch_once_t once;
    static id _instance;
    dispatch_once(&once,^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

- (instancetype) init {
    if (self = [super init]) {
        [self creatArray];
    }
    return self;
}
///创建array
- (void)creatArray {
    self.hold_Plan_array = [[NSMutableArray alloc]init];
    self.exit_Plan_array = [[NSMutableArray alloc]init];
    self.exiting_Plan_array = [[NSMutableArray alloc]init];
}

#pragma mark - getter
- (NSInteger) exitingPage {
    if (_exitingPage <= 0) {
        _exitingPage = 1;
    }
    return _exitingPage;
}
- (NSInteger) exitPage {
    if (_exitPage <= 0) {
        _exitPage = 1;
    }
    return _exitPage;
}
- (NSInteger) holdPlanPage {
    if (_holdPlanPage <= 0) {
        _holdPlanPage = 1;
    }
    return _holdPlanPage;
}

#pragma mark - 主要页面的网络请求

//MARK: 红利计划 主界面的网络数据请求
- (void)myPlan_requestWithPlanType: (HXBRequestType_MY_PlanRequestType)planRequestType
                         andUpData: (BOOL)isUPData
                   andSuccessBlock: (void(^)(NSArray<HXBMYViewModel_MianPlanViewModel *>* viewModelArray))successDateBlock
                   andFailureBlock: (void(^)(NSError *error))failureBlock {
    
    HXBRequstAPI_MYMainPlanAPI *mainPlanAPI = [[HXBRequstAPI_MYMainPlanAPI alloc]init];
    NSString *type = [HXBRequestType_MYManager myPlan_requestType:planRequestType];
    NSString *pageNumberStr = @([self getRequestPageWithType:planRequestType]).description;
    
    NSString *userIDStr = [KeyChainManage sharedInstance].userId;
    if (userIDStr.length) {
        NSLog(@"%@, - 没有userID 使用了测试 的userID ： 2458528", self.class);
        userIDStr = @"2458528";
    }
    mainPlanAPI.requestArgument = @{
                                    @"type" : type,
                                    @"pageNumber" : pageNumberStr,
                                    @"pageSize" : @20,
                                    @"userId" : userIDStr
                                    };
    
    
    [mainPlanAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSArray<NSDictionary *>*responseArray = responseObject[@"data"];
        
        __block NSMutableArray <HXBMYViewModel_MianPlanViewModel *>*dataArray = [[NSMutableArray alloc]init];
        //数据的
        [responseArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull responseDic, NSUInteger idx, BOOL * _Nonnull stop) {
            HXBMYModel_MainPlanModel *planModel = [[HXBMYModel_MainPlanModel alloc]init];
            [planModel yy_modelSetWithDictionary:responseDic];
            HXBMYViewModel_MianPlanViewModel *planViewModel = [[HXBMYViewModel_MianPlanViewModel alloc]init];
            planViewModel.planModel = planModel;
            //数据的储存
            [dataArray addObject:planViewModel];
        }];
        NSString *typeStr = dataArray.firstObject.planModel.dataList.type;
        //数据的处理
       NSArray *handleData = [self handleResponseArrayWithIsupData:isUPData andTypeStr:typeStr andViewModelArray:dataArray];
        //向外回调
        if (successDateBlock) successDateBlock(handleData);
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) {
            failureBlock (error);
        }
    }];
}
///根据type 区分page
- (NSInteger)getRequestPageWithType: (HXBRequestType_MY_PlanRequestType)type {
    switch (type) {
        case HXBRequestType_MY_PlanRequestType_EXIT_PLAN:
            return self.exitPage;
        case HXBRequestType_MY_PlanRequestType_HOLD_PLAN:
            return self.holdPlanPage;
        case HXBRequestType_MY_PlanRequestType_EXITING_PLAN:
            return self.exitingPage;
    }
}

///根据typeStr 来进行数据的处理
- (NSMutableArray *)handleResponseArrayWithIsupData: (BOOL)isupdata andTypeStr: (NSString *)typeStr andViewModelArray: (NSArray < HXBMYViewModel_MianPlanViewModel *>*)viewModeArray {
    HXBRequestType_MY_PlanRequestType type = [HXBRequestType_MYManager myPlan_requestTypeStr:typeStr];
    return [self handleResponseArrayWithIsupData: isupdata andType:type andViewModelArray:viewModeArray];
}
///根据返回的类型来 进行数据得分发
- (NSMutableArray *)handleResponseArrayWithIsupData: (BOOL)isupdata andType: (HXBRequestType_MY_PlanRequestType)type andViewModelArray: (NSArray < HXBMYViewModel_MianPlanViewModel *>*)viewModelArray{
    switch (type) {
        case HXBRequestType_MY_PlanRequestType_EXITING_PLAN://退出中
            if (isupdata) {//如果是下拉刷新 就先清空数再追加
                self.exitingPage = 1;
                [self.exiting_Plan_array removeAllObjects];
            }
            [self.exiting_Plan_array addObjectsFromArray:viewModelArray];
            return self.exiting_Plan_array;
            
        
        case HXBRequestType_MY_PlanRequestType_HOLD_PLAN://持有中
            if (isupdata) {
                self.holdPlanPage = 1;
                [self.hold_Plan_array removeAllObjects];
            }
            [self.hold_Plan_array addObjectsFromArray:viewModelArray];
            return self.hold_Plan_array;
            
        
        case HXBRequestType_MY_PlanRequestType_EXIT_PLAN://已退出
            if (isupdata) {
                self.exitPage = 1;
                [self.exit_Plan_array removeAllObjects];
            }
            [self.exit_Plan_array addObjectsFromArray:viewModelArray];
            return self.exit_Plan_array;
    }
    NSLog(@"🌶  %@，我的 plan 的数组赋值出错",self.class);
    return nil;
}
@end
