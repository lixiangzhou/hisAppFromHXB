//
//  HXBHomeBaseModel.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBHomeBaseModel.h"
#import "HXBHomeTitleModel.h"
#import "BannerModel.h"
#import "HxbHomePageModel_DataList.h"
#import "HXBHomeNewbieProductModel.h"
@implementation HXBHomeBaseModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"homeTitle" : [HXBHomeTitleModel class],
             @"bannerList" : [BannerModel class],
             @"homePlanRecommend" : [HxbHomePageModel_DataList class],
             @"newbieProductData" : [HXBHomeNewbieProductModel class]
             };
}

@end
