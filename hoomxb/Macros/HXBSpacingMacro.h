//
//  HXBSpacingMacro.h
//  hoomxb
//
//  Created by HXB-C on 2017/12/29.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#ifndef HXBSpacingMacro_h
#define HXBSpacingMacro_h

//视图中一些通用间距
#define kHXBSpacing_10       kScrAdaptationH750(10)
#define kHXBSpacing_12       kScrAdaptationH750(12)
#define kHXBSpacing_14       kScrAdaptationH750(14)
#define kHXBSpacing_20       kScrAdaptationH750(20)
#define kHXBSpacing_30       kScrAdaptationH750(30)
#define kHXBSpacing_40       kScrAdaptationH750(40)
#define kHXBSpacing_50       kScrAdaptationH750(50)
#define kHXBSpacing_100      kScrAdaptationH750(100)
#define kHXBSpacing_128      kScrAdaptationH750(128)

//分割线高度
#define kHXBDivisionLineHeight 0.5

// iPhone X
#define  HXBIPhoneX (kScreenWidth == 375.f && kScreenHeight == 812.f ? YES : NO)
// 状态栏高度
#define  HXBStatusBarHeight   ([HXBThemAdapterManager getStateBarHeight])
// 导航栏高度
#define  HXBNavigationBarHeight  44.f
// Tabbar高度
#define  HXBTabbarHeight         (HXBIPhoneX ? (49.f+34.f) : 49.f)
// Tabbar 安全区域高度
#define  HXBTabbarSafeBottomMargin         (HXBIPhoneX ? 34.f : 0.f)
// 状态栏和导航栏高度
#define  HXBStatusBarAndNavigationBarHeight  [HXBThemAdapterManager getStateNavgationBarHeight]

/// 屏幕顶部的额外距离，适配iPhone X
#define HXBStatusBarAdditionHeight (HXBIPhoneX ? 24 : 0)
/// 屏幕底部的额外距离，适配iPhone X
#define HXBBottomAdditionHeight (HXBIPhoneX ? 34 : 0)

#define HXBViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})

#endif /* HXBSpacingMacro_h */
