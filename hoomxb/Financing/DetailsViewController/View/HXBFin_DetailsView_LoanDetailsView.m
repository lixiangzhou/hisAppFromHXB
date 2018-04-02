//
//  HXBFin_DetailsView_LoanDetailsView.m
//  hoomxb
//
//  Created by HXB on 2017/5/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_DetailsView_LoanDetailsView.h"
#import "HXBFinBase_FlowChartView.h"
#import "HXBFinDetail_TableView.h"

#import "HXBFinDetailViewModel_LoanDetail.h"//散标详情的ViewMOdel
#import "HXBFinDatailModel_LoanDetail.h"//散标详情的Model
#import "HXBFinHomePageViewModel_LoanList.h"///散标列表页的Viewmodel\
#import "HXBFinHomePageModel_LoanList.h"
#import "HXBFin_LoanDetailView_TopView.h"
#import "HXBFinPlanContract_ContractWebView.h"///曾信任服务协议
#import "HXBBaseHandDate.h"

@interface HXBFin_DetailsView_LoanDetailsView ()
@property (nonatomic,strong) HXBFin_DetailsView_LoanDetailsView_ViewModelVM *viewModelVM;
///预期年化的view
@property (nonatomic,strong) HXBColourGradientView *expectedYearRateView;
@property (nonatomic,strong) HXBFin_LoanDetailView_TopView *topView;
///曾信View
@property (nonnull,strong) UIImageView *trustView;
///剩余可投
@property (nonatomic,strong) UIView *surplusValueView;
///流程引导视图
@property (nonatomic,strong) HXBFinBase_FlowChartView *flowChartView;
/// 起息日
@property (nonatomic,strong) HXBBaseView_MoreTopBottomView *interestDateView;
///还款方式
@property (nonatomic,strong) HXBBaseView_MoreTopBottomView *loanTypeView;
///换款方式的底部试图
@property (nonatomic,strong) UIView *loanTypeViewContentView;
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

///倒计时
@property (nonatomic,copy) NSString *diffTime;
/// 是否倒计时
@property (nonatomic,assign) BOOL isContDown;

///倒计时管理
@property (nonatomic,strong) HXBBaseCountDownManager_lightweight *countDownManager;

@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *countDownLabel;
///预期收益不代表实际收益，投资需谨慎
@property (nonatomic,strong) UILabel *promptLablel;
@end
@implementation HXBFin_DetailsView_LoanDetailsView
@synthesize viewModelVM = _viewModelVM;

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
            NSString *str = [[HXBBaseHandDate sharedHandleDate] stringFromDate:@(countDownValue) andDateFormat:@"mm分ss秒"];
            [weakSelf.addButton setTitle:str forState:UIControlStateNormal];
            if (countDownValue < 0) {
                [weakSelf.countDownManager stopTimer];
            }
        }];
    }
}
- (void)setDiffTime:(NSString *)diffTime {
    _diffTime = diffTime;
}
- (HXBFin_DetailsView_LoanDetailsView_ViewModelVM *) viewModelVM {
    if (!_viewModelVM) {
        //        kWeakSelf
        _viewModelVM = [[HXBFin_DetailsView_LoanDetailsView_ViewModelVM alloc]init];
        //        [_viewModelVM addButtonChengeTitleChenge:^(NSString * buttonStr) {
        //            [weakSelf.addButton setTitle:buttonStr forState:UIControlStateNormal];
        //        }];
    }
    return _viewModelVM;
}


- (void)setUPViewModelVM: (HXBFin_DetailsView_LoanDetailsView_ViewModelVM* (^)(HXBFin_DetailsView_LoanDetailsView_ViewModelVM *viewModelVM))detailsViewBase_ViewModelVMBlock {
    self.viewModelVM = detailsViewBase_ViewModelVMBlock(self.viewModelVM);
    ///倒计时
    self.diffTime = _viewModelVM.diffTime;
    //是否倒计时
    self.isContDown = _viewModelVM.isCountDown;
}


- (void)setViewModelVM:(HXBFin_DetailsView_LoanDetailsView_ViewModelVM *)viewModelVM {
    _viewModelVM = viewModelVM;
    self.totalInterestStr           = viewModelVM.totalInterestStr;
    self.startInvestmentStr         = viewModelVM.startInvestmentStr;
    self.remainAmount               = viewModelVM.remainAmount;
    
    self.totalInterestStr_const     = viewModelVM.totalInterestStr_const;
    self.remainAmount_const         = viewModelVM.remainAmount_const;
    self.startInvestmentStr_const   = viewModelVM.startInvestmentStr_const;
    self.promptStr                  = viewModelVM.promptStr;
    self.addButtonStr               = viewModelVM.addButtonStr;
    self.lockPeriodStr              = viewModelVM.startInvestmentStr;
    
    self.addButton.userInteractionEnabled = self.viewModelVM.isUserInteractionEnabled;
    self.addButton.backgroundColor = self.viewModelVM.addButtonBackgroundColor;
    [self.addButton setTitleColor:self.viewModelVM.addButtonTitleColor forState:UIControlStateNormal];
    
    if (viewModelVM.isInProgress) {
        [self.interestDateView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
        }];
        self.interestDateView.hidden = NO;
        
        [self.interestDateView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
            
            NSString *interestDate = [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:viewModelVM.interestDate andDateFormat:@"yyyy-MM-dd"];
            viewManager.leftStrArray = @[@"起息日"];
            viewManager.rightStrArray = @[interestDate];

            viewManager.leftLabelAlignment = NSTextAlignmentLeft;
            viewManager.rightLabelAlignment = NSTextAlignmentRight;
            viewManager.leftTextColor = kHXBColor_RGB(0.2, 0.2, 0.2,1);
            viewManager.rightTextColor = kHXBColor_RGB(0.4, 0.4, 0.4,1);
            viewManager.leftFont = kHXBFont_PINGFANGSC_REGULAR(15);
            viewManager.rightFont = kHXBFont_PINGFANGSC_REGULAR(15);
            return viewManager;
        }];
    } else {
        [self.interestDateView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        self.interestDateView.hidden = YES;
    }
    
    [self.loanTypeView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {

        viewManager.leftStrArray = @[@"还款方式"];
        viewManager.rightStrArray = @[@"按月等额本息"];
        viewManager.leftLabelAlignment = NSTextAlignmentLeft;
        viewManager.rightLabelAlignment = NSTextAlignmentRight;
        viewManager.leftTextColor = kHXBColor_RGB(0.2, 0.2, 0.2,1);
        viewManager.rightTextColor = kHXBColor_RGB(0.4, 0.4, 0.4,1);
        viewManager.leftFont = kHXBFont_PINGFANGSC_REGULAR(15);
        viewManager.rightFont = kHXBFont_PINGFANGSC_REGULAR(15);
        return viewManager;
    }];
    
    [self.addButton setTitle:viewModelVM.addButtonStr forState:UIControlStateNormal];
    kWeakSelf
    [self.topView setUPValueWithManager:^HXBFin_LoanDetailView_TopViewManager *(HXBFin_LoanDetailView_TopViewManager *manager) {
        manager.topViewManager.leftLabelStr = [NSString stringWithFormat:@"%.2f%%",[weakSelf.viewModelVM.totalInterestStr floatValue]];
        manager.topViewManager.rightLabelStr = viewModelVM.totalInterestStr_const;
        
        manager.leftViewManager.leftLabelStr = weakSelf.lockPeriodStr;
        manager.leftViewManager.rightLabelStr = viewModelVM.startInvestmentStr_const;
        
        manager.rightViewManager.rightLabelStr = viewModelVM.remainAmount_const;
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
- (void)setupSubView {
    
    [self setUPTopView];
    [self setupAddTrustView];//曾信view（内部对是否分为左右进行了判断）
    [self setLoanTypeContentView];
    [self setInterestDateView];
    [self setLoantypView];///流程引导视图
    [self setupTableView];///展示计划详情等的 tableView
    [self setupAddView];///立即加入视图
    [self setUPPromptLablel];///预期收益不代表实际收益，投资需谨慎
    
    self.surplusValueView.backgroundColor = [UIColor whiteColor];
    self.flowChartView.backgroundColor = [UIColor whiteColor];
    self.addView.backgroundColor = HXBC_Red_Deep;
}

- (void)setUPTopView {
    self.topView = [[HXBFin_LoanDetailView_TopView alloc]initWithFrame:CGRectZero];
    self.topView.backgroundColor = [UIColor clearColor];
    [self addSubview: self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(268) - 64));
    }];
}

//MARK: - 增信
- (void)setupAddTrustView {
    self.trustView = [[UIImageView alloc]init];
    self.trustView.backgroundColor = [UIColor whiteColor];
    self.trustView.userInteractionEnabled = YES;
    [self addSubview: self.trustView];
    self.trustView.image = [UIImage imageNamed:@"hxb_增信"];
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

- (void)setLoanTypeContentView {
    self.loanTypeViewContentView = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:self.loanTypeViewContentView];
    self.loanTypeViewContentView.backgroundColor = [UIColor whiteColor];
    [self.loanTypeViewContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.trustView.mas_bottom).offset(kScrAdaptationH(10));
        make.left.right.equalTo(self);
    }];
}

- (void)setInterestDateView {
    [self.loanTypeViewContentView addSubview:self.interestDateView];
    [self.interestDateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loanTypeViewContentView).offset(kScrAdaptationW(15));
        make.right.equalTo(self.loanTypeViewContentView).offset(kScrAdaptationW(-15));
        make.top.equalTo(self.loanTypeViewContentView);
        make.height.equalTo(@(kScrAdaptationH(0)));
    }];
}

- (void)setLoantypView {
    [self.loanTypeViewContentView addSubview:self.loanTypeView];
    [self.loanTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loanTypeViewContentView).offset(kScrAdaptationW(15));
        make.right.equalTo(self.loanTypeViewContentView).offset(kScrAdaptationW(-15));
        make.bottom.equalTo(self.loanTypeViewContentView);
        make.top.equalTo(self.interestDateView.mas_bottom);
        make.height.equalTo(@(kScrAdaptationH(40)));
    }];
}
- (HXBBaseView_MoreTopBottomView *) loanTypeView {
    if (!_loanTypeView) {
        _loanTypeView = [[HXBBaseView_MoreTopBottomView alloc]initWithFrame:CGRectZero andTopBottomViewNumber:1 andViewClass:[UILabel class] andViewHeight:kScrAdaptationH(40) andTopBottomSpace:0 andLeftRightLeftProportion:0.5];
        _loanTypeView.backgroundColor = [UIColor whiteColor];
    }
    return _loanTypeView;
}

- (HXBBaseView_MoreTopBottomView *)interestDateView {
    if (!_interestDateView) {
        _interestDateView = [[HXBBaseView_MoreTopBottomView alloc]initWithFrame:CGRectZero andTopBottomViewNumber:1 andViewClass:[UILabel class] andViewHeight:kScrAdaptationH(40) andTopBottomSpace:0 andLeftRightLeftProportion:0.5];
        _interestDateView.backgroundColor = [UIColor whiteColor];
    }
    return _interestDateView;
}

- (void)setUPPromptLablel {
    self.promptLablel = [[UILabel alloc]init];
    [self addSubview: self.promptLablel];
    self.promptLablel.textAlignment = NSTextAlignmentCenter;
    self.promptLablel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    self.promptLablel.textColor = kHXBColor_RGB(0.6, 0.6, 0.6, 1);
    if (KeyChain.baseTitle.length > 0) {
        self.promptLablel.text = [NSString stringWithFormat:@"- %@ -",KeyChain.baseTitle];
    }
    [self.promptLablel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.bottomTableView.mas_bottom).offset(kScrAdaptationH(20));
        make.top.equalTo(self.bottomTableView.mas_bottom).offset(kScrAdaptationH(10));
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(17)));
    }];
}

//MARK: - 立即加入按钮的添加
- (void)setupAddView {
//    kWeakSelf
//    self.addView = [[UIView alloc]init];
//    [self addSubview:self.addView];
//    [self.addView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(weakSelf);
//        make.left.right.equalTo(weakSelf);
//        make.height.equalTo(@60);
//    }];
    self.addButton = [[UIButton alloc]init];
//    [self.addView addSubview:_addButton];
//    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.centerY.equalTo(weakSelf.addView);
//        make.left.top.equalTo(weakSelf.addView).offset(0);
//        make.bottom.right.equalTo(weakSelf.addView).offset(0);
//    }];
    [self.addButton addTarget:self action:@selector(clickAddButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.addButton setTitle:self.addButtonStr forState:UIControlStateNormal];
    
    
    self.countDownLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH(60))];
    [self addSubview: self.countDownLabel];
//    [self.countDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.addButton.mas_top);
//        make.centerX.equalTo(self.addButton);
//        make.height.equalTo(@(kScrAdaptationH(30)));
//    }];
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
    self.bottomTableView.hidden = YES;
    self.bottomTableView = [[HXBFinDetail_TableView alloc]init];
    self.bottomTableView.tableViewCellModelArray = self.modelArray;
    self.bottomTableView.bounces = NO;
    [self addSubview:self.bottomTableView];
    [self.bottomTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loanTypeViewContentView.mas_bottom).offset(kScrAdaptationH(10));
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(@(kScrAdaptationH(135)));
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
//        make.top.equalTo(weakSelf.bottomTableView.mas_bottom);
        make.left.right.equalTo(weakSelf);
        make.centerX.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf);
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
- (void)clickAddTrustWithBlock:(void(^)())clickAddTrustBlock {
    self.clickAddTrustBlock = clickAddTrustBlock;
}

//---------------
- (void)setData_LoanWithLoanDetailViewModel:(HXBFinDetailViewModel_LoanDetail *)LoanDetailVieModel {
    
}

- (void)setSubView {
    self.timeLabel = [[UILabel alloc]init];
    self.countDownLabel = [[UILabel alloc]init];
    
    
    [self addSubview:self.countDownLabel];
    [self addSubview:self.timeLabel];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self);
        make.height.width.equalTo(@(kScrAdaptationH(80)));
    }];
    [self.countDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
     
    }];
}
- (void)setTimeStr:(NSString *)timeStr {
    _timeStr = timeStr;
    self.timeLabel.text = timeStr;
}
@end


@implementation HXBFin_DetailsView_LoanDetailsView_ViewModelVM
@end
