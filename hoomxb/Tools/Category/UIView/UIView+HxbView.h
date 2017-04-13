//
//  UIView+HxbView.h
//  hoomxb
//
//  Created by HXB on 2017/4/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HxbView)
///view的size
@property (nonatomic, assign) CGSize size;
///View的origin
@property(nonatomic,assign) CGPoint orgin;
///view的高
@property (nonatomic, assign) CGFloat height;
///view的宽
@property (nonatomic, assign) CGFloat width;
///view的x
@property (nonatomic, assign) CGFloat x;
///view的y
@property (nonatomic, assign) CGFloat y;
///view的中心X坐标
@property (nonatomic, assign) CGFloat centerX;
///view的中心Y坐标
@property (nonatomic, assign) CGFloat centerY;







    /// 返回屏幕截图
- (UIImage *)hxb_snapshotImage;
@end
