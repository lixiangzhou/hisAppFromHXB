//
//  HXBTransactionPasswordConfirmationView.h
//  修改交易密码
//
//  Created by HXB-C on 2017/6/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBTransactionPasswordConfirmationView : UIView


/**
 确认修改密码回调的Block
 */
@property (nonatomic, copy) void(^confirmChangeButtonClickBlock)(NSString *surePassword);

@end
