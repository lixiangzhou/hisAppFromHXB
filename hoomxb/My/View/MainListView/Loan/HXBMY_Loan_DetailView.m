//
//  HXBMY_Loan_DetailView.m
//  hoomxb
//
//  Created by HXB on 2017/6/26.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_Loan_DetailView.h"

#import "HXBMYViewModel_LoanDetailViewModel.h"//loan  detail viewModel
#import "HXBFinDetail_TableView.h"
@interface HXBMY_Loan_DetailView ()

/**
 顶部的View
 */
@property (nonatomic,strong) HXBColourGradientView *topView;
/**
 状态的 view
 */
@property (nonatomic,strong) UIView                         *topStatusView;
@property (nonatomic,strong) UIImageView                    *topStatusImageView;
/**
 状态的Label
 */
@property (nonatomic,strong) UILabel                        *topStatusLabel;

/**
 代售金额
 */
@property (nonatomic,strong) HXBBaseView_TwoLable_View *toRepayLable;
/**
 下一个还款日
 */
@property (nonatomic,strong) HXBBaseView_TwoLable_View *nextRepayDateLable;
/**
 月收本金
 */
@property (nonatomic,strong) HXBBaseView_TwoLable_View *monthlyPrincipal;
/**
 已还期数
 */
@property (nonatomic,strong) UILabel *termsLeft;

/**
 中间的展示信息的view
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomView *infoView;
/**
 合同
 */
//@property (nonatomic,strong) HXBBaseView_MoreTopBottomView *contractLabel;
///manager
@property (nonatomic,strong) HXBMY_Loan_DetailViewManager *manager;
/**
 投资记录
 红利计划服务协议
 */
@property (nonatomic,strong) HXBFinDetail_TableView *tableView;
/**
 红利计划服务协议 投资记录的点击事件
 */
@property (nonatomic,strong) void(^clickBottomTableViewCell) (NSInteger index);
@end

@implementation HXBMY_Loan_DetailView

- (void)setUPValueWithManagerBlock: (HXBMY_Loan_DetailViewManager *(^)(HXBMY_Loan_DetailViewManager *manager))managerBlock {
    self.manager = managerBlock(self.manager);
}
- (void)setManager:(HXBMY_Loan_DetailViewManager *)manager {
    _manager = manager;
    self.topStatusLabel.text = manager.termsLeftStr;
    self.topStatusImageView.svgImageString = manager.statusImageName;
    //topView setUP
    [self.toRepayLable setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        return manager.toRepayLableManager;
    }];
    [self.nextRepayDateLable setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        return manager.nextRepayDateLableManager;
    }];
    [self.monthlyPrincipal setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        return manager.monthlyPrincipalManager;
    }];
    
    //info setUP
    [self.infoView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        return manager.infoViewManager;
    }];
    
    //合同 setuP
//    [self.contractLabel setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
//       return manager.contractLabelManager;
//    }];
    self.tableView.strArray = manager.strArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _manager = [[HXBMY_Loan_DetailViewManager alloc]init];
        [self setUP];
    }
    return self;
}

- (void)setUP {
    [self setUPTopView];//顶部的view]
    [self setUPInfoView];//中间的info的view
    [self setUPContractLabel];//底部的合同
    [self setUPViewFrame];//设置frame
}
//顶部的view
- (void) setUPTopView {
    self.topView            = [[HXBColourGradientView alloc]init];
    self.topStatusLabel = [[UILabel alloc]init];
    self.topStatusView  = [[UIView alloc]init];
    self.topStatusImageView = [[UIImageView alloc]init];
    
    self.topStatusLabel.textColor = [UIColor whiteColor];
    self.topStatusView.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.8].CGColor;
    self.topStatusView.layer.borderWidth = 1;
    self.topStatusView.layer.masksToBounds = true;
    self.topStatusLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
    self.topStatusLabel.textColor = [UIColor colorWithWhite:1 alpha:0.8];
    self.topStatusView.layer.cornerRadius = kScrAdaptationH750(54)/2.0;

    
    self.toRepayLable       = [[HXBBaseView_TwoLable_View alloc]init];
    self.nextRepayDateLable = [[HXBBaseView_TwoLable_View alloc]init];
    self.monthlyPrincipal   = [[HXBBaseView_TwoLable_View alloc]init];
    [self addSubview:self.topView];
    [self.topView addSubview:self.toRepayLable];
    [self.topView addSubview:self.monthlyPrincipal];
    [self.topView addSubview:self.nextRepayDateLable];
    
    [self.topView addSubview: self.topStatusView];
    [self.topStatusView addSubview:self.topStatusLabel];
    [self.topView addSubview: self.topStatusImageView];
    
}
//中间的infoView
- (void)setUPInfoView {
     UIEdgeInsets infoView_insets = UIEdgeInsetsMake(kScrAdaptationH750(30), kScrAdaptationH750(30), kScrAdaptationH750(30), kScrAdaptationH750(30));
    self.infoView = [[HXBBaseView_MoreTopBottomView alloc]initWithFrame:CGRectNull andTopBottomViewNumber:5 andViewClass:[UILabel class] andViewHeight:kScrAdaptationH750(30) andTopBottomSpace:kScrAdaptationH750(40) andLeftRightLeftProportion:0 Space:infoView_insets];
    [self addSubview:self.infoView];
}
//合同
- (void)setUPContractLabel {
    self.tableView = [[HXBFinDetail_TableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self addSubview:self.tableView];
}
//设置frame
- (void)setUPViewFrame {
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH750(603)-64));
    }];
    
    [self.topStatusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView).offset(kScrAdaptationH750(60));
        make.right.equalTo(self.topView).offset(40);
        make.height.equalTo(@(kScrAdaptationH750(54)));
        make.right.equalTo(self.topStatusLabel).offset(kScrAdaptationW750(100));
        make.left.equalTo(self.topStatusLabel).offset(kScrAdaptationW750(-73));
    }];
    [self.topStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.topStatusView);
        make.right.equalTo(self.topStatusView).offset(kScrAdaptationH750(-100));
        make.left.equalTo(self.topStatusView).offset(kScrAdaptationW750(73));
    }];
    [self.topStatusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topStatusLabel);
        make.right.equalTo(self.topStatusLabel.mas_left).offset(kScrAdaptationW750(-13));
        make.height.width.equalTo(@(kScrAdaptationW750(22)));
    }];
    [self.topStatusLabel sizeToFit];

    
    [self.toRepayLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView).offset(kScrAdaptationH750(266)-64);
        make.centerX.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH750(143)));
        make.left.right.equalTo(self);
    }];
    [self.nextRepayDateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.topView).offset(kScrAdaptationH750(-70));
        make.left.equalTo(self.topView);
        make.right.equalTo(self.topView.mas_centerX);
        make.height.equalTo(@(kScrAdaptationH750(64)));
    }];
    [self.monthlyPrincipal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.topView).offset(kScrAdaptationH750(-70));
        make.right.equalTo(self.topView);
        make.left.equalTo(self.topView.mas_centerX);
        make.height.equalTo(@(kScrAdaptationH750(64)));
    }];
    
    //中间的info
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(kScrAdaptationH750(20));
        make.right.left.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH750(370)));
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoView.mas_bottom).offset(kScrAdaptationH750(20));
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH750(90)));
    }];
    kWeakSelf
    [self.tableView clickBottomTableViewCellBloakFunc:^(NSIndexPath *index, HXBFinDetail_TableViewCellModel *model) {
        if (weakSelf.clickBottomTableViewCell) {
            weakSelf.clickBottomTableViewCell(index.row);
        }
    }];
    
    self.infoView.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
}
- (void)clickBottomTableViewCellBloakFunc:(void(^)(NSInteger index))clickBottomTableViewCell {
    self.clickBottomTableViewCell = clickBottomTableViewCell;
}
@end
@implementation HXBMY_Loan_DetailViewManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.toRepayLableManager        = [[HXBBaseView_TwoLable_View_ViewModel alloc]init];
        self.toRepayLableManager.leftLabelAlignment = NSTextAlignmentCenter;
        self.toRepayLableManager.rightLabelAlignment = NSTextAlignmentCenter;
        self.toRepayLableManager.leftFont = kHXBFont_PINGFANGSC_REGULAR_750(80);
        self.toRepayLableManager.rightFont = kHXBFont_PINGFANGSC_REGULAR_750(24);
        self.toRepayLableManager.leftViewColor = [UIColor whiteColor];
        self.toRepayLableManager.rightViewColor = [UIColor colorWithWhite:1 alpha:0.6];
        
        
        self.nextRepayDateLableManager  = [[HXBBaseView_TwoLable_View_ViewModel alloc]init];
        self.nextRepayDateLableManager.leftLabelAlignment = NSTextAlignmentCenter;
        self.nextRepayDateLableManager.rightLabelAlignment = NSTextAlignmentCenter;
        self.nextRepayDateLableManager.leftFont = kHXBFont_PINGFANGSC_REGULAR_750(30);
        self.nextRepayDateLableManager.rightFont = kHXBFont_PINGFANGSC_REGULAR_750(24);
        self.nextRepayDateLableManager.leftViewColor = [UIColor whiteColor];;
        self.nextRepayDateLableManager.rightViewColor = [UIColor colorWithWhite:1 alpha:0.6];
        
        self.monthlyPrincipalManager    = [[HXBBaseView_TwoLable_View_ViewModel alloc]init];
        self.monthlyPrincipalManager.leftLabelAlignment = NSTextAlignmentCenter;
        self.monthlyPrincipalManager.rightLabelAlignment = NSTextAlignmentCenter;
        self.monthlyPrincipalManager.leftFont = kHXBFont_PINGFANGSC_REGULAR_750(30);
        self.monthlyPrincipalManager.rightFont = kHXBFont_PINGFANGSC_REGULAR_750(24);
        self.monthlyPrincipalManager.leftViewColor = [UIColor whiteColor];;
        self.monthlyPrincipalManager.rightViewColor = [UIColor colorWithWhite:1 alpha:0.6];
        
        
        self.infoViewManager            = [[HXBBaseView_MoreTopBottomViewManager alloc]init];
        self.infoViewManager.leftLabelAlignment = NSTextAlignmentLeft;
        self.infoViewManager.rightLabelAlignment = NSTextAlignmentRight;
        self.infoViewManager.leftFont = kHXBFont_PINGFANGSC_REGULAR_750(30);
        self.infoViewManager.rightFont = kHXBFont_PINGFANGSC_REGULAR_750(30);
        self.infoViewManager.leftTextColor = kHXBColor_Grey_Font0_2;
        self.infoViewManager.rightTextColor = RGB(153, 153, 153);
        
        self.contractLabelManager       = [[HXBBaseView_MoreTopBottomViewManager alloc]init];
        self.contractLabelManager.leftLabelAlignment = NSTextAlignmentLeft;
        self.contractLabelManager.rightLabelAlignment = NSTextAlignmentRight;
        self.contractLabelManager.leftFont = kHXBFont_PINGFANGSC_REGULAR_750(30);
        self.contractLabelManager.rightFont = kHXBFont_PINGFANGSC_REGULAR_750(30);
        self.contractLabelManager.leftTextColor = kHXBColor_Grey_Font0_2;
        self.contractLabelManager.rightTextColor = kHXBColor_HeightGrey_Font0_4;
    }
    return self;
}
@end
