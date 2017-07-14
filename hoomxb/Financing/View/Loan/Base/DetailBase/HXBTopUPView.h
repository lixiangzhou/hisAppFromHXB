//
//  HXBTopUPView.h
//  hoomxb
//
//  Created by HXB on 2017/7/14.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBTopUPViewManager;
///充值
@interface HXBTopUPView : UIView
- (void) setUPValueWithModel: (HXBTopUPViewManager *(^)(HXBTopUPViewManager *manager))setUPValueBlock;
@end



@interface HXBTopUPViewManager : NSObject
///余额 title
@property (nonatomic,copy) NSString *balanceLabel_constStr;
///余额展示
@property (nonatomic,copy) NSString *balanceLabelStr;
///充值的button
@property (nonatomic,copy) NSString *rechargeButtonStr;

@end
