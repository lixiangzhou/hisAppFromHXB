//
//  HXBMY_PlanDetail_InfoCell.h
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseTableViewCell.h"
@class HXBMYViewModel_PlanDetailViewModel;

///中部的信息 的cell
@interface HXBMY_PlanDetail_InfoCell : HXBBaseTableViewCell


@property (nonatomic,strong) HXBMYViewModel_PlanDetailViewModel *planDetailViewModel;
@end
