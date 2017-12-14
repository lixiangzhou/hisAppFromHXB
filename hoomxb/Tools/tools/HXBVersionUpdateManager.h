//
//  HXBVersionUpdateManager.h
//  hoomxb
//
//  Created by HXB-C on 2017/12/13.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBVersionUpdateManager : NSObject

//单例
+ (instancetype)sharedInstance;


/**
 是否展示过升级弹框
 */
@property (nonatomic, assign, readonly) BOOL isShow;


//在首页需要进行显示
- (void)show;

@end
