//
//  HXBAdvertiseManager.h
//  hoomxb
//
//  Created by lxz on 2018/6/13.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BannerModel;
@interface HXBAdvertiseManager : NSObject

/// 是否需要在 闪屏 或 手势密码 后弹窗
@property (nonatomic, assign) BOOL couldPopAtHomeAfterSlashOrGesturePwd;

/// 闪屏数据接口是否请求成功
@property (nonatomic, assign, readonly) BOOL requestSuccess;
/// 闪屏页数据
@property (nonatomic, strong, readonly) BannerModel *bannerModel;
/// 闪屏页图片
@property (nonatomic, strong) UIImage *advertieseImage;
/// 数据请求是否完成，可能成功可能失败
@property (nonatomic, assign, readonly) BOOL requestCompleted;

/// 是否显示过
@property (nonatomic, assign) BOOL isShowed;

+ (instancetype)shared;

/// 用于获取是否可以显示闪屏，并内部缓存请求结果
- (void)getSplash;
@end
