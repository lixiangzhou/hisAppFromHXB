//
//  HXBRechargeFailView.h
//  hoomxb
//
//  Created by HXB-C on 2017/7/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBRechargeFailView : UIView

/**
 investmentBtnClick
 */
@property (nonatomic, copy) void(^investmentBtnClickBlock)();

/**
 失败原因
 */
@property (nonatomic, copy) NSString *failureReasonText;

@end
