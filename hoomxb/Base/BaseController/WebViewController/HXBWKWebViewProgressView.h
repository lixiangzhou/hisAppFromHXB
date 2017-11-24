//
//  HXBWKWebViewProgressView.h
//  hoomxb
//
//  Created by HXB-C on 2017/11/24.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBWKWebViewProgressView : UIView

@property (nonatomic) float progress;


- (void)setProgress:(float)progress animated:(BOOL)animated;

/**
 进度条加载完毕回调
 */
@property (nonatomic, copy)  void (^HXBPageLoadStateSuccessBlock) ();
@end
