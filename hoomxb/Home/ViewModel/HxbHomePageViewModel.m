//
//  HxbHomePageViewModel.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbHomePageViewModel.h"
#import "HxbHomePageModel.h"
@implementation HxbHomePageViewModel
- (void)setHomePageModel:(HxbHomePageModel *)homePageModel{
    _homePageModel = homePageModel;
    _assetsTotal = [NSString stringWithFormat:@"%@",@(homePageModel.assetsTotal)];
    
}

- (void)setHomeBaseModel:(HXBHomeBaseModel *)homeBaseModel
{
    _homeBaseModel = homeBaseModel;
//    for (int i = 0; i<_homeBaseModel.homePlanRecommend.count; i++) {
//        HxbHomePageModel_DataList *planRecommend = _homeBaseModel.homePlanRecommend[i];
//        planRecommend.unifyStatus = [self judgmentStateValue:planRecommend.unifyStatus];
//        _homeBaseModel.homePlanRecommend[i] = planRecommend;
//    }
//    for (HxbHomePageModel_DataList *planRecommend in _homeBaseModel.homePlanRecommend) {
//        [self judgmentStateValue:planRecommend.unifyStatus];
////        planRecommend.unifyStatus
//    }
}

@end
