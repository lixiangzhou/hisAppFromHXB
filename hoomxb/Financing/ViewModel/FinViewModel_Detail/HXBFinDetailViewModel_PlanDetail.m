//
//  HXBFinDetailViewModel_PlanDetail.m
//  hoomxb
//
//  Created by HXB on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinDetailViewModel_PlanDetail.h"
#import "HXBFinDetailModel_PlanDetail.h"
@implementation HXBFinDetailViewModel_PlanDetail
- (void)setPlanDetailModel:(HXBFinDetailModel_PlanDetail *)planDetailModel {
    _planDetailModel = planDetailModel;
}
- (NSString *)description {
    return [self yy_modelDescription];
}
@end
