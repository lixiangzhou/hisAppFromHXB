//
//  HXBMyTopUpBankView.h
//  hoomxb
//
//  Created by HXB-C on 2017/7/6.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXBBankCardViewModel.h"
@class HXBBankCardModel;
@interface HXBMyTopUpBankView : UIView

@property (nonatomic, strong) HXBBankCardViewModel *bankCardViewModel;
@property (nonatomic, strong) HXBBankCardModel *bankCardModel;

@end
