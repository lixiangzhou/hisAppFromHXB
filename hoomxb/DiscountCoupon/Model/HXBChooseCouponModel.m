//
//  HXBChooseCouponModel.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2017/10/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBChooseCouponModel.h"

@implementation HXBChooseCouponModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"dataList" : [HXBCouponModel class],
             @"unusableList" : [HXBCouponModel class]
             };
}



@end
