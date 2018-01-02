//
//  HXBBaseViewModel.m
//  hoomxb
//
//  Created by caihongji on 2017/12/29.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"

@interface HXBBaseViewModel()

@end

@implementation HXBBaseViewModel

- (instancetype)initWithBlock:(HugViewBlock)hugViewBlock {
    self = [super init];
    
    if(self) {
        self.hugViewBlock = hugViewBlock;
    }
    
    return self;
}

- (UIView*)getHugView {
    UIView* view = nil;
    
    if(self.hugViewBlock) {
        view = self.hugViewBlock();
    }
    
    return view;
}

#pragma mark 弹框显示
- (void)showProgress {
    UIView* parentView = [self getHugView];
}

- (void)showToast:(NSString *)toast {
    UIView* parentView = [self getHugView];
}

- (void)hideProgress {
    UIView* parentView = [self getHugView];
}

#pragma mark 错误码处理
/**
 错误的状态码处理
 
 @param request 请求对象
 @return 是否已经做了处理
 */
- (BOOL)erroStateCodeDeal:(NYBaseRequest *)request {
    return YES;
}

/**
 错误的响应码处理
 
 @param request 请求对象
 @return 是否已经做了处理
 */
- (BOOL)erroResponseCodeDeal:(NYBaseRequest *)request {
    return YES;
}

@end
