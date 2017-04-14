//
//  UIView+HxbView.m
//  hoomxb
//
//  Created by HXB on 2017/4/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "UIView+HxbView.h"
#import <objc/runtime.h>



@implementation UIView (HxbView)

    ///关于截图的方法
- (UIImage *)hxb_snapshotImage {
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return result;
}
@end


// -------------------- readMe ---------------
/*动态添加属性
 1.  setter方法
 // 第一个参数：给哪个对象添加关联
 // 第二个参数：关联的key，通过这个key获取
 // 第三个参数：关联的value
 // 第四个参数:关联的策略
 objc_setAssociatedObject(self, &HXBVIEWFRAME_MAXY, hxbMaxYNum, OBJC_ASSOCIATION_ASSIGN);
 
 2. getter方法

 */
