//
//  HXBHomeNewbieProductModel.m
//  hoomxb
//
//  Created by HXB-C on 2018/1/19.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBHomeNewbieProductModel.h"
#import "HxbHomePageModel_DataList.h"
@implementation HXBHomeNewbieProductModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"dataList" : [HxbHomePageModel_DataList class]
             };
}

@end
