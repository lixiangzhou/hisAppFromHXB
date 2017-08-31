//
//  HXB_XYTools.m
//  hoomxb
//
//  Created by HXB on 2017/8/24.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXB_XYTools.h"

static HXB_XYTools * handle = nil;

@implementation HXB_XYTools

+ (HXB_XYTools *)shareHandle {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [[HXB_XYTools alloc] init];
    });
    return handle;
}

- (UIImage*)convertViewToImage:(UIView*)view {
    CGSize size = view.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


//创建阴影
- (void)createViewShadDow:(UIImageView*)imageView {
    //阴影的颜色
    imageView.layer.shadowColor = [UIColor colorWithWhite:0.7 alpha:10.f].CGColor;
    imageView.layer.shadowOffset = CGSizeMake(-2, -2);
    //阴影透明度
    imageView.layer.shadowOpacity = 0.8f;
    imageView.layer.shadowRadius = 3.0f;
    
}


// 自适应宽度的方法
- (CGFloat)WidthWithString:(NSString *)string labelFont:(UIFont *)labelFont addWidth:(CGFloat)width
{
    NSDictionary *dic = [NSDictionary dictionaryWithObject:labelFont forKey:NSFontAttributeName];
    //2. 计算320宽16字号的label的高度
    CGRect frame = [string boundingRectWithSize:CGSizeMake(1000, 15) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
    return frame.size.width + width;
}

@end
