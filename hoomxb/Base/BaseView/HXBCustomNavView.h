//
//  HXBCustomNavView.h
//  hoomxb
//
//  Created by HXB-C on 2017/12/18.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBCustomNavView : UIView

/**
 标题
 */
@property (nonatomic, copy) NSString *title;
/**
 透明度
 */
@property (nonatomic, assign) CGFloat navAlpha;

/**
 背景色
 */
@property (nonatomic, strong) UIColor *navBackgroundColor;

/**
 标题颜色
 */
@property (nonatomic, strong) UIColor *titleColor;
/**
 标题文字大小
 */
@property (nonatomic, strong) UIFont *titleFount;

@end
