//
//  HXBAdvertiseViewModel.h
//  hoomxb
//
//  Created by lxz on 2018/1/11.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"

@interface HXBAdvertiseViewModel : HXBBaseViewModel
- (void)requestSplashImages:(void (^)(NSString *imageUrl))resultBlock;
/// 获取闪屏图片，从缓存中取，并后台下载新的图片
/// 若有缓存则显示，没有就不显示
- (void)getSplashImage:(void (^)(NSString *imageUrl))resultBlock;
@end
