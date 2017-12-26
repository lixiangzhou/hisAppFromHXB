//
//  HXBThemAdapterManager.h
//  hoomxb
//
//  Created by caihongji on 2017/12/14.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBThemAdapterManager : NSObject
/**
 获取以屏幕高适配的比例
 
 @return 比例值
 */
+ (CGFloat)getAdaterScreenHeightScale;

/**
 获取状态栏高度

 @return 适配后的高度
 */
+ (CGFloat)getStateBarHeight;

/**
 获取导航栏和状态栏的总高度

 @return 适配后的导航栏和状态栏的总高度
 */
+ (CGFloat)getStateNavgationBarHeight;
@end
