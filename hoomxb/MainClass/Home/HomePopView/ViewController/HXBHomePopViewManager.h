//
//  HXBHomePopViewManager.h
//  hoomxb
//
//  Created by hxb on 2017/12/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXBHomePopVWModel;

@interface HXBHomePopViewManager : NSObject

/**
 是否要隐藏首页弹窗
 */
@property (nonatomic,assign) BOOL isHide;

+ (instancetype)sharedInstance;

/**
 校验是否可以弹出首页弹窗
 */
+ (BOOL)checkHomePopViewWith:(HXBHomePopVWModel *)homePopViewModel;

/**
 弹出首页弹窗
 */
- (void)popHomeViewfromController:(UIViewController *)controller;
/**
 获取首页弹窗数据
 */
- (void)getHomePopViewData;

@end
