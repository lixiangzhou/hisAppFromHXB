//
//  HXBHomeBaseModel.h
//  hoomxb
//
//  Created by HXB-C on 2017/6/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HXBHomeTitleModel,HxbHomePageModel_DataList;
@interface HXBHomeBaseModel : NSObject

/**
 bannerList数组数据
 */
@property (nonatomic, strong) NSArray *bannerList;

/**
 homePlanRecommend
 */
@property (nonatomic, strong) NSArray <HxbHomePageModel_DataList *>*homePlanRecommend;

/**
 homeTitle
 */
@property (nonatomic, strong) HXBHomeTitleModel *homeTitle;

@end
