//
//  HXBFin_DetailsViewBase.m
//  hoomxb
//
//  Created by HXB on 2017/5/5.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_DetailsViewBase.h"
#import "HXBFinBase_FlowChartView.h"
#define kWeakSelf __weak typeof(self)weakSelf = self;
@interface HXBFin_DetailsViewBase()
///预期年化的view
@property (nonatomic,strong) UIView *expectedYearRateView;
///曾信View
@property (nonnull,strong) UIView *trustView;
///剩余可投
@property (nonatomic,strong) UIView *surplusValueView;
///流程引导视图
@property (nonatomic,strong) HXBFinBase_FlowChartView *flowChartView;
///立即加入视图
@property (nonatomic,strong) UIView *addView;


@end

@implementation HXBFin_DetailsViewBase


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)show {
    [self setupSubView];
}
- (void)setupSubView {
    
    [self setupExpectedYearRateView];///预期年化的view
    [self setupSurplusValueView]; ///剩余可投里面
    [self setupAddTrustView];//曾信view（内部对是否分为左右进行了判断）
    [self setupFlowChartView];///流程引导视图
    [self setupAddView];///立即加入视图
    
    self.flowChartView.backgroundColor = [UIColor hxb_randomColor];
    self.addView.backgroundColor = [UIColor hxb_randomColor];
    self.addView.backgroundColor = [UIColor hxb_randomColor];
    
}

//MARK: - 预期年化的view
- (void)setupExpectedYearRateView {
    self.expectedYearRateView = [[UIView alloc]init];
    self.expectedYearRateView.frame = CGRectMake(0, 0, self.width, 300);
    [self addSubview:self.expectedYearRateView];
    [self upDownLableWithView:self.expectedYearRateView andDistance:20 andFirstFont:[UIFont systemFontOfSize:40] andFirstStr:@"12.0%" andSecondStr:@"预期年化"];
}

//MARK: - 剩余可投view
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
        [self setupSurplusValueViewWithTowView];
    }else{
        [self upDownLableWithView:self.surplusValueView andDistance:10 andFirstFont:[UIFont systemFontOfSize:30] andFirstStr:@"123%" andSecondStr:@"剩余可投"];
    }
}
//剩余投资（起投，剩余金额
- (void)setupSurplusValueViewWithTowView {
    __weak typeof (self) weakSelf = self;
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
}
//MARK: - 增信
- (void)setupAddTrustView {
    kWeakSelf
    if (!self.isFlowChart) return;
    self.trustView = [[UIView alloc]init];
    [self addSubview: self.trustView];
    [self.trustView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.surplusValueView.mas_bottom).offset(1);
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(@80);
    }];
    
    
}

//MARK: - 引导视图
- (void)setupFlowChartView {
    //如果是 则用增信view 不是则用剩余可投view作为约束参考
    UIView *view = self.isFlowChart ? self.trustView : self.surplusValueView;
    self.flowChartView = [[HXBFinBase_FlowChartView alloc]init];
    [self addSubview:self.flowChartView];
    [self.flowChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom);
        make.left.right.equalTo(view);
        make.height.equalTo(@80);
    }];
}
//MARK: - 立即加入按钮的添加
- (void)setupAddView {
    kWeakSelf
    self.addView = [[UIView alloc]init];
    [self addSubview:self.addView];
    [self.addView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf);
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(@80);
    }];
    UIButton *addButton = [[UIButton alloc]init];
    [self.addView addSubview:addButton];
    [self.addView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(weakSelf.addView);
        make.left.top.equalTo(weakSelf.addView).offset(20);
        make.bottom.right.equalTo(weakSelf.addView).offset(-20);
    }];
    [addButton setTitle:@"立即加入" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(clickAddButton:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)clickAddButton: (UIButton *)button {
    NSLog(@" - 立即加入 - ");
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
