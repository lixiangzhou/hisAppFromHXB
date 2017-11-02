//
//  HXBCreditorChangeBottomView.h
//  hoomxb
//
//  Created by 肖扬 on 2017/9/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^addBtnClickFunc)(NSString *investMoney);
typedef void(^clickDelegateBlock)(int index);

@interface HXBCreditorChangeBottomView : UIView

/** 点击按钮的文案 */
@property (nonatomic, copy) NSString *clickBtnStr;
/** 协议文案 */
@property (nonatomic, copy) NSString *delegateLabel;
/** 点击按钮的方法 */
@property (nonatomic, copy) addBtnClickFunc addBlock;
/** 点击协议的方法 */
@property (nonatomic, copy) clickDelegateBlock delegateBlock;
/** 是否可以点击按钮 */
@property (nonatomic, assign) BOOL btnIsClick;

@end
