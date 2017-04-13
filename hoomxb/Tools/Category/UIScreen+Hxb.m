//
//  UIScreen+Hxb.m
//  hoomxb
//
//  Created by HXB on 2017/4/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "UIScreen+Hxb.h"

@implementation UIScreen (Hxb)
+ (CGFloat)hxb_screenW {
    return [UIScreen mainScreen].bounds.size.width;
}
    
+ (CGFloat)hxb_screenH {
    return [UIScreen mainScreen].bounds.size.height;
}
    
+ (CGFloat)hxb_scale {
    return [UIScreen mainScreen].scale;
}
@end
