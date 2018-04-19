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

/**
 cell点击 立即使用 按钮回调的Block
 */
@property (nonatomic, copy) void(^actionButtonClickBlock)();

@property (nonatomic, strong)  HXBMyCouponListModel *myCouponListModel;

@end
