//
//  HXBHomeBaseModel.h
//  hoomxb
//
//  Created by HXB-C on 2017/6/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HXBHomeTitleModel;
@interface HXBHomeBaseModel : NSObject

/**
 bannerList数组数据
 */
@property (nonatomic, strong) NSArray *bannerList;

/**
 homePlanRecommend
 */
@property (nonatomic, strong) NSArray *homePlanRecommend;

/**
 homeTitle
 */
@property (nonatomic, strong) HXBHomeTitleModel *homeTitle;

@end
