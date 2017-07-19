//
//  HXBPresentInformationView.h
//  hoomxb
//
//  Created by HXB-C on 2017/7/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBBankCardModel;
@interface HXBPresentInformationView : UIView

@property (nonatomic, strong) HXBBankCardModel *bankCardModel;

/**
 点击完成的回调
 */
@property (nonatomic, copy) void(^completeBlock)();

@end
