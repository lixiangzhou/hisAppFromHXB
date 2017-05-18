//
//  HXBMY_LoanListViewController.m
//  hoomxb
//
//  Created by HXB on 2017/5/16.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_LoanListViewController.h"
#import "HXBMainListView_Loan.h"
#import "HXBMYViewModel_MainLoanViewModel.h"
#import "HXBMYRequest.h"
@interface HXBMY_LoanListViewController ()

@property (nonatomic,strong) HXBMainListView_Loan *loanListView;

@property (nonatomic,strong) NSArray <HXBMYViewModel_MainLoanViewModel *>*loan_BID_ViewModelArray;
@property (nonatomic,strong) NSArray <HXBMYViewModel_MainLoanViewModel *>*loan_REPAYING_ViewModelArray;
@end

@implementation HXBMY_LoanListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUP];
}

//设置
- (void)setUP {
    ///view的创建
    [self setupView];
    ///网络请求
    [self downLoadDataWitRequestType:HXBRequestType_MY_LoanRequestType_REPAYING_LOAN andIsUpData:true];
    ///事件的传递
    [self registerEvent];
    //刷新  加载
    [self registerRefresh];
}

//搭建UI
- (void)setupView {
    self.loanListView = [[HXBMainListView_Loan alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.loanListView];
}
#pragma mark - 下载数据
- (void)downLoadDataWitRequestType: (HXBRequestType_MY_LoanRequestType) requestType andIsUpData: (BOOL)isUpData{
    __weak typeof (self)weakSelf = self;
    [[HXBMYRequest sharedMYRequest] myLoan_requestWithPlanType:requestType andUpData:isUpData andSuccessBlock:^(NSArray<HXBMYViewModel_MainLoanViewModel *> *viewModelArray) {
        //数据的分发
        [weakSelf handleViewModelArrayWithViewModelArray:viewModelArray];
        [weakSelf.loanListView endRefresh];
    } andFailureBlock:^(NSError *error) {
        [weakSelf.loanListView endRefresh];
    }];
}
///网络数据请求数据处理
- (void)handleViewModelArrayWithViewModelArray: (NSArray<HXBMYViewModel_MainLoanViewModel *>*)loanViewModelArray{
    //    如果 没有值就直接return
    if (!loanViewModelArray.count) return;
    switch (loanViewModelArray.firstObject.requestType) {
        case HXBRequestType_MY_LoanRequestType_BID_LOAN://持有中
            self.loanListView.bid_ViewModelArray = loanViewModelArray;
            self.loan_BID_ViewModelArray = loanViewModelArray;
            break;
        case HXBRequestType_MY_LoanRequestType_FINISH_LOAN: //已经推出
            break;
        case HXBRequestType_MY_LoanRequestType_REPAYING_LOAN://正在推出
            self.loanListView.repaying_ViewModelArray = loanViewModelArray;
            self.loan_REPAYING_ViewModelArray = loanViewModelArray;
            break;
    }
}

#pragma mark - 注册事件
- (void) registerEvent {
    // 中部的toolBarView的选中的option变化时候调用
    [self setupMidToolBarViewChangeSelect];
}
//MARK:  中部的toolBarView的选中的option变化时候调用
- (void) setupMidToolBarViewChangeSelect {
    //根据type来对相应的 界面进行网络请求 如果
    __weak typeof (self)weakSelf = self;
    [self.loanListView changeMidSelectOptionFuncWithBlock:^(UIButton *button, NSString *title, NSInteger index, HXBRequestType_MY_LoanRequestType type) {
        switch (type) {
                
            case HXBRequestType_MY_LoanRequestType_REPAYING_LOAN:
                if (!weakSelf.loan_REPAYING_ViewModelArray.count) [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_LoanRequestType_REPAYING_LOAN andIsUpData:true];
                break;
                
                
            case HXBRequestType_MY_LoanRequestType_FINISH_LOAN:
                break;
                
                
            case HXBRequestType_MY_LoanRequestType_BID_LOAN:
                if (!weakSelf.loan_BID_ViewModelArray.count) [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_LoanRequestType_BID_LOAN andIsUpData:true];
                break;
        }
    }];
}

//MARK: - 刷新 加载 注册
- (void) registerRefresh {
    [self refresh_bid];
    [self refresh_repying];
}
- (void) refresh_bid {
    __weak typeof(self)weakSelf = self;
    [self.loanListView bid_RefreashWithDownBlock:^{
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_LoanRequestType_BID_LOAN andIsUpData:false];
    } andUPBlock:^{
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_LoanRequestType_BID_LOAN andIsUpData:true];
    }];
}
- (void) refresh_repying {
    __weak typeof (self)weakSelf = self;
    [self.loanListView erpaying_RefreashWithDownBlock:^{
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_LoanRequestType_REPAYING_LOAN andIsUpData:false];
    } andUPBlock:^{
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_LoanRequestType_REPAYING_LOAN andIsUpData:true];
    }];
}
//MARK: 销毁
kDealloc
@end
