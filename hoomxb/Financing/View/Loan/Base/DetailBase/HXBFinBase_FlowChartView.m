//
//  HXBFinBase_FlowChartView.m
//  hoomxb
//
//  Created by HXB on 2017/5/5.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinBase_FlowChartView.h"
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
@property (nonatomic,strong) HXBBaseView_TwoLable_View *addView;
/**
 开始收益
 */
@property (nonatomic,strong) HXBBaseView_TwoLable_View *beginView;
/**
 到期退出view
 */
@property (nonatomic,strong) HXBBaseView_TwoLable_View *levaeView;
/**
 同心圆的view
 */
@property (nonatomic,strong) HXBBaseViewConcentricCirclesView *concentricCirclesView;
@property (nonatomic,strong) HXBBaseViewConcentricCirclesView *concentricCirclesView_red;
///收益中
@property (nonatomic,strong) UILabel *profitLabel;
/**
 渐变的View
 */
@property (nonatomic,strong) HXBColourGradientView *colourGradientView_profiting;
/**
 渐变的View 加入中
 */
@property (nonatomic,strong) HXBColourGradientView *colourGradientView_adding;
/**
 收益中
 加入中
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomView *statusLableView;
@property (nonatomic,copy)HXBFinBase_FlowChartView_Manager *manager;
@property (nonatomic,assign) HXBFinBase_FlowChartView_Plan_Stage stageFont;
@end


@implementation HXBFinBase_FlowChartView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.manager = [[HXBFinBase_FlowChartView_Manager alloc]init];
        [self setUP];
    }
    return self;
}
- (void)setUPFlowChartViewManagerWithManager:(HXBFinBase_FlowChartView_Manager *(^)(HXBFinBase_FlowChartView_Manager *))flowChartViewManagerBlock {
    self.manager = flowChartViewManagerBlock(self.manager);
}
- (void)setManager:(HXBFinBase_FlowChartView_Manager *)manager {
    _manager = manager;
    kWeakSelf
    
    [self.addView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        viewModelVM.leftFont = kHXBFont_PINGFANGSC_REGULAR(12);
        viewModelVM.rightFont = kHXBFont_PINGFANGSC_REGULAR(12);
        viewModelVM.leftLabelAlignment = NSTextAlignmentLeft;
        viewModelVM.rightLabelAlignment = NSTextAlignmentLeft;
        viewModelVM.leftViewColor = kHXBColor_Font0_6;
        viewModelVM.rightViewColor = kHXBColor_Font0_6;
        viewModelVM.rightLabelStr = manager.addTime;
        viewModelVM.leftLabelStr = @"加入";
        if (self.stageFont == HXBFinBase_FlowChartView_Plan_Stage_Null) {
//            viewModelVM.leftViewColor = kHXBColor_Font0_6;
//            viewModelVM.rightViewColor = kHXBColor_Font0_6;
        }else {
            viewModelVM.leftViewColor = kHXBColor_Grey_Font0_2;
            viewModelVM.rightViewColor = kHXBColor_HeightGrey_Font0_4;
        }
        return viewModelVM;
    }];
    [self.beginView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        
        viewModelVM.leftFont = kHXBFont_PINGFANGSC_REGULAR(12);
        viewModelVM.rightFont = kHXBFont_PINGFANGSC_REGULAR(12);
        viewModelVM.leftLabelAlignment = NSTextAlignmentCenter;
        viewModelVM.rightLabelAlignment = NSTextAlignmentCenter;
        viewModelVM.leftViewColor = kHXBColor_Font0_6;
        viewModelVM.rightViewColor = kHXBColor_Font0_6;
        if (self.stageFont > HXBFinBase_FlowChartView_Plan_Stage_Add) {
            viewModelVM.leftViewColor = kHXBColor_Grey_Font0_2;
            viewModelVM.rightViewColor = kHXBColor_HeightGrey_Font0_4;
        }
        viewModelVM.rightLabelStr = manager.beginTime;
        viewModelVM.leftLabelStr = @"开始收益";
        return viewModelVM;
    }];
    [self.levaeView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        viewModelVM.leftFont = kHXBFont_PINGFANGSC_REGULAR(12);
        viewModelVM.rightFont = kHXBFont_PINGFANGSC_REGULAR(12);
        viewModelVM.leftLabelAlignment = NSTextAlignmentRight;
        viewModelVM.rightLabelAlignment = NSTextAlignmentRight;
        viewModelVM.leftViewColor = kHXBColor_Font0_6;
        viewModelVM.rightViewColor = kHXBColor_Font0_6;
        if (self.stageFont >= HXBFinBase_FlowChartView_Plan_Stage_Leave) {
            viewModelVM.leftViewColor = kHXBColor_Grey_Font0_2;
            viewModelVM.rightViewColor = kHXBColor_HeightGrey_Font0_4;
        }
        viewModelVM.rightLabelStr = manager.leaveTime;
        viewModelVM.leftLabelStr = @"到期退出";
        return viewModelVM;
    }];

}
//逻辑分析
/**
 1. status 1-5 (开放加入前) （全灰色）
 2. status 6 （开放加入）（加入为红色同心圆）
 3. status 7 （加入满额）（加入-开始收益的之间的线为红色 开始收益圆圈不变红）
 4. status 8-9（(开始收益)收益中） (显示收益中这几个字，开始收益和到期退出红线， 然后退出中的圆圈为灰色)
 5. status 10 （已退出） (圆圈全红，并且显示收益中这几个字)
 */
- (void)setStage:(NSInteger)stage {
    _concentricCirclesView.hidden = false;
    switch (stage) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
            ///同心圆的个数
            self.concentricCirclesView_red.circularCount = 0;
            self.stageFont = HXBFinBase_FlowChartView_Plan_Stage_Null;
            break;
        case 6:
            self.concentricCirclesView_red.stage = 1;
            self.concentricCirclesView_red.dontDrowArtCount = 2;
            self.stageFont = HXBFinBase_FlowChartView_Plan_Stage_Add;
            break;
        case 7:
            self.concentricCirclesView_red.stage = 1;
            self.concentricCirclesView_red.dontDrowArtCount = 1;
            self.concentricCirclesView_red.isDontDrowLastArtCount = true;
            self.stageFont = HXBFinBase_FlowChartView_Plan_Stage_Add;
            break;
        case 8:
        case 9:
            self.concentricCirclesView_red.stage = 2;
            _colourGradientView_profiting.hidden = false;
            self.concentricCirclesView_red.isDontDrowLastArtCount = true;
            self.profitLabel.hidden = false;
            self.stageFont = HXBFinBase_FlowChartView_Plan_Stage_Begin;
            break;
        case 10:

            self.concentricCirclesView_red.stage = 3;
            _colourGradientView_profiting.hidden = false;
            self.profitLabel.hidden = false;
            self.stageFont = HXBFinBase_FlowChartView_Plan_Stage_Leave;
            break;
    }
//    return HXBFinBase_FlowChartView_Plan_Stage_Null;
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
  }

- (void)setUP {
 
    [self.addView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW(20));
        make.top.equalTo(self).offset(kScrAdaptationH(15));
        make.height.equalTo(@(kScrAdaptationH(35)));
    }];
    [self.beginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.addView);
        make.height.equalTo(@(kScrAdaptationH(35)));
    }];
    [self.levaeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(kScrAdaptationW(-20));
        make.top.equalTo(self.addView);
        make.height.equalTo(@(kScrAdaptationH(35)));
    }];
    [self.colourGradientView_profiting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.concentricCirclesView.mas_centerY);
        make.left.equalTo(self.concentricCirclesView.mas_centerX);
        make.right.equalTo(self.concentricCirclesView).offset(kScrAdaptationW(-5));
        make.height.equalTo(@(kScrAdaptationH(18)));
    }];
    
//    [self.colourGradientView_adding mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.concentricCirclesView.mas_centerY);
//        make.right.equalTo(self.concentricCirclesView.mas_centerX);
//        make.left.equalTo(self.concentricCirclesView).offset(kScrAdaptationW(5));
//        make.height.equalTo(@(kScrAdaptationH(18)));
//    }];
    [self.concentricCirclesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_top).offset(kScrAdaptationH(63));
        make.left.equalTo(self.addView);
        make.right.equalTo(self.levaeView);
        make.height.equalTo(@(kScrAdaptationH(15)));
    }];
    [self.concentricCirclesView_red mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_top).offset(kScrAdaptationH(63));
        make.left.equalTo(self.addView);
        make.right.equalTo(self.levaeView);
        make.height.equalTo(@(kScrAdaptationH(15)));
    }];
  [self.profitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.bottom.equalTo(self).offset(kScrAdaptationH(-15));
      make.centerX.equalTo(self.colourGradientView_profiting);
      make.top.equalTo(self.mas_centerY).offset(kScrAdaptationH(13));
  }];
    [self.statusLableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(kScrAdaptationH(-15));
        make.top.equalTo(self).offset(kScrAdaptationH(76));
        make.left.equalTo(self.colourGradientView_adding);
        make.right.equalTo(self.colourGradientView_profiting);
    }];
    NSArray <NSNumber*> *components = @[
                                        @0.96,@0.32,@0.32,@0.14,
                                        @0.96,@0.32,@0.32,@0.00
                                        ];
    NSArray <NSNumber*> *locations = @[
                                       @0,@0.5
                                       ];
    
    [self.colourGradientView_profiting colorArray:components andLength:2 andColorLocation: locations];
    [self.colourGradientView_adding colorArray:components andLength:2 andColorLocation:locations];
    self.colourGradientView_profiting.endPoint = CGPointMake(0, kScrAdaptationH(18));
    self.colourGradientView_adding.endPoint = CGPointMake(0, kScrAdaptationH(18));
}


/**
 加入
 */
- (HXBBaseView_TwoLable_View *) addView {
    if (!_addView) {
        _addView = [[HXBBaseView_TwoLable_View alloc] init];
        [self addSubview:_addView];
    }
    return _addView;
}
/**
 开始收益
 */
- (HXBBaseView_TwoLable_View *) beginView {
    if (!_beginView) {
        _beginView = [[HXBBaseView_TwoLable_View alloc]init];
        [self addSubview:_beginView];
    }
    return _beginView;
}
/**
 到期退出
 */
- (HXBBaseView_TwoLable_View *) levaeView {
    if (!_levaeView) {
        _levaeView = [[HXBBaseView_TwoLable_View alloc] init];
        [self addSubview:_levaeView];
    }
    return _levaeView;
}
/**
 同心圆的view
 */
- (HXBBaseViewConcentricCirclesView *)concentricCirclesView {
    if (!_concentricCirclesView) {
        
        _concentricCirclesView = [[HXBBaseViewConcentricCirclesView alloc]init];
        _concentricCirclesView.hidden = true;
        ///第几个为空心圆
//        _concentricCirclesView.dontDrowArtCount = 3;
        [self addSubview:_concentricCirclesView];
        ///同心圆 外圆直径
        _concentricCirclesView.excircleDiameter = 10;
        ///同心圆 内圆直径
        _concentricCirclesView.insideCircularDiameter = 5;
        ///同心圆的个数
        _concentricCirclesView.circularCount = 3;
        _concentricCirclesView.excircleLineWidth = 0.5;
        ///线高
        _concentricCirclesView.excircleLineWidth = 0.5;
        _concentricCirclesView.lineHeight = 0.3;
        ///灰色颜色 线、外切圆、内切圆
        _concentricCirclesView.lineColor = RGBA(216, 216, 216, 1);
        _concentricCirclesView.excircleLineColor = RGBA(216, 216, 216, 1);
        _concentricCirclesView.inscribedCircleColor = RGBA(245, 81, 81, 1);
    }
    return _concentricCirclesView;
}
/**
 同心圆的view
 */
- (HXBBaseViewConcentricCirclesView *)concentricCirclesView_red {
    if (!_concentricCirclesView_red) {
        _concentricCirclesView_red = [[HXBBaseViewConcentricCirclesView alloc]init];
        [self addSubview:_concentricCirclesView_red];
        
        ///同心圆 外圆直径
        _concentricCirclesView_red.excircleDiameter = 10;
        _concentricCirclesView_red.circularCount = 3;
        ///同心圆 内圆直径
        _concentricCirclesView_red.insideCircularDiameter = 5;
        _concentricCirclesView_red.excircleLineWidth = 0.5;
        ///线高
        _concentricCirclesView_red.lineHeight = 0.3;
        ///灰色颜色 线、外切圆、内切圆
        _concentricCirclesView_red.lineColor = kHXBColor_Red_090303;
        _concentricCirclesView_red.excircleLineColor = kHXBColor_Red_090303;
        _concentricCirclesView_red.inscribedCircleColor = kHXBColor_Red_090303;
    }
    return _concentricCirclesView_red;
   
}
/**
 渐变色
 */
- (HXBColourGradientView *)colourGradientView_profiting {
    if (!_colourGradientView_profiting) {
        _colourGradientView_profiting = [[HXBColourGradientView alloc]initWithFrame:CGRectZero];
        _colourGradientView_profiting.hidden = true;
        [self insertSubview:_colourGradientView_profiting atIndex:0];
    }
    return _colourGradientView_profiting;
}
/**
 渐变色
 */
- (HXBColourGradientView *)colourGradientView_adding {
    if (!_colourGradientView_adding) {
        _colourGradientView_adding = [[HXBColourGradientView alloc]initWithFrame:CGRectZero];
        [self addSubview:_colourGradientView_adding];
        [self insertSubview:_colourGradientView_adding atIndex:0];
    }
    return _colourGradientView_adding;
}
- (UILabel *)profitLabel {
    if (!_profitLabel) {
        _profitLabel = [[UILabel alloc]init];
        [self addSubview:_profitLabel];
        _profitLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _profitLabel.textColor = kHXBColor_Grey_Font0_2;
        _profitLabel.text = @"收益中";
        _profitLabel.hidden = true;
    }
    return _profitLabel;
}
/**
 状态
 */
-(HXBBaseView_MoreTopBottomView *)statusLableView {
    if (!_statusLableView) {
        _statusLableView = [[HXBBaseView_MoreTopBottomView alloc]initWithFrame:CGRectZero andTopBottomViewNumber:1 andViewClass:[UILabel class] andViewHeight:kScrAdaptationH(19) andTopBottomSpace:0 andLeftRightLeftProportion:0.5];
        [self addSubview:_statusLableView];
    }
    return _statusLableView;
}
@end
@implementation HXBFinBase_FlowChartView_Manager
@end
