//
//  HXB_XYTools.h
//  hoomxb
//
//  Created by HXB on 2017/8/24.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXB_XYTools : NSObject

+ (HXB_XYTools *)shareHandle;

- (UIImage*)convertViewToImage:(UIView*)view;

- (void)createViewShadDow:(UIView*)view;

- (CGFloat)WidthWithString:(NSString *)string labelFont:(UIFont *)labelFont addWidth:(CGFloat)width;


@end
