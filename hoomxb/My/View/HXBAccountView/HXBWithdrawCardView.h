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
 bankNameBtnClickBlock
 */
@property (nonatomic, copy) void(^bankNameBtnClickBlock)(UIButton *bankNameBtn);

/**
 nextButtonClickBlcok
 */
@property (nonatomic, copy) void(^nextButtonClickBlock)(NSString *bankCard);



@end
