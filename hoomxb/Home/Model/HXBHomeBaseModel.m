//
//  HXBHomeBaseModel.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBHomeBaseModel.h"
#import "HXBHomeTitleModel.h"
#import "BannerModel.h"
#import "HxbHomePageModel_DataList.h"
@implementation HXBHomeBaseModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"homeTitle" : [HXBHomeTitleModel class],
             @"bannerList" : [BannerModel class],
             @"homePlanRecommend" : [HxbHomePageModel_DataList class]
             };
}

- (NSArray *)bannerList
{
    NSString *curTime =  [HXBServerAndClientTime getCurrentTime_Millisecond];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (BannerModel *bannermodel in _bannerList) {
        NSLog(@"%@",bannermodel.start);
        NSLog(@"%@",bannermodel.end);
        if (bannermodel.end.length > 0) {
            if (curTime.doubleValue > bannermodel.start.doubleValue && curTime.doubleValue < bannermodel.end.doubleValue) {
                [arr addObject:bannermodel];
            }
        }else
        {
            [arr addObject:bannermodel];
        }
    }
    _bannerList = arr;
    return _bannerList;
}

@end
