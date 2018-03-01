//
//  HXBFin_Detail_DetailVC_Loan.m
//  hoomxb
//
//  Created by HXB on 2017/5/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_Detail_DetailVC_Loan.h"
#import "HXBLoanInformation.h"
#import "HXBLoanInstructionView.h"
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
@property (nonatomic,assign) NSInteger loanInfoViewBottomViewCount;
@property (nonatomic,strong) NSMutableArray *tempLeftStrArray;
@property (nonatomic,strong) NSMutableArray *tempRightStrArray;
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
    self.isColourGradientNavigationBar = YES;
    
//    self.loanInfo = [[HXBFin_LoanInfoView alloc] init];
//    [self.view addSubview: self.loanInfo];
//    
//    [self.loanInfo mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
//    self.loanInfo.loan_finDatailModel = self.loanDetailViewModel;
    
    [self setData];
    [self setUPFrame];
    [self setUPValue];
    [self setUPManager];
}
- (void)setData {
    
    self.tempLeftStrArray = [NSMutableArray arrayWithObjects:@"基础信息",
                                        @"姓名：",
                                        @"年龄：",
                                        @"婚姻：",
                                        @"身份证号：",
                                        @"学历：",
                                        @"籍贯：",
                                        @"近6个月内征信报告中逾期情况：",
                                        @"近1个月在其他网贷平台借款：",
                                        @"借款人经营及财务状况：",
                                        @"借款人还款能力变化：",
                                        @"借款人涉诉、受行政处罚情况：",
                                        @"担保方式：",
                                        nil];
    self.tempRightStrArray = [NSMutableArray arrayWithObjects:@" ",
                                         self.fin_Detail_DetailVC_LoanManager.name,
                                         self.fin_Detail_DetailVC_LoanManager.age,
                                         self.fin_Detail_DetailVC_LoanManager.marriageStatus,
                                         self.fin_Detail_DetailVC_LoanManager.idNo,
                                         self.fin_Detail_DetailVC_LoanManager.graduation,
                                         self.fin_Detail_DetailVC_LoanManager.homeTown,
                                         self.fin_Detail_DetailVC_LoanManager.overDueStatus&&![self.fin_Detail_DetailVC_LoanManager.overDueStatus isEqualToString:@""]?self.fin_Detail_DetailVC_LoanManager.overDueStatus:@"",
                                         self.fin_Detail_DetailVC_LoanManager.otherPlatStatus&&![self.fin_Detail_DetailVC_LoanManager.otherPlatStatus isEqualToString:@""]?self.fin_Detail_DetailVC_LoanManager.otherPlatStatus:@"",
                                         
                                         self.fin_Detail_DetailVC_LoanManager.userFinanceStatus&&![self.fin_Detail_DetailVC_LoanManager.userFinanceStatus isEqualToString:@""]?self.fin_Detail_DetailVC_LoanManager.userFinanceStatus:@"",
                                         self.fin_Detail_DetailVC_LoanManager.repaymentCapacity&&![self.fin_Detail_DetailVC_LoanManager.repaymentCapacity isEqualToString:@""]?self.fin_Detail_DetailVC_LoanManager.repaymentCapacity:@"",
                                         self.fin_Detail_DetailVC_LoanManager.punishedStatus&&![self.fin_Detail_DetailVC_LoanManager.punishedStatus isEqualToString:@""]?self.fin_Detail_DetailVC_LoanManager.punishedStatus:@"",
                                         self.fin_Detail_DetailVC_LoanManager.protectSolution&&![self.fin_Detail_DetailVC_LoanManager.protectSolution isEqualToString:@""]?self.fin_Detail_DetailVC_LoanManager.protectSolution:@"",
                                         nil];
    NSMutableArray *leftDiscardedItems = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<self.tempRightStrArray.count; i++) {
        if ([self.tempRightStrArray[i] isEqualToString:@""]) {
            [leftDiscardedItems addObject:self.tempLeftStrArray[i]];
        }
    }
    
    NSArray *arr = @[@""];
    [self.tempLeftStrArray removeObjectsInArray:leftDiscardedItems];
    [self.tempRightStrArray removeObjectsInArray:arr];
    
    self.loanInfoViewBottomViewCount = self.tempLeftStrArray.count;
}

- (void)setUPManager {
    if (!self.fin_Detail_DetailVC_LoanManager) {
        NSLog(@"%@数据为空",self);
        return;
    }
    /////借款说明
    self.loanInstuctionView.loanInstruction = self.fin_Detail_DetailVC_LoanManager.loanInstruction;
    
    ///借款人信息(预留接口)
    //    self.loanPerson_infoView
    kWeakSelf
    [self.loanInfoView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        NSLog(@"viewmanager = %@", viewManager);
        viewManager.leftStrArray = weakSelf.tempLeftStrArray;
        viewManager.rightStrArray = weakSelf.tempRightStrArray;
        
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
                                     @"月收入："
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

/// 返回借款人审核状态行数
- (int)getLoanPersonInfoLineNumber{
    if (!self.fin_Detail_DetailVC_LoanManager.creditInfoItems||[self.fin_Detail_DetailVC_LoanManager.creditInfoItems isEqualToString:@""]) {
        return 0;
    } else {
        NSArray *loanPerson_infoArr = [self.fin_Detail_DetailVC_LoanManager.creditInfoItems componentsSeparatedByString:@","];
        if (loanPerson_infoArr.count <= 0) {
            return 0;
        } else {
            return (int)((loanPerson_infoArr.count-1)/3+1);
        }
    }
}

- (void)setUPFrame {
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    kWeakSelf
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view);
        make.left.right.bottom.equalTo(weakSelf.view);
    }];
    
    [self.loanInstuctionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.scrollView).offset(kScrAdaptationH(10));
        make.left.right.equalTo(weakSelf.view);
    }];
    
    [self.loanPerson_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        float height = [weakSelf getLoanPersonInfoLineNumber]==0?kScrAdaptationH(31):kScrAdaptationH(70+[weakSelf getLoanPersonInfoLineNumber]*73);
        make.height.mas_equalTo(height);//140 //210
        make.right.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.loanInstuctionView.mas_bottom).offset(kScrAdaptationH(10));
    }];
    
    [self.loanInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.loanPerson_infoView.mas_bottom).offset(0);
        make.left.right.equalTo(weakSelf.view);
        make.height.equalTo(@(kScrAdaptationH(30.5*weakSelf.loanInfoViewBottomViewCount)));
    }];
    UIView* redFlagInfoView = [[UIView alloc]init];
    redFlagInfoView.backgroundColor = RGB(245, 81, 81);
    [self.loanInfoView addSubview:redFlagInfoView];
    [redFlagInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.loanInfoView).offset(kScrAdaptationH(19));
        make.height.mas_equalTo(kScrAdaptationW(12));
        make.width.mas_equalTo(kScrAdaptationW(2));
        make.left.equalTo(weakSelf.loanInfoView).offset(7);
    }];
    
    [self.loanFinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.loanInfoView.mas_bottom).offset(0);
        make.left.right.equalTo(weakSelf.view);
        make.height.equalTo(@(kScrAdaptationH(155)));
    }];
    UIView* redFlagloanView = [[UIView alloc]init];
    redFlagloanView.backgroundColor = RGB(245, 81, 81);
    [self.loanFinView addSubview:redFlagloanView];
    [redFlagloanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.loanFinView).offset(kScrAdaptationH(19));
        make.height.mas_equalTo(kScrAdaptationW(12));
        make.width.mas_equalTo(kScrAdaptationW(2));
        make.left.equalTo(weakSelf.loanFinView).offset(7);
    }];
    
    [self.workInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.loanFinView.mas_bottom).offset(0);
        make.left.right.equalTo(weakSelf.view);
        make.height.equalTo(@(kScrAdaptationH(175)));
    }];
    UIView* redFlagworkView = [[UIView alloc]init];
    redFlagworkView.backgroundColor = RGB(245, 81, 81);
    [self.workInfoView addSubview:redFlagworkView];
    [redFlagworkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.workInfoView).offset(kScrAdaptationH(19));
        make.height.mas_equalTo(kScrAdaptationW(12));
        make.width.mas_equalTo(kScrAdaptationW(2));
        make.left.equalTo(weakSelf.workInfoView).offset(7);
    }];
    
//    [self lienViewWithView:self.loanPerson_infoView];
//    [self lienViewWithView:self.loanInfoView];
//    [self lienViewWithView:self.loanFinView];
}

- (UIView *)lienViewWithView:(UIView *)view {
    kWeakSelf
    UIView *lienView = [[UIView alloc]init];
    [self.scrollView addSubview:lienView];
    [lienView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).offset(0);
        make.left.equalTo(weakSelf.view).offset(kScrAdaptationW(15));
        make.right.equalTo(weakSelf.view).offset(kScrAdaptationW(-15));
        make.height.equalTo(@(1));
    }];
    lienView.backgroundColor = kHXBColor_Grey093;
    return lienView;
}


#pragma mark - getterSetter;
///借款说明
- (HXBLoanInstructionView *)loanInstuctionView {
    if (!_loanInstuctionView) {
         _loanInstuctionView = [[HXBLoanInstructionView alloc]initWithFrame:CGRectZero withRiskLevel:self.fin_Detail_DetailVC_LoanManager.riskLevel andRiskLevelDesc:self.fin_Detail_DetailVC_LoanManager.riskLevelDesc];
        [self.scrollView addSubview:_loanInstuctionView];
    }
    return _loanInstuctionView;
}

///借款人信息
- (HXBFin_LoanPerson_Info *)loanPerson_infoView {
    if (!_loanPerson_infoView) {
        NSArray *arr = self.fin_Detail_DetailVC_LoanManager.creditInfoItems&&![self.fin_Detail_DetailVC_LoanManager.creditInfoItems isEqualToString:@""] ?[self.fin_Detail_DetailVC_LoanManager.creditInfoItems componentsSeparatedByString:@","]:nil;
        _loanPerson_infoView = [[HXBFin_LoanPerson_Info alloc]initWithFrame:CGRectZero withLoanPersonInfoArray:arr];
        [self.scrollView addSubview:_loanPerson_infoView];
    }
    return _loanPerson_infoView;
}

///基础信息
- (HXBBaseView_MoreTopBottomView *)loanInfoView {
    if (!_loanInfoView) {
        UIEdgeInsets insets = UIEdgeInsetsMake(kScrAdaptationW(15), kScrAdaptationW(15), kScrAdaptationW(0), kScrAdaptationW(15));
        _loanInfoView = [[HXBBaseView_MoreTopBottomView alloc]initWithFrame:CGRectZero andTopBottomViewNumber:self.loanInfoViewBottomViewCount andViewClass:[UILabel class] andViewHeight:kScrAdaptationH(20) andTopBottomSpace:kScrAdaptationH(10) andLeftRightLeftProportion:kScrAdaptationW(5) Space:insets andCashType:nil];
        _loanInfoView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:_loanInfoView];
    }
    return _loanInfoView;
}

/// 财务信息
- (HXBBaseView_MoreTopBottomView *)loanFinView {
    if (!_loanFinView) {
        UIEdgeInsets insets = UIEdgeInsetsMake(kScrAdaptationW(15), kScrAdaptationW(15), kScrAdaptationW(0), kScrAdaptationW(15));
        _loanFinView = [[HXBBaseView_MoreTopBottomView alloc]initWithFrame:CGRectZero andTopBottomViewNumber:5 andViewClass:[UILabel class] andViewHeight:kScrAdaptationH(20) andTopBottomSpace:kScrAdaptationH(10) andLeftRightLeftProportion:kScrAdaptationW(5) Space:insets andCashType:nil];
        _loanFinView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:_loanFinView];
    }
    return _loanFinView;
}
- (HXBBaseView_MoreTopBottomView *)workInfoView {
    if (!_workInfoView) {
        UIEdgeInsets insets = UIEdgeInsetsMake(kScrAdaptationW(15), kScrAdaptationW(15), kScrAdaptationW(15), kScrAdaptationW(15));
        _workInfoView = [[HXBBaseView_MoreTopBottomView alloc] initWithFrame:CGRectZero andTopBottomViewNumber:5 andViewClass:[UILabel class] andViewHeight:kScrAdaptationH(20) andTopBottomSpace:kScrAdaptationH(10) andLeftRightLeftProportion:kScrAdaptationW(5) Space:insets andCashType:nil];
        _workInfoView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:_workInfoView];
    }
    return _workInfoView;
}
@end
@implementation HXBFin_Detail_DetailVC_LoanManager

@end
