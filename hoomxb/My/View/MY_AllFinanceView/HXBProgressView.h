//
//  ProgressView.h
//  XzbTest
//
//  Created by xzb on 2017/5/25.
//  Copyright © 2017年 xzb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBProgressView : UIView

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign,getter=isGradual) BOOL gradual;


/**
 @param gradual 开启渐变,默认关闭;
 */
- (void)setGradual:(BOOL)gradual;
/**
 @param progress 进度 [0,1],默认开启
 */
- (void)setProgress:(CGFloat)progress;

@end
