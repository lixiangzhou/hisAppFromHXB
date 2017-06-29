//
//  HXBJoinImmediateView.h
//  hoomxb
//
//  Created by HXB on 2017/6/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBJoinImmediateView_Model;
@interface HXBJoinImmediateView : UIView
@property (nonatomic,assign) BOOL isEndEditing;

///设置值
- (void)setUPValueWithModelBlock:(HXBJoinImmediateView_Model *(^)(HXBJoinImmediateView_Model *model))setUPValueBlock;

@property (nonatomic,copy) NSString *userAomunt;
@property (nonatomic,assign) BOOL isPlan;
@property (nonatomic,weak) UITextField *rechargeViewTextField;


///点击了一键购买
- (void)clickBuyButtonFunc:(void(^)(NSString *capitall,UITextField *textField))clickBuyButtonBlock;
///点击了充值
- (void)clickRechargeFunc: (void(^)())clickRechageButtonBlock;
//点击了 服务协议
- (void)clickNegotiateButtonFunc: (void(^)())clickNegotiateButtonBlock;
///点击了加入
- (void)clickAddButtonFunc: (void(^)(NSString *capital))clickAddButtonBlock;

@end


static NSString *const planNegotiateStr = @"《红利计划服务协议》";
static NSString *const loanNegotiateStr = @"《散标合同》";
static NSString *const planAddButtonStr = @"确认加入";
static NSString *const loanAddButtonStr = @"确认投标";
static NSString *const loanStart = @"￥ 100起投，100递增";
static NSString *const planStart = @"￥ 1000起投，1000递增";
static NSString *const loanProfitTypeLabel = @"标的剩余可投金额";

@interface HXBJoinImmediateView_Model : NSObject
/// ￥1000起投，1000递增 placeholder
@property (nonatomic,copy) NSString *rechargeViewTextField_placeholderStr;
///余额 title
@property (nonatomic,copy) NSString *balanceLabel_constStr;
///余额展示
@property (nonatomic,copy) NSString *balanceLabelStr;
///充值的button str
@property (nonatomic,copy) NSString *rechargeButtonStr;
///一键购买的str
@property (nonatomic,copy) NSString *buyButtonStr;
///收益方式
@property (nonatomic,copy) NSString *profitTypeLable_ConstStr;
///收益方法
@property (nonatomic,copy) NSString *profitTypeLabelStr;
///预计收益比例
@property (nonatomic,copy) NSString *totalInterest;
///预计收益
@property (nonatomic,copy) NSString *profitLabelStr;
///预计收益Const
@property (nonatomic,copy) NSString *profitLabel_consttStr;
///服务协议
@property (nonatomic,copy) NSString *negotiateLabelStr;
///服务协议 button str
@property (nonatomic,copy) NSString *negotiateButtonStr;
///加入上线
@property (nonatomic,copy) NSString *upperLimitLabelStr;
///加入上线 const
@property (nonatomic,copy) NSString *upperLimitLabel_constStr;
///确认加入的Buttonstr
@property (nonatomic,copy) NSString *addButtonStr;
/**
 预期收益
 */
- (NSString *) totalInterestWithAmount: (CGFloat)amount;
@end
