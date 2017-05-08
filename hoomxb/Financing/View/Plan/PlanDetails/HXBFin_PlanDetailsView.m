//
//  HXBFin_PlanDetailsView.m
//  hoomxb
//
//  Created by HXB on 2017/5/5.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_PlanDetailsView.h"
#import "HXBFinPlanDetailsView_FlowChart.h"//流程引导视图
@interface HXBFin_PlanDetailsView ()
///预期年化的view
@property (nonatomic,strong) UIView *expectedYearRateView;
///剩余可投
@property (nonatomic,strong) UIView *surplusValueView;
///流程引导视图
@property (nonatomic,strong) HXBFinPlanDetailsView_FlowChart *flowChartView;
///立即加入视图
@property (nonatomic,strong) UIView *addView;
///剩余可投是否分为左右两个
@property (nonatomic,assign) BOOL isFlowChart;
@end



@implementation HXBFin_PlanDetailsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubView];
    }
    return self;
}
- (void)setupSubView {
    
    [self setupExpectedYearRateView];///预期年化的view
    [self setupSurplusValueView]; ///剩余可投
    [self setupFlowChartView];///流程引导视图
    [self setupAddView];///立即加入视图
}
- (void)setupExpectedYearRateView {
    self.expectedYearRateView = [[UIView alloc]init];
    self.expectedYearRateView.frame = CGRectMake(0, 0, self.width, 300);
    [self addSubview:self.expectedYearRateView];
    [self upDownLableWithView:self.expectedYearRateView andDistance:20 andFirstFont:[UIFont systemFontOfSize:40] andFirstStr:@"12.0%" andSecondStr:@"预期年化"];
}


- (void)setupSurplusValueView {
    self.surplusValueView = [[UIView alloc]init];
    [self addSubview:self.surplusValueView];
    
    __weak typeof (self) weakSelf = self;
    [self.surplusValueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.expectedYearRateView.mas_bottom).offset(1);
        make.right.left.equalTo(weakSelf);
        make.height.equalTo(@70);
    }];
    //是否分为左右两个（起投，剩余金额）
    if (!self.isFlowChart) {
        UIView *leftView = [[UIView alloc]init];
        [self.surplusValueView addSubview:leftView];
        UIView *rightView = [[UIView alloc]init];
        [self.surplusValueView addSubview:rightView];
        
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_centerX);
            make.height.left.top.equalTo(weakSelf.surplusValueView);
        }];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_centerX);
            make.height.right.top.equalTo(weakSelf.surplusValueView);
        }];
        [self upDownLableWithView:leftView andDistance:10 andFirstFont:[UIFont systemFontOfSize:30] andFirstStr:@"0%" andSecondStr:@"剩0"];
        [self upDownLableWithView:rightView andDistance:10 andFirstFont:[UIFont systemFontOfSize:30] andFirstStr:@"123%" andSecondStr:@"剩余可投"];
    }else{
        [self upDownLableWithView:self.surplusValueView andDistance:10 andFirstFont:[UIFont systemFontOfSize:30] andFirstStr:@"123%" andSecondStr:@"剩余可投"];
    }
}
- (void)setupFlowChartView {
    
}
- (void)setupAddView {
    
}




//生成一上一下lable
- (void)upDownLableWithView: (UIView *)view andDistance: (CGFloat)distance andFirstFont: (UIFont *)font andFirstStr: (NSString *)firstStr andSecondStr: (NSString *)secondStr{
    //预期年化的数字部分
    UILabel *firstLable = [[UILabel alloc]init];
    firstLable.font = font;
    [view addSubview:firstLable];
    [firstLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.centerY.equalTo(view.mas_centerY).offset(-(distance / 2));
        make.height.equalTo(@30);
    }];
  
    //预期年化
    UILabel *secondLable = [[UILabel alloc]init];
    [view addSubview:secondLable];
    [secondLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstLable.mas_bottom).offset((distance / 2));
        make.centerX.equalTo(firstLable.mas_centerX);
    }];
    firstLable.text = firstStr;
    secondLable.text = secondStr;
    secondLable.textColor = [UIColor grayColor];
    //测试
 
    view.backgroundColor = [UIColor hxb_randomColor];
    firstLable.backgroundColor = [UIColor redColor];
}
@end
