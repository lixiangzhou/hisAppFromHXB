//
//  HXBBaseViewModel.h
//  hoomxb
//
//  Created by caihongji on 2017/12/29.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBRequestHudDelegate.h"
#import "HXBBaseModel.h"

typedef UIView* (^HugViewBlock)();
static NSString *const hfContentText = @"正在跳转至恒丰银行";

@interface HXBBaseViewModel : HXBBaseModel <HXBRequestHudDelegate>

@property (nonatomic, strong) HugViewBlock hugViewBlock;

- (instancetype)initWithBlock:(HugViewBlock)hugViewBlock;

/**
 是否展示恒丰银行HUD

 @param content 展示文案
 */
- (void)showHFBankWithContent:(NSString *)content;

/**
 隐藏恒丰银行HUD
 */
- (void)hiddenHFBank;

@end
