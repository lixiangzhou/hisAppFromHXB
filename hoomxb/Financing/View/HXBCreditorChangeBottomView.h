//
//  HXBCreditorChangeBottomView.h
//  hoomxb
//
//  Created by 肖扬 on 2017/9/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddBtnClickFunc)(NSString *investMoney);  // 点击立即购买按钮的方法
typedef void(^ClickDelegateBlock)(NSInteger index);     // 点击协议的方法
typedef void(^ClickRiskDelegateBlock)(BOOL selectStatus);     // 点击风险提示的协议方法

@interface HXBCreditorChangeBottomView : UIView

/** 点击按钮的文案 */
@property (nonatomic, copy) NSString *clickBtnStr;
/** 协议文案 */
@property (nonatomic, copy) NSString *delegateLabelText;
/** 点击按钮的方法 */
@property (nonatomic, copy) AddBtnClickFunc addBlock;
/** 点击协议的方法 */
@property (nonatomic, copy) ClickDelegateBlock delegateBlock;
/** 点击风险提示的方法 */
@property (nonatomic, copy) ClickRiskDelegateBlock riskBlock;

/** 按钮是否可以点击 */
@property (nonatomic, assign) BOOL addBtnIsUseable;
/** 是否展示风险项 */
@property (nonatomic, assign) BOOL isShowRiskView;

@end
