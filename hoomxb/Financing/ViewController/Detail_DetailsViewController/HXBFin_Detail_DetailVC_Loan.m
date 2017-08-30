//
//  HXBFin_Detail_DetailVC_Loan.m
//  hoomxb
//
//  Created by HXB on 2017/5/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_Detail_DetailVC_Loan.h"
#import "HXBLoanInformation.h"
#import "HXBLoanInstructionView.h"
#import "HXBHXBBorrowUserinforView.h"
#import "HXBFinDetailViewModel_LoanDetail.h"
#import "HXBFin_LoanPerson_Info.h"

#import "HXBFin_LoanInfoView.h"
@interface HXBFin_Detail_DetailVC_Loan ()
@property (nonatomic, strong) HXBFin_LoanInfoView *loanInfo;
@property (nonatomic, strong) UIScrollView *scrollView;
///借款说明
@property (nonatomic,strong) HXBLoanInstructionView *loanInstuctionView;
///借款人信息
@property (nonatomic,strong) HXBFin_LoanPerson_Info *loanPerson_infoView;
///基础信息
@property (nonatomic,strong) HXBBaseView_MoreTopBottomView *loanInfoView;
///财务信息
@property (nonatomic,strong) HXBBaseView_MoreTopBottomView *loanFinView;
///工作信息
@property (nonatomic,strong) HXBBaseView_MoreTopBottomView *workInfoView;
@end

@implementation HXBFin_Detail_DetailVC_Loan

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.scrollView.contentSize = CGSizeMake(0, self.workInfoView.bottom);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
    [self.view addSubview: self.scrollView];
    self.title = @"借款信息";
    self.scrollView.backgroundColor = kHXBColor_BackGround;
    self.isColourGradientNavigationBar = true;
    
//    self.loanInfo = [[HXBFin_LoanInfoView alloc] init];
//    [self.view addSubview: self.loanInfo];
//    
//    [self.loanInfo mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
//    self.loanInfo.loan_finDatailModel = self.loanDetailViewModel;
    
    [self setUPFrame];
    [self setUPValue];
    [self setUPManager];
}

- (void)setUPManager {
    if (!self.fin_Detail_DetailVC_LoanManager) {
        NSLog(@"%@数据为空",self);
        return;
    }
    /////借款说
    self.loanInstuctionView.loanInstruction = self.fin_Detail_DetailVC_LoanManager.loanInstruction;
    ///借款人信息(预留接口)
    //    self.loanPerson_infoView
    kWeakSelf
    [self.loanInfoView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        NSLog(@"viewmanager = %@", viewManager);
        viewManager.leftStrArray = @[
                                     @"基础信息",
                                     @"姓名：",
                                     @"年龄：",
                                     @"婚姻：",
                                     @"身份证号：",
                                     @"学历：",
                                     @"籍贯：",
                                     ];
        viewManager.rightStrArray = @[      @" ",
                                            weakSelf.fin_Detail_DetailVC_LoanManager.name,
                                            weakSelf.fin_Detail_DetailVC_LoanManager.age,
                                            weakSelf.fin_Detail_DetailVC_LoanManager.marriageStatus,
                                            weakSelf.fin_Detail_DetailVC_LoanManager.idNo,
                                            weakSelf.fin_Detail_DetailVC_LoanManager.university,
                                            weakSelf.fin_Detail_DetailVC_LoanManager.homeTown
                                            ];
        
        viewManager.leftFont        = kHXBFont_PINGFANGSC_REGULAR(14);
        viewManager.rightFont       = kHXBFont_PINGFANGSC_REGULAR(14);
        viewManager.leftTextColor   = kHXBColor_HeightGrey_Font0_4;
        viewManager.rightTextColor  = kHXBColor_Font0_6;
        viewManager.rightLabelAlignment = NSTextAlignmentLeft;
        return viewManager;
    }];
    
    [self.loanFinView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        viewManager.leftStrArray = @[
                                     @"财务信息",
                                     @"车产：",
                                     @"房产：",
                                     @"房贷：",
                                     @"月收入（月）："
                                     ];
        viewManager.rightStrArray = @[
                                      @" ",
                                      weakSelf.fin_Detail_DetailVC_LoanManager.hasCar,
                                      weakSelf.fin_Detail_DetailVC_LoanManager.hasHouse,
                                      weakSelf.fin_Detail_DetailVC_LoanManager.hasHouseLoan,
                                      weakSelf.fin_Detail_DetailVC_LoanManager.monthlyIncome
                                      ];
        
        viewManager.leftFont = kHXBFont_PINGFANGSC_REGULAR(14);
        viewManager.rightFont = kHXBFont_PINGFANGSC_REGULAR(14);
        viewManager.leftTextColor = kHXBColor_HeightGrey_Font0_4;
        viewManager.rightTextColor = kHXBColor_Font0_6;
        viewManager.rightLabelAlignment = NSTextAlignmentLeft;
        return viewManager;
    }];
    
    [self.workInfoView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        viewManager.leftStrArray = @[
                                     @"工作信息",
                                     @"公司类别：",
                                     @"职位：",
                                     @"工作行业：",
                                     @"工作城市："
                                     ];
        viewManager.rightStrArray = @[
                                      @" ",
                                      weakSelf.fin_Detail_DetailVC_LoanManager.companyCategory,
                                      weakSelf.fin_Detail_DetailVC_LoanManager.companyPost,
                                      weakSelf.fin_Detail_DetailVC_LoanManager.companyIndustry,
                                      weakSelf.fin_Detail_DetailVC_LoanManager.companyLocation
                                      ];
        viewManager.leftFont = kHXBFont_PINGFANGSC_REGULAR(14);
        viewManager.rightFont = kHXBFont_PINGFANGSC_REGULAR(14);
        viewManager.leftTextColor = kHXBColor_HeightGrey_Font0_4;
        viewManager.rightTextColor = kHXBColor_Font0_6;
        viewManager.rightLabelAlignment = NSTextAlignmentLeft;
        return viewManager;
    }];

}
- (void)setUPValue {
    if (!self.loanDetailViewModel) {
        NSLog(@"%@数据为空",self);
        return;
    }
    /////借款说
    self.loanInstuctionView.loanDetailViewModel = self.loanDetailViewModel;
    ///借款人信息(预留接口)
    //    self.loanPerson_infoView
    kWeakSelf
    [self.loanInfoView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        viewManager.leftStrArray = @[
                                     @"基础信息",
                                     @"姓名：",
                                     @"年龄：",
                                     @"婚姻：",
                                     @"身份证号：",
                                     @"学历：",
                                     @"籍贯：",
                                     ];
        viewManager.rightStrArray = @[      @" ",
                                            weakSelf.loanDetailViewModel.name,
                                            weakSelf.loanDetailViewModel.age,
                                            weakSelf.loanDetailViewModel.marriageStatus,
                                            weakSelf.loanDetailViewModel.idNo,
                                            weakSelf.loanDetailViewModel.loanDetailModel.userVo.university,
                                            weakSelf.loanDetailViewModel.loanDetailModel.userVo.homeTown
                                            ];
        
        viewManager.leftFont        = kHXBFont_PINGFANGSC_REGULAR(14);
        viewManager.rightFont       = kHXBFont_PINGFANGSC_REGULAR(14);
        viewManager.leftTextColor   = kHXBColor_HeightGrey_Font0_4;
        viewManager.rightTextColor  = kHXBColor_Font0_6;
        viewManager.rightLabelAlignment = NSTextAlignmentLeft;
        return viewManager;
    }];
    
    [self.loanFinView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        viewManager.leftStrArray = @[
                                     @"财务信息",
                                     @"车产：",
                                     @"房产：",
                                     @"房贷：",
                                     @"月收入（月）："
                                     ];
        viewManager.rightStrArray = @[
                                      @" ",
                                      weakSelf.loanDetailViewModel.hasCar,
                                      weakSelf.loanDetailViewModel.hasHouse,
                                      weakSelf.loanDetailViewModel.hasHouseLoan,
                                      weakSelf.loanDetailViewModel.monthlyIncome
                                      ];
        
        viewManager.leftFont = kHXBFont_PINGFANGSC_REGULAR(14);
        viewManager.rightFont = kHXBFont_PINGFANGSC_REGULAR(14);
        viewManager.leftTextColor = kHXBColor_HeightGrey_Font0_4;
        viewManager.rightTextColor = kHXBColor_Font0_6;
        viewManager.rightLabelAlignment = NSTextAlignmentLeft;
        return viewManager;
    }];
    
    [self.workInfoView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        viewManager.leftStrArray = @[
                                     @"工作信息",
                                     @"公司类别：",
                                     @"职位：",
                                     @"工作行业：",
                                     @"工作城市："
                                     ];
        viewManager.rightStrArray = @[
                                      @" ",
                                      weakSelf.loanDetailViewModel.loanDetailModel.userVo.companyCategory,
                                      weakSelf.loanDetailViewModel.loanDetailModel.userVo.companyPost,
                                      weakSelf.loanDetailViewModel.loanDetailModel.userVo.companyIndustry,
                                      weakSelf.loanDetailViewModel.loanDetailModel.userVo.companyLocation
                                      ];
        viewManager.leftFont = kHXBFont_PINGFANGSC_REGULAR(14);
        viewManager.rightFont = kHXBFont_PINGFANGSC_REGULAR(14);
        viewManager.leftTextColor = kHXBColor_HeightGrey_Font0_4;
        viewManager.rightTextColor = kHXBColor_Font0_6;
        viewManager.rightLabelAlignment = NSTextAlignmentLeft;
        return viewManager;
    }];
}

- (void)setUPFrame {
    self.scrollView.showsHorizontalScrollIndicator = false;
    self.scrollView.showsVerticalScrollIndicator = false;
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [self.loanInstuctionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView).offset(kScrAdaptationH(10));
        make.left.right.equalTo(self.view);
    }];
    
    [self.loanPerson_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(kScrAdaptationH(140)));
        make.right.left.equalTo(self.view);
        make.top.equalTo(self.loanInstuctionView.mas_bottom).offset(kScrAdaptationH(10));
    }];
    
    [self.loanInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loanPerson_infoView.mas_bottom).offset(0);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(kScrAdaptationH(230)));
    }];
    
    [self.loanFinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loanInfoView.mas_bottom).offset(0);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(kScrAdaptationH(180)));
    }];
    
    [self.workInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loanFinView.mas_bottom).offset(0);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(kScrAdaptationH(170)));
    }];
    
    [self lienViewWithView:self.loanPerson_infoView];
    [self lienViewWithView:self.loanInfoView];
    [self lienViewWithView:self.loanFinView];
}

- (UIView *)lienViewWithView:(UIView *)view {
    UIView *lienView = [[UIView alloc]init];
    [self.scrollView addSubview:lienView];
    [lienView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).offset(0);
        make.left.equalTo(self.view).offset(kScrAdaptationW(15));
        make.right.equalTo(self.view).offset(kScrAdaptationW(-15));
        make.height.equalTo(@(1));
    }];
    lienView.backgroundColor = kHXBColor_Grey093;
    return lienView;
}


#pragma mark - getterSetter;
///借款说明
- (HXBLoanInstructionView *)loanInstuctionView {
    if (!_loanInstuctionView) {
        _loanInstuctionView = [[HXBLoanInstructionView alloc]initWithFrame:CGRectZero];
        [self.scrollView addSubview:_loanInstuctionView];
    }
    return _loanInstuctionView;
}

///借款人信息
- (HXBFin_LoanPerson_Info *)loanPerson_infoView {
    if (!_loanPerson_infoView) {
        _loanPerson_infoView = [[HXBFin_LoanPerson_Info alloc]initWithFrame:CGRectZero];
        [self.scrollView addSubview:_loanPerson_infoView];
    }
    return _loanPerson_infoView;
}

///基础信息
- (HXBBaseView_MoreTopBottomView *)loanInfoView {
    if (!_loanInfoView) {
        UIEdgeInsets insets = UIEdgeInsetsMake(kScrAdaptationW(15), kScrAdaptationW(15), kScrAdaptationW(15), kScrAdaptationW(15));
        _loanInfoView = [[HXBBaseView_MoreTopBottomView alloc]initWithFrame:CGRectZero andTopBottomViewNumber:7 andViewClass:[UILabel class] andViewHeight:kScrAdaptationH(20) andTopBottomSpace:kScrAdaptationH(10) andLeftRightLeftProportion:kScrAdaptationW(5) Space:insets];
        _loanInfoView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:_loanInfoView];
    }
    return _loanInfoView;
}

/// 财务信息
- (HXBBaseView_MoreTopBottomView *)loanFinView {
    if (!_loanFinView) {
        UIEdgeInsets insets = UIEdgeInsetsMake(kScrAdaptationW(15), kScrAdaptationW(15), kScrAdaptationW(15), kScrAdaptationW(15));
        _loanFinView = [[HXBBaseView_MoreTopBottomView alloc]initWithFrame:CGRectZero andTopBottomViewNumber:5 andViewClass:[UILabel class] andViewHeight:kScrAdaptationH(20) andTopBottomSpace:kScrAdaptationH(10) andLeftRightLeftProportion:kScrAdaptationW(5) Space:insets];
        _loanFinView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:_loanFinView];
    }
    return _loanFinView;
}
- (HXBBaseView_MoreTopBottomView *)workInfoView {
    if (!_workInfoView) {
        UIEdgeInsets insets = UIEdgeInsetsMake(kScrAdaptationW(15), kScrAdaptationW(15), kScrAdaptationW(15), kScrAdaptationW(15));
        _workInfoView = [[HXBBaseView_MoreTopBottomView alloc] initWithFrame:CGRectZero andTopBottomViewNumber:5 andViewClass:[UILabel class] andViewHeight:kScrAdaptationH(20) andTopBottomSpace:kScrAdaptationH(10) andLeftRightLeftProportion:kScrAdaptationW(5) Space:insets];
        _workInfoView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:_workInfoView];
    }
    return _workInfoView;
}
@end
@implementation HXBFin_Detail_DetailVC_LoanManager

@end
