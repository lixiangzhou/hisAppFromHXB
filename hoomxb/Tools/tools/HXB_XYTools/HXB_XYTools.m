//
//  HXB_XYTools.m
//  hoomxb
//
//  Created by HXB on 2017/8/24.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
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
- (CGFloat)WidthWithString:(NSString *)string labelFont:(UIFont *)labelFont addWidth:(CGFloat)width {
    CGRect frame;
    if (string.length && labelFont) {
        NSDictionary *dic = [NSDictionary dictionaryWithObject:labelFont forKey:NSFontAttributeName];
        //2. 计算320宽16字号的label的高度
        frame = [string boundingRectWithSize:CGSizeMake(1000, 15) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
    }
    return frame.size.width + width;
}

// 自适应高度的方法
- (CGFloat)heightWithString:(NSString *)string labelFont:(UIFont *)labelFont Width:(CGFloat)width {
    CGSize titleSize;
    if (string.length && labelFont) {
        titleSize = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:labelFont} context:nil].size;
    }
     return titleSize.height + 15;
}


- (BOOL)limitEditTopupMoneyWithTextField:(UITextField *)textField Range:(NSRange)range replacementString:(NSString *)string {
    NSString *updatedText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (range.location == 0 && [string isEqualToString:@"0"]) return NO;
    if (range.location == 0 && [string isEqualToString:@""]) return YES;
    if (range.location == 11) return NO;
#pragma mark --- 谓词控制小数点限制两位
    NSString *regex = @"^\\-?([1-9]\\d*|0)(\\.\\d{0,2})?$";
    NSPredicate *predicte = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicte evaluateWithObject:updatedText];
    
#pragma mark --- 代码控制小数点限制两位
    
//    NSArray *stringsArray = [updatedText componentsSeparatedByString:@"."];
//    
//    if (stringsArray.count > 0) {
//        NSString *dollarAmount = stringsArray[0];
//        // 小数点前面最多多少位
//        if (dollarAmount.length > 11) return NO;
//    }
//    if (stringsArray.count > 1) {
//        NSString *centAmount = stringsArray[1];
//        // 小数点后限制的位数
//        if (centAmount.length > 2) return NO;
//    }
//    if (stringsArray.count > 2) return NO;
//    // 限制的总个数,  一共7位: 小数点也在计算中  6666.12
//    if (textField.text.length < 14) {
//        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
//        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//        return [string isEqualToString:filtered];
//    } else {
//        if (range.length > 0) {
//            return YES;
//        } else {
//            return NO;
//        }
//    }
//    return YES;
}

- (BOOL)limitTextCharactorWithString:(NSString *)string {
    return YES;
}




@end
