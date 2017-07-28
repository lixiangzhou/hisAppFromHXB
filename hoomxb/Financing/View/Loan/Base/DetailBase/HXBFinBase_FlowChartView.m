//
//  HXBFinBase_FlowChartView.m
//  hoomxb
//
//  Created by HXB on 2017/5/5.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinBase_FlowChartView.h"

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

@end


@implementation HXBFinBase_FlowChartView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUP];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    kWeakSelf
    [self.addView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
       
        viewModelVM.leftFont = kHXBFont_PINGFANGSC_REGULAR(12);
        viewModelVM.rightFont = kHXBFont_PINGFANGSC_REGULAR(12);
        viewModelVM.leftLabelAlignment = NSTextAlignmentLeft;
        viewModelVM.rightLabelAlignment = NSTextAlignmentLeft;
        viewModelVM.leftViewColor = kHXBColor_Grey_Font0_2;
        viewModelVM.rightViewColor = kHXBColor_HeightGrey_Font0_4;
        
        viewModelVM.leftLabelStr = weakSelf.addTime;
        viewModelVM.rightLabelStr = @"加入";
        return viewModelVM;
    }];
    [self.beginView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        
        viewModelVM.leftFont = kHXBFont_PINGFANGSC_REGULAR(12);
        viewModelVM.rightFont = kHXBFont_PINGFANGSC_REGULAR(12);
        viewModelVM.leftLabelAlignment = NSTextAlignmentCenter;
        viewModelVM.rightLabelAlignment = NSTextAlignmentCenter;
        if (weakSelf.stage == HXBFinBase_FlowChartView_Plan_Stage_Begin) {
            viewModelVM.leftViewColor = kHXBColor_HeightGrey_Font0_4;
        }else {
            viewModelVM.leftViewColor = kHXBColor_Grey_Font0_2;
        }
        viewModelVM.rightViewColor = kHXBColor_HeightGrey_Font0_4;
        
        viewModelVM.leftLabelStr = weakSelf.beginTime;
        viewModelVM.rightLabelStr = @"开始收益";
        return viewModelVM;
    }];
    [self.levaeView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        viewModelVM.leftFont = kHXBFont_PINGFANGSC_REGULAR(12);
        viewModelVM.rightFont = kHXBFont_PINGFANGSC_REGULAR(12);
        viewModelVM.leftLabelAlignment = NSTextAlignmentRight;
        viewModelVM.rightLabelAlignment = NSTextAlignmentRight;
        if (weakSelf.stage == HXBFinBase_FlowChartView_Plan_Stage_Leave) {
            viewModelVM.leftViewColor = kHXBColor_HeightGrey_Font0_4;
        }else {
            viewModelVM.leftViewColor = kHXBColor_Grey_Font0_2;
        }
        viewModelVM.rightViewColor = kHXBColor_HeightGrey_Font0_4;
        viewModelVM.leftLabelStr = weakSelf.leaveTime;
        viewModelVM.rightLabelStr = @"到期退出";
        return viewModelVM;
    }];
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
    self.concentricCirclesView.stage = self.stage;
    self.concentricCirclesView.isDontDrowLastArt = self.isDontDrowLastArt;
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
        ///第几个为空心圆
        _concentricCirclesView.stage = 1;
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
    if (!_concentricCirclesView) {
        _concentricCirclesView = [[HXBBaseViewConcentricCirclesView alloc]init];
        [self addSubview:_concentricCirclesView];
        ///同心圆 外圆直径
        _concentricCirclesView.excircleDiameter = 10;
        ///同心圆 内圆直径
        _concentricCirclesView.insideCircularDiameter = 5;
        ///同心圆的个数
        _concentricCirclesView.circularCount = 3;
        _concentricCirclesView.excircleLineWidth = 0.5;
        ///线高
        _concentricCirclesView.lineHeight = 0.3;
    }
    return _concentricCirclesView;
   
}
/**
 渐变色
 */
- (HXBColourGradientView *)colourGradientView_profiting {
    if (!_colourGradientView_profiting) {
        _colourGradientView_profiting = [[HXBColourGradientView alloc]initWithFrame:CGRectZero];
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
