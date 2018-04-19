//
//  HXBInviteListTableViewCell.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2017/11/9.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXBInviteModel.h"

UIKIT_EXTERN NSString *const HXBInviteListTableViewCellIdentifier;
UIKIT_EXTERN const CGFloat HXBInviteListTableViewCellHeight;

@interface HXBInviteListTableViewCell : UITableViewCell

@property (nonatomic, strong) HXBInviteModel *model;
@property (nonatomic, assign) BOOL isHiddenLine;

@end
