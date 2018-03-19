//
//  HXBCreditorChangeTopView.h
//  hoomxb
//
//  Created by 肖扬 on 2017/9/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^buyBlock)();
typedef void(^textfieldDidChange)(NSString *text);

@interface HXBCreditorChangeTopView : UIView

/** 待转让金额 */
@property (nonatomic, copy) NSString * creditorMoney;
/** 一键购买金额 */
@property (nonatomic, copy) NSString * totalMoney;
/** 占位符 */
@property (nonatomic, copy) NSString * placeholderStr;
/** 银行限额 */
@property (nonatomic, copy) NSString * cardStr;
/** 预期收益 */
@property (nonatomic, copy) NSString * profitStr;
/** 收益方式 */
@property (nonatomic, copy) NSString * profitType;
/// 退出方式
@property (nonatomic, copy) NSString *quitWay;

/** 键盘类型 */
@property (nonatomic, assign) UIKeyboardType keyboardType;

/** 是否隐藏一键购买的按钮 */
@property (nonatomic, assign) BOOL isHiddenBtn;
/** 取消输入框的编辑状态 */
@property (nonatomic, assign) BOOL disableKeyBorad;
/** 取消一键购买的点击 */
@property (nonatomic, assign) BOOL disableBtn;
/** 隐藏银行卡限额 */
@property (nonatomic, assign) BOOL hiddenMoneyLabel;
/** 隐藏预期收益 */
@property (nonatomic, assign) BOOL hiddenProfitLabel;
/** 是否绑卡 */
@property (nonatomic, assign) BOOL hasBank;
/** buyBlock */
@property (nonatomic, copy) buyBlock block;
/** buyBlock */
@property (nonatomic, copy) textfieldDidChange changeBlock;
/// 提示框
@property (nonatomic, copy) void(^alertTipBlock)();
/// 是否新手计划
@property (nonatomic, assign) BOOL isNewPlan;

/// 设置预期收益和加息收益 2.5版本加入
- (void)setProfitStr:(NSString *)profitStr andSubsidy:(NSString *)subsidy;

@end
