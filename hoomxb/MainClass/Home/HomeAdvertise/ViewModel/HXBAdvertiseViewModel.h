//
//  HXBAdvertiseViewModel.h
//  hoomxb
//
//  Created by lxz on 2018/1/11.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "BannerModel.h"

@interface HXBAdvertiseViewModel : HXBBaseViewModel
/// 闪屏页数据
@property (nonatomic, strong, readonly) BannerModel *bannerModel;

/// 图片URL
@property (nonatomic, strong) NSURL *imageUrl;

/// 是否可以跳转到活动页
@property (nonatomic, assign) BOOL canToActivity;

- (void)getSlash:(void (^)(BOOL isSuccess))resultBlock;

@end
