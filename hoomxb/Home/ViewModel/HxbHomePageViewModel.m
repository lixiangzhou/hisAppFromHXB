//
//  HxbHomePageViewModel.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbHomePageViewModel.h"
#import "HXBHomeBaseModel.h"
#import "HXBHomeNewbieProductModel.h"
#import "HxbHomePageModel_DataList.h"
@implementation HxbHomePageViewModel

- (void)setHomeBaseModel:(HXBHomeBaseModel *)homeBaseModel
{
    _homeBaseModel = homeBaseModel;
    self.homeDataList = [NSMutableArray array];
    if (homeBaseModel.newbieProductData.dataList.count > 0) {
        [self.homeDataList addObjectsFromArray:homeBaseModel.newbieProductData.dataList];
        homeBaseModel.newbieProductData.dataList.lastObject.isShowNewBieBackgroundImageView = YES;
    }
    [self.homeDataList addObjectsFromArray:homeBaseModel.homePlanRecommend];
}

@end
