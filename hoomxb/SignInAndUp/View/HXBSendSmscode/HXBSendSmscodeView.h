//
//  HXBSendSmscodeView.h
//  hoomxb
//
//  Created by HXB on 2017/6/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBSendSmscodeView : UIView
@property (nonatomic, copy) NSString *phonNumber;
///点击了确认
- (void)clickSetPassWordButtonFunc: (void(^)(NSString *password))clickSetPassWordButtonBlock;
@end
