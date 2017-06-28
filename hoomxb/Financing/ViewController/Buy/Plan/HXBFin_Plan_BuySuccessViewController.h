//
//  HXBFin_Plan_BuySuccessViewController.h
//  hoomxb
//
//  Created by HXB on 2017/6/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"
@class HXBFin_Plan_BuyViewModel;
///购买成功页
@interface HXBFin_Plan_BuySuccessViewController : HXBBaseViewController
@property (nonatomic,strong) HXBFin_Plan_BuyViewModel *planModel;
@property (nonatomic,copy) NSString *massage;
@property (nonatomic,copy) NSString *successStr;
@property (nonatomic,copy) NSString *buttonStr;

- (void) massage: (NSString *)massage andSuccessStr: (NSString *)successStr andButtonStr: (NSString *)buttonStr;
@end
