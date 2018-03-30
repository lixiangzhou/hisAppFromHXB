//
//  HXBFinBase_FlowChartView.m
//  hoomxb
//
//  Created by HXB on 2017/5/5.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinBase_FlowChartView.h"
#import "HXBFinBaseFlowChartChildView.h"

//逻辑分析
/**
1. status 1-5 (开放加入前) （全灰色）
2. status 6 （开放加入）（加入为红色同心圆）
3. status 7 （加入满额）（加入- 开始收益的之间的线为红色）
4. status 8-9（收益中） (显示收益中这几个字，然后退出中的圆圈为灰色)
5. status 10 （已退出） (圆圈全红，并且显示收益中这几个字)
 */
@interface HXBFinBase_FlowChartView ()
/**
 加入
 */
@property (nonatomic,strong) HXBFinBaseFlowChartChildView *addView;
/**
 开始收益
 */
@property (nonatomic,strong) HXBFinBaseFlowChartChildView *beginView;
/**
 到期退出view
 */
@property (nonatomic,strong) HXBFinBaseFlowChartChildView *levaeView;
@end


@implementation HXBFinBase_FlowChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUI];
        [self addConstraints];
    }
    return self;
}

- (void)setUI
{
    _addView = [[HXBFinBaseFlowChartChildView alloc] init];
    _beginView = [[HXBFinBaseFlowChartChildView alloc] init];
    _levaeView = [[HXBFinBaseFlowChartChildView alloc] init];
    
    [self addSubview:_addView];
    [self addSubview:_beginView];
    [self addSubview:_levaeView];
}

- (void)addConstraints
{
    kWeakSelf
    [self.addView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScrAdaptationW(15));
        make.top.mas_equalTo(kScrAdaptationH(22));
        make.width.mas_equalTo(kScrAdaptationW(90));
        make.height.mas_equalTo(kScrAdaptationH(20));
    }];
    
    [self.beginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.addView.mas_right).offset(kScrAdaptationW(5));
        make.top.equalTo(weakSelf.addView);
        make.width.mas_equalTo(kScrAdaptationW(120));
        make.height.equalTo(weakSelf.addView.mas_height);
    }];
    
    [self.levaeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.beginView.mas_right).offset(kScrAdaptationW(5));
        make.top.equalTo(weakSelf.beginView);
        make.width.mas_equalTo(kScrAdaptationW(125));
        make.height.equalTo(weakSelf.beginView.mas_height);
    }];
}

- (void)setUPFlowChartViewManagerWithManager:(HXBFinBase_FlowChartView_Manager *(^)(HXBFinBase_FlowChartView_Manager *))flowChartViewManagerBlock {
    HXBFinBase_FlowChartView_Manager* manager = [[HXBFinBase_FlowChartView_Manager alloc] init];
    flowChartViewManagerBlock(manager);
    HXBFinBase_FlowChartView_Plan_Stage state = [self getPlanState:manager.stage];
    
    switch (state) {
        case HXBFinBase_FlowChartView_Plan_Stage_Null:
            [self.addView updateView:NO titleContent:@"" stateContent:@"加入" dateContent:manager.addTime];
            [self.beginView updateView:NO titleContent:manager.profitStr stateContent:@"进入锁定期" dateContent:manager.beginTime];
            [self.levaeView updateView:NO titleContent:@"随时可退" stateContent:@"进入开放期" dateContent:manager.leaveTime];
            break;
        case HXBFinBase_FlowChartView_Plan_Stage_Add:
            [self.addView updateView:YES titleContent:@"" stateContent:@"加入" dateContent:manager.addTime];
            [self.beginView updateView:NO titleContent:manager.profitStr stateContent:@"进入锁定期" dateContent:manager.beginTime];
            [self.levaeView updateView:NO titleContent:@"随时可退" stateContent:@"进入开放期" dateContent:manager.leaveTime];
            break;
        case HXBFinBase_FlowChartView_Plan_Stage_Begin:
            [self.addView updateView:YES titleContent:@"" stateContent:@"加入" dateContent:manager.addTime];
            [self.beginView updateView:YES titleContent:manager.profitStr stateContent:@"进入锁定期" dateContent:manager.beginTime];
            [self.levaeView updateView:NO titleContent:@"随时可退" stateContent:@"进入开放期" dateContent:manager.leaveTime];
            break;
        case HXBFinBase_FlowChartView_Plan_Stage_Leave:
            [self.addView updateView:YES titleContent:@"" stateContent:@"加入" dateContent:manager.addTime];
            [self.beginView updateView:YES titleContent:manager.profitStr stateContent:@"进入锁定期" dateContent:manager.beginTime];
            [self.levaeView updateView:YES titleContent:@"随时可退" stateContent:@"进入开放期" dateContent:manager.leaveTime];
            break;
            
        default:
            break;
    }
}

//逻辑分析
/**
 1. status 1-5 (开放加入前) （全灰色）
 2. status 6 （开放加入）（加入为红色同心圆）
 3. status 7 （加入满额）（加入-开始收益的之间的线为红色 开始收益圆圈不变红）
 4. status 8-9（(开始收益)收益中） (显示收益中这几个字，开始收益和到期退出红线， 然后退出中的圆圈为灰色)
 5. status 10 （已退出） (圆圈全红，并且显示收益中这几个字)
 */
- (HXBFinBase_FlowChartView_Plan_Stage)getPlanState:(NSInteger)stage {
    HXBFinBase_FlowChartView_Plan_Stage planState = HXBFinBase_FlowChartView_Plan_Stage_Null;
    switch (stage) {
        case 6:
        case 7:
            planState = HXBFinBase_FlowChartView_Plan_Stage_Add;
            break;
        case 8:
        case 9:
            planState = HXBFinBase_FlowChartView_Plan_Stage_Begin;
            break;
        case 10:
            planState = HXBFinBase_FlowChartView_Plan_Stage_Leave;
            break;
        default:
            break;
    }
    return planState;
    
}

@end

@implementation HXBFinBase_FlowChartView_Manager
@end
