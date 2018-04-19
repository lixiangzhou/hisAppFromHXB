//
//  HXBChooseCouponModel.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2017/10/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HXBCouponModel.h"

@interface HXBChooseCouponModel : NSObject

// 不匹配最优id号。没有意义
@property (nonatomic, strong) NSArray <HXBCouponModel *> *dataList;
@property (nonatomic, strong) NSArray <HXBCouponModel *> *unusableList;

@end
