//
//  HXBRechargeView.h
//  hoomxb
//
//  Created by HXB on 2017/6/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBRechargeView_Model;
@interface HXBRechargeView : UIView
- (void) setUPValueWithModel: (HXBRechargeView_Model *(^)(HXBRechargeView_Model *model))setUPValueBlock;

@property (nonatomic,assign) BOOL isEndEditing;

@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UIButton *button;
///placeholder
@property (nonatomic,copy)NSString *placeholder;
///点击了一键购买
- (void)clickBuyButtonFunc:(void(^)())clickBuyButtonBlock;
///点击了充值
- (void)clickRechargeFunc: (void(^)())clickRechageButtonBlock;
@end


@interface HXBRechargeView_Model : NSObject

///余额 title
@property (nonatomic,copy) NSString *balanceLabel_constStr;
///余额展示
@property (nonatomic,copy) NSString *balanceLabelStr;
///充值的button
@property (nonatomic,copy) NSString *rechargeButtonStr;
@end
