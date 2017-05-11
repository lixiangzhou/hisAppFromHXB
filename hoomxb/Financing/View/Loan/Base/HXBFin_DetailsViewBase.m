//
//  HXBFin_DetailsViewBase.m
//  hoomxb
//
//  Created by HXB on 2017/5/5.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_DetailsViewBase.h"
#import "HXBFinBase_FlowChartView.h"
#import "HXBFinDetail_TableView.h"

#import "HXBFinDetailViewModel_PlanDetail.h"//红利计划详情的ViewModel
#import "HXBFinDetailViewModel_LoanDetail.h"//散标详情的ViewMOdel

#import "HXBFinDetailModel_PlanDetail.h"//红利计划详情的Model
#import "HXBFinDetailModel_LoanDetail.h"//散标详情的Model

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
///* 预期收益不代表实际收益投资需谨慎
@property (nonatomic,copy) NSString *promptStr;
/// 底部的tableView
@property (nonatomic,strong) HXBFinDetail_TableView *bottomTableView;


//用到的字段
///预期计划
@property (nonatomic,copy) NSString *totalInterestStr;
///红利计划为：预期年利率 散标为：年利率
@property (nonatomic,copy) NSString *totalInterestStr_const;

///红利计划：（起投 固定值1000） 散标：（标的期限）
@property (nonatomic,copy) NSString *startInvestmentStr;
@property (nonatomic,copy) NSString *startInvestmentStr_const;

///红利计划：剩余金额 散标列表是（剩余金额）
@property (nonatomic,copy) NSString *remainAmount;
@property (nonatomic,copy) NSString *remainAmount_const;
@end

@implementation HXBFin_DetailsViewBase
- (void)setModelArray:(NSArray<HXBFinDetail_TableViewCellModel *> *)modelArray {
    _modelArray = modelArray;
    self.bottomTableView.tableViewCellModelArray = modelArray;
}
#pragma mark - setter
- (void)setPlanDetailViewModel:(HXBFinDetailViewModel_PlanDetail *)planDetailViewModel {
    _planDetailViewModel = planDetailViewModel;
    self.totalInterestStr = planDetailViewModel.planDetailModel.totalInterest;
    self.startInvestmentStr = @"1000元";
    self.remainAmount = self.planDetailViewModel.planDetailModel.dataList.firstObject.remainAmount;
    
    
    self.totalInterestStr_const = @"年利率";
    self.remainAmount_const = @"剩余金额";
    self.startInvestmentStr_const = @"标的期限";
    self.promptStr = @"* 预期收益不代表实际收益投资需谨慎";
    
    [self show];
}
- (void)setLoanDetailViewModel:(HXBFinDetailViewModel_LoanDetail *)loanDetailViewModel{
    _loanDetailViewModel = loanDetailViewModel;
//    self.startInvestmentStr = [NSString stringWithFormat:@"%@",loanDetailViewModel.loanDetailModel.];
    self.totalInterestStr_const = @"预期年利率";
    self.remainAmount_const = @"剩余可投";
    self.startInvestmentStr_const = @"起投";
    self.promptStr = @"* 预期收益不代表实际收益投资需谨慎";
    [self show];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    }
    return self;
}

- (void)show {
    //移除子控件，在进行UI布局
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    [self setupSubView];
}
- (void)setupSubView {
    
    [self setupExpectedYearRateView];///预期年化的view
    [self setupSurplusValueView]; ///剩余可投里面
    [self setupAddTrustView];//曾信view（内部对是否分为左右进行了判断）
    [self setupFlowChartView];///流程引导视图
    [self setupTableView];///展示计划详情等的 tableView
    [self setupAddView];///立即加入视图
    
    self.expectedYearRateView.backgroundColor = [UIColor whiteColor];
    self.surplusValueView.backgroundColor = [UIColor whiteColor];
    self.flowChartView.backgroundColor = [UIColor darkGrayColor];
    self.addView.backgroundColor = [UIColor grayColor];
//    self.trustView.backgroundColor = [UIColor hxb_randomColor];
//    self.bottomTableView.backgroundColor = [UIColor redColor];
}

//MARK: - 预期年化的view
- (void)setupExpectedYearRateView {
    self.expectedYearRateView = [[UIView alloc]init];
    self.expectedYearRateView.frame = CGRectMake(0, 0, self.width, 200);
    [self addSubview:self.expectedYearRateView];
    [self upDownLableWithView:self.expectedYearRateView andDistance:20 andFirstFont:[UIFont systemFontOfSize:40] andFirstStr:[NSString stringWithFormat:@"%@%@",self.totalInterestStr,@"%"]  andSecondStr:[NSString stringWithFormat:@"%@",self.totalInterestStr_const]];
}

//MARK: - 剩余可投view
- (void)setupSurplusValueView {
    self.surplusValueView = [[UIView alloc]init];
    [self addSubview:self.surplusValueView];
    
    __weak typeof (self) weakSelf = self;
    [self.surplusValueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.expectedYearRateView.mas_bottom).offset(1);
        make.right.left.equalTo(weakSelf);
        make.height.equalTo(@80);
    }];
    
    //是否分为左右两个（起投，剩余金额）
    if (self.isFlowChart) {
        [self setupSurplusValueViewWithTowView];
    }else{
        [self upDownLableWithView:self.surplusValueView andDistance:10 andFirstFont:[UIFont systemFontOfSize:30] andFirstStr:self.remainAmount andSecondStr:self.remainAmount_const];
    }
}
//剩余投资（起投，剩余金额
- (void)setupSurplusValueViewWithTowView {
    __weak typeof (self) weakSelf = self;
    UIView *leftView = [[UIView alloc]init];
    leftView.layer.borderWidth = 0.5;
    leftView.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
    [self.surplusValueView addSubview:leftView];
    UIView *rightView = [[UIView alloc]init];
    rightView.layer.borderWidth = 0.5;
    rightView.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
    [self.surplusValueView addSubview:rightView];
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_centerX);
        make.height.left.top.equalTo(weakSelf.surplusValueView);
    }];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_centerX);
        make.height.right.top.equalTo(weakSelf.surplusValueView);
    }];
    
    [self upDownLableWithView:leftView andDistance:10 andFirstFont:[UIFont systemFontOfSize:30] andFirstStr:self.startInvestmentStr andSecondStr:self.startInvestmentStr_const];
    [self upDownLableWithView:rightView andDistance:10 andFirstFont:[UIFont systemFontOfSize:30] andFirstStr:self.remainAmount andSecondStr:self.remainAmount_const];
}
//MARK: - 增信
- (void)setupAddTrustView {
    kWeakSelf
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
    kWeakSelf
    //如果是 则用增信view 不是则用剩余可投view作为约束参考
    UIView *view = self.isFlowChart ? self.trustView : self.surplusValueView;
    self.flowChartView = [[HXBFinBase_FlowChartView alloc]init];
    [self addSubview:self.flowChartView];
    [self.flowChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom);
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(@100);
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
        make.height.equalTo(@60);
    }];
    UIButton *addButton = [[UIButton alloc]init];
    [self.addView addSubview:addButton];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
}


//MARK: - 展示计划详情等的 tableView
- (void)setupTableView {
    kWeakSelf
//    if (!self.isFlowChart) return;
    self.bottomTableView = [[HXBFinDetail_TableView alloc]init];
    self.bottomTableView.tableViewCellModelArray = self.modelArray;
    self.bottomTableView.bounces = false;
    [self addSubview:self.bottomTableView];
    [self.bottomTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.flowChartView.mas_bottom).offset(0);
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(@120);
    }];
    
    self.bottomTableView.rowHeight = 40;
    UILabel *lable = [[UILabel alloc]init];
    [self addSubview:lable];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bottomTableView.mas_bottom);
        make.left.right.equalTo(weakSelf);
        make.centerX.equalTo(weakSelf);
    }];
    lable.text = self.promptStr;
    lable.textColor = [UIColor grayColor];
}

@end
