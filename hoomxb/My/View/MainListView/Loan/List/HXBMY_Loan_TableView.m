//
//  HXBMY_Loan_TableView.m
//  hoomxb
//
//  Created by HXB on 2017/8/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_Loan_TableView.h"
#import "HXBMYViewModel_MainLoanViewModel.h"// 我的界面的 loan list ViewModel
#import "HXBBaseViewCell_MYListCellTableViewCell.h"
static NSString *const CELLID = @"CELLID";
@interface HXBMY_Loan_TableView ()
<
UITableViewDelegate,
UITableViewDataSource
>
///cell的点击事件的传递
@property (nonatomic,copy) void(^clickLoanCellBlock)(HXBMYViewModel_MainLoanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex);
@end
@implementation HXBMY_Loan_TableView


#pragma mark - setter
- (void)setMainLoanViewModelArray:(NSArray<HXBMYViewModel_MainLoanViewModel *> *)mainLoanViewModelArray {
    _mainLoanViewModelArray = mainLoanViewModelArray;
    [self reloadData];
}

- (instancetype) initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.delegate = self;
    self.dataSource = self;
    [self registerClass:[HXBBaseViewCell_MYListCellTableViewCell class] forCellReuseIdentifier:CELLID];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rowHeight = kScrAdaptationH(140);
    self.backgroundColor = kHXBColor_BackGround;
}

static NSString *const holdTitle = @"持有中";
static NSString *const exitTingTitle = @"退出中";
static NSString *const exitTitle = @"已退出";
#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.mainLoanViewModelArray.count;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
    //return self.mainPlanViewModelArray? 3 : 11;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXBBaseViewCell_MYListCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    kWeakSelf;
    HXBMYViewModel_MainLoanViewModel *viewModel = weakSelf.mainLoanViewModelArray[indexPath.section];
    NSArray *titleArray = @[
                            @"",
                            @"",
                            @""
                            ];
    NSString *exiTingImageViewName;
    NSString *lanTruansferImageName;
    NSString *lastValue = viewModel.interest;///下一还款日 || 年化收益
    NSString *title_rightSTR;
    switch (viewModel.requestType) {
        case HXBRequestType_MY_PlanRequestType_HOLD_PLAN:
            titleArray = @[
                           @"投资金额(元)",
                           @"待收收益(元)",
                           @"下一还款日"
                           ];
            lastValue = viewModel.nextRepayDate;
            title_rightSTR = viewModel.title_RemainTime;
            break;
        case HXBRequestType_MY_PlanRequestType_EXITING_PLAN:
            titleArray = @[
                           @"加入金额(元)",
                           @"已获收益(元)",
                           @"平均历史年化收益"
                           ];
            exiTingImageViewName = @"explain.svg";
            title_rightSTR = viewModel.title_TermsInTotal_YUE;
            break;
        case HXBRequestType_MY_PlanRequestType_EXIT_PLAN:
            titleArray = @[
                           @"加入金额(元)",
                           @"已获收益(元)",
                           @"平均历史年化收益"
                           ];
            lanTruansferImageName = @"LoanTruansfer.svg";
            title_rightSTR = viewModel.title_Truansfer;
            break;
        default:
            break;
    }
    [cell setUPValueWithListCellManager:^HXBBaseViewCell_MYListCellTableViewCellManager *(HXBBaseViewCell_MYListCellTableViewCellManager *manager) {
        manager.title_LeftLabelStr = viewModel.loanModel.loanTitle;
        manager.title_RightLabelStr = title_rightSTR;
        manager.bottomViewManager.leftStrArray = titleArray;
        manager.bottomViewManager.rightStrArray = @[
                                                    viewModel.amount_NOTYUAN,
                                                    viewModel.earnAmount_NOTYUAN,
                                                    lastValue
                                                    ];
        manager.wenHaoImageName = exiTingImageViewName;
        manager.title_ImageName = lanTruansferImageName;
        return manager;
    }];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.clickLoanCellBlock(self.mainLoanViewModelArray[indexPath.section], indexPath);
}

- (void)clickLoanCellFuncWithBlock: (void(^)(HXBMYViewModel_MainLoanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex))clickLoanCellBlock{
    self.clickLoanCellBlock = clickLoanCellBlock;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kScrAdaptationH(10);
}
@end
