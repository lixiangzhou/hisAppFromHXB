//
//  HXBFin_JoinimmediateView_Loan.h
//  hoomxb
//
//  Created by HXB on 2017/6/20.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXBJoinImmediateView_Model;
@class HXBFin_JoinimmediateView_Loan_ViewModel;
@interface HXBFin_JoinimmediateView_Loan : UIView

@property (nonatomic,assign) BOOL isEndEditing;
///设置值
- (void)setUPValueWithModelBlock:(HXBFin_JoinimmediateView_Loan_ViewModel *(^)(HXBFin_JoinimmediateView_Loan_ViewModel *model))setUPValueBlock;
@property (nonatomic,assign) BOOL isPlan;

@property (nonatomic,weak) UITextField *rechargeViewTextField;

///点击了一键购买
- (void)clickBuyButtonFunc:(void(^)(NSString *capitall,UITextField *textField))clickBuyButtonBlock;
///点击了充值
- (void)clickRechargeFunc: (void(^)())clickRechageButtonBlock;
//点击了 服务协议
- (void)clickNegotiateButtonFunc: (void(^)())clickNegotiateButtonBlock;
/**
 ///点击了加入
 @param clickAddButtonBlock 加入金额block
 */
- (void)clickAddButtonFunc: (void(^)(NSString *capital))clickAddButtonBlock;
@end


@interface HXBFin_JoinimmediateView_Loan_ViewModel : NSObject
///账户余额
@property (nonatomic,strong) NSString *amount;
@property (nonatomic,strong) HXBJoinImmediateView_Model *JoinImmediateView_Model;
///预计收益
@property (nonatomic,copy) NSString *profitLabelStr;
///预计收益
@property (nonatomic,copy) NSString *profitLabel_constStr;
///散标投资标的剩余可投金额
@property (nonatomic,copy) NSString *loanAcountLable_ConstStr;
///散标投资标的剩余可投金额
@property (nonatomic,copy) NSString *loanAcountLabelStr;
/**
 addButton是否可以点击
 */
@property (nonatomic,assign) BOOL addButtonEndEditing;
@end
