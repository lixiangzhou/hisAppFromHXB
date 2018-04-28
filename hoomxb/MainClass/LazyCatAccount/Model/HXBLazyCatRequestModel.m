//
//  HXBLazyCatRequestModel.m
//  hoomxb
//
//  Created by caihongji on 2018/4/19.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBLazyCatRequestModel.h"
#import "HXBLazyCatRequestResultModel.h"
@implementation HXBLazyCatRequestModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"data" : [HXBLazyCatRequestResultModel class]
             };
}


@end
