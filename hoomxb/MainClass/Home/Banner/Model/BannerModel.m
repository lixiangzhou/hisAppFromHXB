//
//  BannerModel.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/2.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "BannerModel.h"

@implementation BannerModel

+ modelContainerPropertyGenericClass {
    return @{
             @"share":[HXBUMShareModel class]
             };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}



@end
