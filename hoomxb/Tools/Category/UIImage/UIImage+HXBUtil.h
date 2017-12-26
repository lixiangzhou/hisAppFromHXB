//
//  UIImage+HXBUtil.h
//  hoomxb
//
//  Created by HXB-C on 2017/11/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HXBUtil)

/**
 获取启动页的image
 */
+ (instancetype)getLauchImage;

+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;

@end
