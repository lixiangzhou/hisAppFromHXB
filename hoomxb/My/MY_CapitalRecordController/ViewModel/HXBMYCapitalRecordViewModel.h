//
//  HXBMYCapitalRecordViewModel.h
//  hoomxb
//
//  Created by hxb on 2018/2/7.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBMYViewModel_MainCapitalRecordViewModel.h"//主界面 资产记录

@interface HXBMYCapitalRecordViewModel : HXBBaseViewModel

@property (nonatomic,strong) NSMutableArray<HXBMYViewModel_MainCapitalRecordViewModel *>* capitalRecordViewModel_array;
@property (nonatomic,assign) NSInteger capitalRecordPage;
@property (nonatomic,assign) NSUInteger currentPageCount;


/**
 Description

 @param screenType 筛选条件 0：充值，1：提现，2：散标债权，3：红利计划 (暂时没用到)
 @param successDateBlock successDateBlock description
 @param failureBlock failureBlock description
 */
- (void)capitalRecord_requestWithScreenType: (NSString *)screenType
                            andSuccessBlock: (void(^)(BOOL isSuccess))successDateBlock
                            andFailureBlock: (void(^)(NSError *error))failureBlock;

@end
