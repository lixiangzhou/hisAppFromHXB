//
//  HXBAdvertiseManager.h
//  hoomxb
//
//  Created by lxz on 2018/6/13.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBAdvertiseManager : NSObject

/// 欢迎页之后是否显示
@property (nonatomic, assign, readonly) BOOL canShow;

/// 是否显示过
@property (nonatomic, assign) BOOL isShowed;

+ (instancetype)shared;

/// 用于获取是否可以显示闪屏，并内部缓存请求结果
- (void)getSplashImage;
@end
