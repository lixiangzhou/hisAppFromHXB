//
//  HXBBaseViewModel.h
//  hoomxb
//
//  Created by caihongji on 2017/12/29.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBRequestHudDelegate.h"
#import "HXBBaseRequest.h"
#import "HXBBaseModel.h"

typedef UIView* (^HugViewBlock)();

@interface HXBBaseViewModel : HXBBaseModel <HXBRequestHudDelegate>

@property (nonatomic, strong) HugViewBlock hugViewBlock;

- (instancetype)initWithBlock:(HugViewBlock)hugViewBlock;
@end
