//
//  ViewController.h
//  MY_Additions
//
//  Created by 李鹏跃 on 16/12/26.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "UIView+Addition.h"

@implementation UIView (CZAddition)

- (UIImage *)addition_snapshotImage {

    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return result;
}

@end
