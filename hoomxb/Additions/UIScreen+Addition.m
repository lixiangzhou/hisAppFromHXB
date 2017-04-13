//
//  ViewController.h
//  MY_Additions
//
//  Created by 李鹏跃 on 16/12/26.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "UIScreen+Addition.h"

@implementation UIScreen (Addition)

+ (CGFloat)addition_screenW {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)addition_screenH {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)addition_scale {
    return [UIScreen mainScreen].scale;
}

@end
