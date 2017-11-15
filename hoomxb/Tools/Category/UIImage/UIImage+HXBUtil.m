//
//  UIImage+HXBUtil.m
//  hoomxb
//
//  Created by HXB-C on 2017/11/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "UIImage+HXBUtil.h"

@implementation UIImage (HXBUtil)

/**
 获取启动页的image
 */
+ (instancetype)getLauchImage {
    NSString *viewOrientation = @"Portrait";//竖屏
    NSString *launchImage = nil;
    NSLog(@"%@",[[NSBundle mainBundle] infoDictionary]);
    NSArray *imageDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in imageDict) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, imageSize) && [viewOrientation isEqualToString:dict[@""]]) {
            launchImage = dict[@""];
        }
    }
    return [UIImage imageNamed:launchImage];
}

@end
