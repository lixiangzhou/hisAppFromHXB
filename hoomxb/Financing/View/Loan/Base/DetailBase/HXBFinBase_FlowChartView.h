//
//  HXBFinBase_FlowChartView.h
//  hoomxb
//
//  Created by HXB on 2017/5/5.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ///加入中
    HXBFinBase_FlowChartView_Plan_Stage_Add,
    ///开始收益
    HXBFinBase_FlowChartView_Plan_Stage_Begin,
    ///到期退出
    HXBFinBase_FlowChartView_Plan_Stage_Leave,
} HXBFinBase_FlowChartView_Plan_Stage;

static NSString *kHXB_FinPlan_Add = @"加入";
static NSString *kHXB_FinPlan_Begin = @"开始收益";
static NSString *kHXB_FinPlan_Leave = @"到期退出";

@interface HXBFinBase_FlowChartView : UIView
/**

 */
@property (nonatomic,copy) NSString * isDontDrowLastArt;
/**
 第几个阶段
 加入中，开始收益，到期退出
 */
@property (nonatomic,assign) HXBFinBase_FlowChartView_Plan_Stage stage;
/**
 加入时间
 */
@property (nonatomic,copy) NSString * addTime;
/**
 开始收益时间
 */
@property (nonatomic,copy) NSString * beginTime;
/**
 到期退出时间
 */
@property (nonatomic,copy) NSString * leaveTime;
@end
