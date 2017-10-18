//
//  HxbAdvertiseView.h
//  hoomxb
//
//  Created by HXB-C on 2017/4/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const adUrl = @"adUrl";
@interface HxbAdvertiseView : UIView
/** 图片路径*/
@property (nonatomic, copy) NSString *filePath;
/** 展示的广告图片*/
@property (nonatomic, strong) UIImage *advertiseImage;

/** 显示广告页面方法*/
- (void)show;
/** 点击了广告页面 显示广告*/
- (void)showAdvertiseWebViewWithBlock: (void(^)())clickAdvertiseViewBlock;

/** 点击了跳过按钮*/
- (void)clickSkipButtonFuncWithBlock: (void(^)())clickSkipButtonBlock;
@end
