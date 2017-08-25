//
//  HXBBaseAlertViewController.h
//  hoomxb
//
//  Created by HXB on 2017/7/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"

@interface HXBBaseAlertViewController : HXBBaseViewController

- (instancetype) initWithMassage:(NSString *)massage
            andLeftButtonMassage:(NSString *)leftButtonMassage
           andRightButtonMassage:(NSString *)rightButtonMassage;




///点击了左边的button
@property (nonatomic,copy) void(^clickLeftButtonBlock)();
///点击了右边的button
@property (nonatomic,copy) void(^clickRightButtonBlock)();


- (void)addButtonWithTitle:(NSString *)title andEvent:(void(^)(UIButton *button))eventBlock;
@end
