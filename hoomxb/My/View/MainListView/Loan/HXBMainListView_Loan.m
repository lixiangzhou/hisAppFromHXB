//
//  HXBMainListView_Loan.m
//  hoomxb
//
//  Created by HXB on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMainListView_Loan.h"
#import "HXBMainListView_Loan_TopView.h"
#import "HXBMYViewModel_MainLoanViewModel.h"
#import "HXBBaseTableView_MYPlanList_TableView.h"



@interface HXBMainListView_Loan()

//MARK: --------------------------- topView -------------------
@property (nonatomic,strong) HXBMainListView_Loan_TopView *loanTopView;


//MARK: --------------------------- toolBarView -------------------
@property (nonatomic,strong) HXBBaseToolBarView *toolBarView;
//toolBarView中的title的集合
@property (nonatomic,strong) NSArray <NSString *>*toolBarViewOptionTitleStrArray;
///收益中的label
@property (nonatomic,strong) UILabel *REPAYING_Lable;
///投标中的label
@property (nonatomic,strong) UILabel *BID_Lable;
///loan 的toolbarView的中间的点击
@property (nonatomic,copy) void(^changeMidSelectOptionBlock)(UIButton *button, NSString *title, NSInteger index, HXBRequestType_MY_LoanRequestType requestType);



//MARK: -------------------------- toolBarScrollView ----------------
@property (nonatomic,strong) HXBBaseScrollToolBarView *scrollToolBarView;
///scrollViewToolBarView的 底部的TableView
@property (nonatomic,strong) NSMutableArray <HXBBaseTableView_MYPlanList_TableView*> *tableViewArray;
///收益中
@property (nonatomic,strong) HXBBaseTableView_MYPlanList_TableView *erpaying_Loan_TableView;
///投标中
@property (nonatomic,strong) HXBBaseTableView_MYPlanList_TableView *bid_Loan_TableView;


//MARK: ------------------------- 刷新 ----------------------------
///plan 上拉刷新与下拉加载的block
@property (nonatomic,copy) void(^repaying_Loan_DownRefresh)();
@property (nonatomic,copy) void(^bid_Loan_DownRefresh)();

@property (nonatomic,copy) void(^repaying_Loan_UPRefresh)();
@property (nonatomic,copy) void(^bid_Loan_UPRefresh)();

//MARK: - cell的点击
///cell的点击事件的传递
@property (nonatomic,copy) void(^clickLoan_BIDCellBlock)(HXBMYViewModel_MainLoanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex);
@property (nonatomic,copy) void(^clickLoan_RepayingCellBlock)(HXBMYViewModel_MainLoanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex);
@end

///收益中
static NSString *REPAYING_Title = @"收益中";
///投标中
static NSString *BID_Title = @"投标中";

@implementation HXBMainListView_Loan
//MARK: 销毁
kDealloc
#pragma mark - setter
- (void)setRepaying_ViewModelArray:(NSArray<HXBMYViewModel_MainLoanViewModel *> *)repaying_ViewModelArray {
    _repaying_ViewModelArray = repaying_ViewModelArray;
    self.erpaying_Loan_TableView.mainLoanViewModelArray = repaying_ViewModelArray;
    self.REPAYING_Lable.text = [self  formatStrWithTypeStr:REPAYING_Title andCountStr:repaying_ViewModelArray.count];
}
- (void)setBid_ViewModelArray:(NSArray<HXBMYViewModel_MainLoanViewModel *> *)bid_ViewModelArray {
    _bid_ViewModelArray = bid_ViewModelArray;
    self.bid_Loan_TableView.mainLoanViewModelArray = bid_ViewModelArray;
    self.BID_Lable.text = [self formatStrWithTypeStr:BID_Title andCountStr:bid_ViewModelArray.count];
}

- (NSString *)formatStrWithTypeStr: (NSString *)typeStr andCountStr: (NSInteger)count {
    if (count) {
        NSString *countStr = @(count).description;
        return [NSString stringWithFormat:@"%@(%@)",typeStr,countStr];
    }
    return typeStr;
}


- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUP];
    }
    return self;
}

///设置
- (void)setUP {
    
    [self createProperty];///创建属性
    [self createTopView];///创建顶部的View;
    [self createToolBarView];///创建中间的toolBarView
    [self creatBottomScrollView];///底部的scrollView的搭建
    //这个数组决定了tableView在bottom里面的位置，是左边还是右边
    self.tableViewArray = @[
                            self.erpaying_Loan_TableView,//收益中
                            self.bid_Loan_TableView//投标中
                            ].mutableCopy;
    [self createScrollToolBarView];///搭建scrollToolBarView；
    [self refresh];///刷新
    [self registerClickCellEvent];///注册cell的点击事件
}


///创建属性
- (void)createProperty {
    self.toolBarViewOptionTitleStrArray = @[
                                            REPAYING_Title,
                                            BID_Title
                                            ];
   
    self.REPAYING_Lable = [self creatLableWithTitle:REPAYING_Title];
    self.BID_Lable = [self creatLableWithTitle:BID_Title];
}

///创建顶部的View;
- (void)createTopView {
    self.loanTopView = [[HXBMainListView_Loan_TopView alloc]init];
}
///创建中间的toolBarView
- (void)createToolBarView {
    kWeakSelf
    self.toolBarView = [[HXBBaseToolBarView alloc]initWithFrame:CGRectZero andOptionStrArray:self.toolBarViewOptionTitleStrArray];
    self.toolBarView.itemTextColor_Normal = [UIColor whiteColor];
    self.toolBarView.itemTextColor_Select = [UIColor whiteColor];
    self.toolBarView.itemTextColor_Select = [UIColor whiteColor];
    
    self.toolBarView.isAnima_ItemBottomBarView = true;
    
    // 对item 进行自定义
    [self.toolBarView setUpsetUpBarViewItemBlockFuncWithBlcok:^(UIButton *button, UIView *buttonBottomView) {
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        if ([button.titleLabel.text isEqualToString: REPAYING_Title]) {
            [weakSelf addLableWithButton:button andLable:weakSelf.REPAYING_Lable];
        }
        if ([button.titleLabel.text isEqualToString:BID_Title]) {
            [weakSelf addLableWithButton:button andLable:weakSelf.BID_Lable];
        }
        
    }];
}
- (UILabel *)creatLableWithTitle: (NSString *)title {
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    return label;
}
- (void)addLableWithButton: (UIButton *)button andLable: (UILabel *)label{
    [button addSubview:label];
    label.frame = button.bounds;
    button.titleLabel.text = @"";
}

///底部的scrollView的搭建
//- (NSMutableArray <HXBBaseTableView_MYPlanList_TableView*> *)creatBottomScrollView {
- (void)creatBottomScrollView {
    self.erpaying_Loan_TableView = [[HXBBaseTableView_MYPlanList_TableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.bid_Loan_TableView = [[HXBBaseTableView_MYPlanList_TableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
}
///搭建scrollToolBarView；
- (void)createScrollToolBarView {
    
    self.scrollToolBarView = [[HXBBaseScrollToolBarView alloc]initWithFrame:CGRectMake(0, 64, self.width, self.height - 64) andTopView:self.loanTopView andTopViewH:300 andMidToolBarView:self.toolBarView andMidToolBarViewMargin:0 andMidToolBarViewH:30 andBottomViewSet:self.tableViewArray];
    [self addSubview:self.scrollToolBarView];
}

#pragma mark - 事件的传递
///中间的toolBarView 的 select将要改变的时候
- (void)changeMidSelectOptionFuncWithBlock:(void (^)(UIButton *button, NSString *title, NSInteger index, HXBRequestType_MY_LoanRequestType requestType))changeMidSelectOptionBlock {
    self.changeMidSelectOptionBlock = changeMidSelectOptionBlock;
}

///上啦刷新下拉加载
- (void)refresh {
    [self downLoadRefresh];
    [self upDataRefresh];
}

///下拉刷新
- (void)downLoadRefresh {
    __weak typeof (self)weakSelf = self;
    [self.bid_Loan_TableView hxb_GifHeaderWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
        if (weakSelf.bid_Loan_UPRefresh) weakSelf.bid_Loan_UPRefresh();
    } andSetUpGifHeaderBlock:^(MJRefreshGifHeader *gifHeader) {}];
    
    [self.erpaying_Loan_TableView hxb_GifHeaderWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
        if (weakSelf.repaying_Loan_UPRefresh) weakSelf.repaying_Loan_UPRefresh();
    } andSetUpGifHeaderBlock:^(MJRefreshGifHeader *gifHeader) {}];
}

//上啦加载
- (void) upDataRefresh {
    __weak typeof(self) weakSelf = self;
    [self.bid_Loan_TableView hxb_GifFooterWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
        if (weakSelf.bid_Loan_DownRefresh) weakSelf.bid_Loan_DownRefresh();
    } andSetUpGifFooterBlock:^(MJRefreshBackGifFooter *footer) {}];
    
    [self.erpaying_Loan_TableView hxb_GifFooterWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
        if(weakSelf.repaying_Loan_DownRefresh) weakSelf.repaying_Loan_DownRefresh();
    } andSetUpGifFooterBlock:^(MJRefreshBackGifFooter *footer) {}];
}

//停止刷新
- (void)endRefresh {
    [self.erpaying_Loan_TableView.mj_header endRefreshing];
    [self.erpaying_Loan_TableView.mj_footer endRefreshing];
    [self.bid_Loan_TableView.mj_header endRefreshing];
    [self.bid_Loan_TableView.mj_footer endRefreshing];
}

//MARK: 刷新的传递
- (void)erpaying_RefreashWithDownBlock:(void (^)())downBlock andUPBlock:(void (^)())UPBlock {
    self.repaying_Loan_UPRefresh = UPBlock;
    self.repaying_Loan_DownRefresh = downBlock;
}
- (void)bid_RefreashWithDownBlock:(void (^)())downBlock andUPBlock:(void (^)())UPBlock {
    self.bid_Loan_UPRefresh = UPBlock;
    self.bid_Loan_DownRefresh = downBlock;
}

//MARK: cell的点击
- (void)registerClickCellEvent {
    [self.bid_Loan_TableView clickLoanCellFuncWithBlock:^(HXBMYViewModel_MainLoanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex) {
        if (self.clickLoan_BIDCellBlock) {
            self.clickLoan_BIDCellBlock(loanViewModel, clickLoanCellIndex);
        }
    }];
    [self.erpaying_Loan_TableView clickLoanCellFuncWithBlock:^(HXBMYViewModel_MainLoanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex) {
        if (self.clickLoan_RepayingCellBlock) {
            self.clickLoan_RepayingCellBlock(loanViewModel, clickLoanCellIndex);
        }
    }];
}
- (void)clickLoan_bid_CellFuncWithBlock:(void (^)(HXBMYViewModel_MainLoanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex))clickLoanCellBlock {
    self.clickLoan_BIDCellBlock = clickLoanCellBlock;
}
- (void)clickLoan_repaying_CellFuncWithBlock:(void (^)(HXBMYViewModel_MainLoanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex))clickLoanCellBlock {
    self.clickLoan_RepayingCellBlock = clickLoanCellBlock;
}

@end
