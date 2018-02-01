//
//  HXBTenderDetailCell.h
//  hoomxb
//
//  Created by lxz on 2018/1/19.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXBTenderDetailModel.h"

UIKIT_EXTERN NSString *const HXBTenderDetailCellIdentifier;
UIKIT_EXTERN const CGFloat HXBTenderDetailCellHeight;

@interface HXBTenderDetailCell : UITableViewCell
@property (nonatomic, strong) HXBTenderDetailModel *model;
@end
