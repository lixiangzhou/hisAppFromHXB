//
//  HXBOpenDepositAccountView.h
//  hoomxb
//
//  Created by HXB-C on 2017/7/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBOpenDepositAccountView : UIView

/**
 bankCode
 */
@property (nonatomic, copy) NSString *bankCode;
/**
 银行名称
 */
@property (nonatomic, copy) NSString *bankName;

/**
 bankNameBlock
 */
@property (nonatomic, copy) void(^bankNameBlock)();

/**
 开通账户
 */
@property (nonatomic, copy)  void(^openAccountBlock)(NSDictionary *dic);
@end
