//
//  HXBMyCouponListTableViewCell.h
//  hoomxb
//
//  Created by hxb on 2017/10/31.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBMyCouponListModel;
@interface HXBMyCouponListTableViewCell : UITableViewCell


@property (nonatomic, strong)  UIButton *actionBtn;//"立即使用"
@property (nonatomic, strong)  HXBMyCouponListModel *myCouponListModel;

@end
