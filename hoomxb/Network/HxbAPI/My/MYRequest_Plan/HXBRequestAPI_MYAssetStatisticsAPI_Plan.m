//
//  HXBRequestAPI_MYAssetStatisticsAPI.m
//  hoomxb
//
//  Created by HXB on 2017/5/22.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRequestAPI_MYAssetStatisticsAPI_Plan.h"

@implementation HXBRequestAPI_MYAssetStatisticsAPI_Plan
- (NSString *)requestUrl {
    return @"/account/userplanAssets.action";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodPost;
}
@end
