//
//  HXBHomePopView.h
//  hoomxb
//  首页弹窗
//  Created by hxb on 2017/12/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBHomePopView : UIView

/** 显示时点击背景是否移除弹框，默认为NO。 */
@property (nonatomic) BOOL isClickBGDismiss;
/** 显示时背景的透明度，取值(0.0~1.0)，默认为0.5 */
@property (nonatomic) CGFloat popBGAlpha;

/** 图片视图 */
@property (nonatomic, strong) UIImageView *imgView;

/**
 单例
 */
+ (nullable instancetype)sharedManager;

/** 显示完成回调 */
@property (nullable, nonatomic, copy) void(^popCompleteBlock)(void);
/** 移除完成回调 */
@property (nullable, nonatomic, copy) void(^dismissCompleteBlock)(void);
/** 关闭回调 */
@property (nullable, nonatomic, copy) void(^closeActionBlock)(void);
/** 点击image回调 */
@property (nullable, nonatomic, copy) void(^clickImageBlock)(void);
/** 点击背景消失回调 */
@property (nullable, nonatomic, copy) void(^clickBgmDismissCompleteBlock)(void);

/**
 显示弹框
 */
- (void)pop;

/**
 移除弹框
 */
- (void)dismiss;
@end
