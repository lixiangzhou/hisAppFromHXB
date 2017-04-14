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
#pragma mark - 关于key

#pragma mark - 属性的添加
//setter
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (void)setX:(CGFloat)x
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.x = x;
    self.frame = tempFrame;
}
- (void)setY:(CGFloat)y
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.y  = y;
    self.frame = tempFrame;
}
- (void)setWidth:(CGFloat)width
{
    CGRect tempFrame = self.frame;
    tempFrame.size.width = width;
    self.frame = tempFrame;
}
- (void)setHeight:(CGFloat)height
{
    CGRect tempFrame = self.frame;
    tempFrame.size.height = height;
    self.frame = tempFrame;
}
- (void)setOrgin:(CGPoint)orgin
{
    CGRect frame = self.frame;
    frame.origin = orgin;
    self.frame = frame;
}
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

//gtter
- (CGFloat)centerX
{
    return self.center.x;
}
- (CGFloat)centerY
{
    return self.center.y;
}
- (CGFloat)x
{
    return self.frame.origin.x;
}
- (CGFloat)y
{
    return self.frame.origin.y;
}
- (CGFloat)width
{
    return self.frame.size.width;
}
- (CGFloat)height
{
    return self.frame.size.height;
}
- (CGPoint)orgin
{
    return self.frame.origin;
}
- (CGSize)size
{
    return self.frame.size;
}
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
