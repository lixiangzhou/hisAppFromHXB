//
//  HXBHomePopViewManager.h
//  hoomxb
//
//  Created by hxb on 2017/12/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXBHomePopViewModel;

@interface HXBHomePopViewManager : NSObject

/**
 是否隐藏首页弹窗
 */
@property (nonatomic,assign) BOOL isHide;

+ (instancetype)sharedInstance;

/**
 校验是否可以弹出首页弹窗
 */
+ (BOOL)checkHomePopViewWith:(HXBHomePopViewModel *)homePopViewModel;

/**
 弹出首页弹窗
 */
- (void)popHomeViewfromController:(UIViewController *)controller;
/**
 获取首页弹窗数据
 */
- (void)getHomePopViewData;

@end
