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

@interface HXBBaseViewModel : HXBBaseModel <HXBRequestHudDelegate>

@property (nonatomic, strong) HugViewBlock hugViewBlock;

- (instancetype)initWithBlock:(HugViewBlock)hugViewBlock;


/**
 是否展示恒丰银行HUD

 @param isShow 是否展示
 @param content 展示文案
 */
- (void)showHFBank:(BOOL)isShow content:(NSString*)content;

@end
