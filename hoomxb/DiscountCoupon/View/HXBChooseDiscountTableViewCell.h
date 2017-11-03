//
//  HXBChooseDiscountTableViewCell.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2017/10/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXBCouponModel.h"
@interface HXBChooseDiscountTableViewCell : UITableViewCell

// 是否可用
@property (nonatomic, assign) BOOL isAvalible;
// 优惠券数据
@property (nonatomic, strong) HXBCouponModel *couponModel;
// 是否匹配
@property (nonatomic, assign) BOOL hasSelect;
// 是否隐藏横线
@property (nonatomic, assign) BOOL isHiddenLine;

@end
