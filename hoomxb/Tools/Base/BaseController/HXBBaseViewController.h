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
///使navBar 透明
@property (nonatomic,assign) BOOL isTransparentNavigationBar;
///导航条是否为红色渐变
@property (nonatomic,assign) BOOL isColourGradientNavigationBar;
///导航条是否为蓝色
@property (nonatomic,assign) BOOL isBlueGradientNavigationBar;
///自动把scrollView向下平移64
@property (nonatomic,assign) BOOL hxb_automaticallyAdjustsScrollViewInsets;
///懒加载 scrollView，作为了垫底的scrollView
@property (nonatomic,strong) UITableView *hxbBaseVCScrollView;
///是否可以滑动
@property (nonatomic,assign) BOOL isScroll;
///tracking ScrollView
- (void) trackingScrollViewBlock: (void(^)(UIScrollView *scrollView)) trackingScrollViewBlock;

///颜色渐变
- (void) addColourGradientWithHeight:(CGFloat)height;
///可以重写返回方法
- (void)leftBackBtnClick;
@end
