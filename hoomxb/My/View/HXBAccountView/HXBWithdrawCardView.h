//
//  HXBWithdrawCardView.h
//  hoomxb
//
//  Created by HXB-C on 2017/7/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBWithdrawCardView : UIView

/**
 bankName
 */
@property (nonatomic, copy) NSString *bankName;

/**
 bankCode
 */
@property (nonatomic, copy) NSString *bankCode;

/**
 bankNameBtnClickBlock
 */
@property (nonatomic, copy) void(^bankNameBtnClickBlock)();

/**
 nextButtonClickBlcok
 */
@property (nonatomic, copy) void(^nextButtonClickBlock)(NSDictionary *dic);



@end
