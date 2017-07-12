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
/**
 圆形 与线的颜色
 默认（HXBC_Red_Light(r:0.96 g:0.32 b:0.32 a:1.00)）
 */
@property (nonatomic,strong) UIColor *color;
///同心圆的内间距
@property (nonatomic,assign) CGFloat concentricCircles_spacing;
///同心圆 外圆直径
@property (nonatomic,assign) CGFloat circularDiameter;
///同心圆 内圆直径
@property (nonatomic,assign) CGFloat insideCircularDiameter;
///同心圆的个数
@property (nonatomic,assign) NSInteger circularCount;
@end
