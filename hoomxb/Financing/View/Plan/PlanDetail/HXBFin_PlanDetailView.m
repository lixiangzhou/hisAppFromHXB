//
//  HXBFin_PlanDetailView.m
//  hoomxb
//
//  Created by HXB on 2017/7/11.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_PlanDetailView.h"

#import "HXBFin_DetailsViewBase.h"
#import "HXBFinBase_FlowChartView.h"
#import "HXBFinDetail_TableView.h"

#import "HXBFinDetailViewModel_PlanDetail.h"//红利计划详情的ViewModel

#import "HXBFinDetailModel_PlanDetail.h"//红利计划详情的Model

#import "HXBFinHomePageViewModel_PlanList.h"///红利计划列表页Viewmodel

#import "HXBFinHomePageModel_PlanList.h"
#import "HXBFin_PlanDetailView_TopView.h"
#import "HXBFinPlanContract_ContractWebView.h"///曾信是一个h5
@interface HXBFin_PlanDetailView()
@property (nonatomic,strong) HXBFin_PlanDetailView_ViewModelVM *viewModelVM;
///预期年化的view
@property (nonatomic,strong) HXBColourGradientView *expectedYearRateView;
@property (nonatomic,strong) HXBFin_PlanDetailView_TopView *topView;
///曾信View
@property (nonnull,strong) UIImageView *trustView;
///剩余可投
@property (nonatomic,strong) UIView *surplusValueView;
///流程引导视图
@property (nonatomic,strong) HXBFinBase_FlowChartView *flowChartView;
///立即加入视图
@property (nonatomic,strong) UIView *addView;
///立即加入 倒计时
@property (nonatomic,strong) UILabel *countDownLabel;
///* 预期收益不代表实际收益投资需谨慎
@property (nonatomic,copy) NSString *promptStr;
/// 底部的tableView
@property (nonatomic,strong) HXBFinDetail_TableView *bottomTableView;

//用到的字段
///预期计划
@property (nonatomic,copy) NSString *totalInterestStr;
///红利计划为：预期年利率 散标为：年利率
@property (nonatomic,copy) NSString *totalInterestStr_const;
@property (nonatomic,copy) NSString *lockPeriodStr;
///红利计划：（起投 固定值1000） 散标：（标的期限）
@property (nonatomic,copy) NSString *startInvestmentStr;
@property (nonatomic,copy) NSString *startInvestmentStr_const;

///红利计划：剩余金额 散标列表是（剩余金额）
@property (nonatomic,copy) NSString *remainAmount;
@property (nonatomic,copy) NSString *remainAmount_const;
@property (nonatomic,copy) NSString *addButtonStr;
///底部的tableView被点击
@property (nonatomic,copy) void (^clickBottomTabelViewCellBlock)(NSIndexPath *index, HXBFinDetail_TableViewCellModel *model);
@property (nonatomic,copy) void (^clickAddButtonBlock)();
@property (nonatomic,copy) void (^clickAddTrustBlock) ();
///加入的button
@property (nonatomic,strong) UIButton *addButton;
///倒计时
@property (nonatomic,copy) NSString *diffTime;
/// 是否倒计时
@property (nonatomic,assign) BOOL isContDown;

///倒计时管理
@property (nonatomic,strong) HXBBaseCountDownManager_lightweight *countDownManager;

@end


@implementation HXBFin_PlanDetailView

@synthesize viewModelVM = _viewModelVM;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kHXBColor_BackGround;
        [self show];
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
- (HXBBaseCountDownManager_lightweight *)countDownManager {
    if (!_countDownManager) {
        _countDownManager = [[HXBBaseCountDownManager_lightweight alloc]initWithCountDownEndTime:self.diffTime.floatValue /1000 andCountDownEndTimeType:HXBBaseCountDownManager_lightweight_CountDownEndTime_CompareType_Now andCountDownDuration:360000 andCountDownUnit:1];
    }
    return _countDownManager;
}
- (void)setIsContDown:(BOOL)isContDown {
    _isContDown = isContDown;
    if (isContDown) {
        kWeakSelf
        [self.countDownManager resumeTimer];
        [self.countDownManager countDownCallBackFunc:^(CGFloat countDownValue) {
            if (countDownValue < 0) {
                [self.addButton setTitle:weakSelf.viewModelVM.addButtonStr forState:UIControlStateNormal];
                [self.countDownManager stopTimer];
                return;
            }
            NSString *str = [[HXBBaseHandDate sharedHandleDate] stringFromDate:@(countDownValue) andDateFormat:@"mm分ss秒"];
            [weakSelf.addButton setTitle:str forState:UIControlStateNormal];
        }];
    }
}
- (void)setDiffTime:(NSString *)diffTime {
    _diffTime = diffTime;
}
- (HXBFin_PlanDetailView_ViewModelVM *) viewModelVM {
    if (!_viewModelVM) {
        //        kWeakSelf
        _viewModelVM = [[HXBFin_PlanDetailView_ViewModelVM alloc]init];
        //        [_viewModelVM addButtonChengeTitleChenge:^(NSString * buttonStr) {
        //            [weakSelf.addButton setTitle:buttonStr forState:UIControlStateNormal];
        //        }];
    }
    return _viewModelVM;
}


- (void)setUPViewModelVM: (HXBFin_PlanDetailView_ViewModelVM* (^)(HXBFin_PlanDetailView_ViewModelVM *viewModelVM))detailsViewBase_ViewModelVMBlock {
    self.viewModelVM = detailsViewBase_ViewModelVMBlock(self.viewModelVM);
    ///倒计时
    self.diffTime = _viewModelVM.diffTime;
    //是否倒计时
    self.isContDown = _viewModelVM.isCountDown;
}


- (void)setViewModelVM:(HXBFin_PlanDetailView_ViewModelVM *)viewModelVM {
    _viewModelVM = viewModelVM;
    self.totalInterestStr           = viewModelVM.totalInterestStr;
    self.startInvestmentStr         = viewModelVM.startInvestmentStr;
    self.remainAmount               = viewModelVM.remainAmount;
    
    self.totalInterestStr_const     = viewModelVM.totalInterestStr_const;
    self.remainAmount_const         = viewModelVM.remainAmount_const;
    self.startInvestmentStr_const   = viewModelVM.startInvestmentStr_const;
    self.promptStr                  = viewModelVM.promptStr;
    self.addButtonStr               = viewModelVM.addButtonStr;
    self.lockPeriodStr              = viewModelVM.lockPeriodStr;
    self.addButton.userInteractionEnabled = self.viewModelVM.isUserInteractionEnabled;
    [self.addButton setTitle:viewModelVM.addButtonStr forState:UIControlStateNormal];
    kWeakSelf
    [self.topView setUPValueWithManager:^HXBFin_PlanDetailView_TopViewManager *(HXBFin_PlanDetailView_TopViewManager *manager) {
        manager.topViewManager.leftLabelStr = [NSString stringWithFormat:@"%@%@",weakSelf.viewModelVM.totalInterestStr,@"%"];
        manager.topViewManager.rightLabelStr = @"平均历史年化收益";
        
        manager.leftViewManager.leftLabelStr = weakSelf.lockPeriodStr;
        manager.leftViewManager.rightLabelStr = @"期限";
        
        manager.midViewManager.leftLabelStr = weakSelf.startInvestmentStr;
        manager.midViewManager.rightLabelStr = weakSelf.startInvestmentStr_const;
        
        manager.rightViewManager.rightLabelStr = weakSelf.remainAmount_const;
        manager.rightViewManager.leftLabelStr = weakSelf.remainAmount;
        return manager;
    }];
}

- (void) setAddButtonStr:(NSString *)addButtonStr {
    _addButtonStr = addButtonStr;
    [self.addButton setTitle:addButtonStr forState:UIControlStateNormal];
}
- (void)setModelArray:(NSArray<HXBFinDetail_TableViewCellModel *> *)modelArray {
    _modelArray = modelArray;
    self.bottomTableView.tableViewCellModelArray = modelArray;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
   
}
- (void)setupSubView {
    [self setUPBackGroundImageView];
    [self setUPTopView];
    [self setupAddTrustView];//曾信view（内部对是否分为左右进行了判断）
    [self setupFlowChartView];///流程引导视图
    [self setupTableView];///展示计划详情等的 tableView
    [self setupAddView];///立即加入视图
    
    self.surplusValueView.backgroundColor = [UIColor whiteColor];
    self.flowChartView.backgroundColor = [UIColor whiteColor];
    self.addView.backgroundColor = HXBC_Red_Deep;
}

- (void)setUPTopView {
    self.topView = [[HXBFin_PlanDetailView_TopView alloc]initWithFrame:CGRectZero];
    self.topView.backgroundColor = [UIColor clearColor];
    [self addSubview: self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(248) - 64));
    }];
}

//MARK: - 增信
- (void)setupAddTrustView {
    self.trustView = [[UIImageView alloc]init];
    self.trustView.backgroundColor = [UIColor whiteColor];
    self.trustView.userInteractionEnabled = true;
    [self addSubview: self.trustView];
    [self.trustView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(kScrAdaptationH(10));
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(80)));
    }];
    ///落地页
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(clickAddTrust:)];
    [self.trustView addGestureRecognizer: tap];
}
- (void)clickAddTrust:(UITapGestureRecognizer *)tap {
    if (self.clickAddTrustBlock) {
        self.clickAddTrustBlock();
    }
}

//MARK: - 引导视图
- (void)setupFlowChartView {
    self.flowChartView = [[HXBFinBase_FlowChartView alloc]init];
    [self addSubview:self.flowChartView];
    [self.flowChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.trustView.mas_bottom).offset(kScrAdaptationH(10));
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(108)));
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
        make.height.equalTo(@(kScrAdaptationH(60)));
    }];
    self.addButton = [[UIButton alloc]init];
    
    [self addSubview:_addButton];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf);
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(@(kScrAdaptationH(60)));
    }];
    [self.addButton addTarget:self action:@selector(clickAddButton:) forControlEvents:UIControlEventTouchUpInside];
    self.addButton.backgroundColor = [UIColor clearColor];
    [self.addButton setTitle:self.addButtonStr forState:UIControlStateNormal];

    
    self.countDownLabel = [[UILabel alloc]init];
    [self addSubview: self.countDownLabel];
    [self.countDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.addButton.mas_top);
        make.centerX.equalTo(self.addButton);
        make.height.equalTo(@(kScrAdaptationH(30)));
    }];
    self.addButton.userInteractionEnabled = true;
}

- (void)clickAddButton: (UIButton *)button {
    NSLog(@" - 立即加入 - ");
    //a)	先判断是否>=1000，再判断是否为1000的整数倍（追加时只需判断是否为1000的整数倍），错误，toast提示“起投金额1000元”或“投资金额应为1000的整数倍”
    if (self.clickAddButtonBlock) {
        self.clickAddButtonBlock();
    }
}


//MARK: - 展示计划详情等的 tableView
- (void)setupTableView {
    kWeakSelf
    self.bottomTableView = [[HXBFinDetail_TableView alloc]init];
    self.bottomTableView.tableViewCellModelArray = self.modelArray;
    self.bottomTableView.bounces = false;
    [self addSubview:self.bottomTableView];
    [self.bottomTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.flowChartView.mas_bottom).offset(kScrAdaptationH(10));
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(@(kScrAdaptationH(134)));
    }];
    //cell的点击事件
    [self.bottomTableView clickBottomTableViewCellBloakFunc:^(NSIndexPath *index, HXBFinDetail_TableViewCellModel *model) {
        if (self.clickBottomTabelViewCellBlock) {
            self.clickBottomTabelViewCellBlock(index,model);
        }
    }];
    UILabel *lable = [[UILabel alloc]init];
    [self addSubview:lable];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bottomTableView.mas_bottom);
        make.left.right.equalTo(weakSelf);
        make.centerX.equalTo(weakSelf);
    }];
    lable.text = self.promptStr;
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor grayColor];
}
//MARK: 事件的传递
- (void)clickBottomTableViewCellBloakFunc:(void (^)(NSIndexPath *, HXBFinDetail_TableViewCellModel *))clickBottomTabelViewCellBlock {
    self.clickBottomTabelViewCellBlock = clickBottomTabelViewCellBlock;
}
/// 点击了立即加入的button
- (void) clickAddButtonFunc: (void(^)())clickAddButtonBlock {
    self.clickAddButtonBlock = clickAddButtonBlock;
}

///点击了增信
- (void)clickAddTrustWithBlock:(void(^)())clickAddTrustBlock{
    self.clickAddTrustBlock = clickAddTrustBlock;
}
@end




@implementation HXBFin_PlanDetailView_ViewModelVM
@end
