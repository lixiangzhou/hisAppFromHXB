//
//  HXBThemAdapterManager.m
//  hoomxb
//
//  Created by caihongji on 2017/12/14.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBThemAdapterManager.h"

@implementation HXBThemAdapterManager


/**
 获取以屏幕高适配的比例

 @return 比例值
 */
+ (CGFloat)getAdaterScreenHeightScale
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    //以iphone6为基准
    CGFloat scale = screenSize.height/667;
    
    if(812 == screenSize.height) {//iphoneX
        scale = 1;
    }
    
    return scale;
}
@end
