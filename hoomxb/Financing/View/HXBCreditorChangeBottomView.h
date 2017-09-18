//
//  HXBCreditorChangeBottomView.h
//  hoomxb
//
//  Created by 肖扬 on 2017/9/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^addBtnClickFunc)(NSString *investMoney);

@interface HXBCreditorChangeBottomView : UIView

/** 点击按钮的方法 */
@property (nonatomic, copy) addBtnClickFunc addBlock;

@end
