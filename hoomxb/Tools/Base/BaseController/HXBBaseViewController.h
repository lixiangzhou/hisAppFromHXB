//
//  HXBBaseViewController.h
//  hoomxb
//
//  Created by HXB on 2017/4/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBBaseViewController : UIViewController
///是否隐藏导航栏
@property (nonatomic,assign) BOOL isHiddenNavigationBar;
///自动把scrollView向下平移64
@property (nonatomic,assign) BOOL hxb_automaticallyAdjustsScrollViewInsets;
///懒加载 scrollView，作为了垫底的scrollView
@property (nonatomic,strong) UIScrollView *hxbBaseVCScrollView;
///是否可以滑动
@property (nonatomic,assign) BOOL isScroll;
///tracking ScrollView
- (void) trackingScrollViewBlock: (void(^)(UIScrollView *scrollView)) trackingScrollViewBlock;
@end
