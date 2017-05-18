//
//  HXBMainListView_Loan.h
//  hoomxb
//
//  Created by HXB on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXBRequestType_MYManager.h"
@class HXBMYViewModel_MainLoanViewModel;
@interface HXBMainListView_Loan : UIView
#pragma mark - 数据源
#pragma mark - 数据源
@property (nonatomic,strong) NSArray <HXBMYViewModel_MainLoanViewModel*> *repaying_ViewModelArray;
@property (nonatomic,strong) NSArray <HXBMYViewModel_MainLoanViewModel*> *bid_ViewModelArray;

#pragma mark - 事件的传递
///中间的toolBarView 的 select将要改变的时候
- (void)changeMidSelectOptionFuncWithBlock:(void (^)(UIButton *button, NSString *title, NSInteger index, HXBRequestType_MY_LoanRequestType requestType))changeMidSelectOptionBlock;

//MARK: 刷新的传递
- (void)erpaying_RefreashWithDownBlock:(void (^)())downBlock andUPBlock:(void (^)())UPBlock;
- (void)bid_RefreashWithDownBlock:(void (^)())downBlock andUPBlock:(void (^)())UPBlock;
- (void)endRefresh;
@end
