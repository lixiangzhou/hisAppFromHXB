//
//  HXBMY_PlanDetail_TypeCell.h
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseTableViewCell.h"
@class HXBMYViewModel_PlanDetailViewModel;
///type的Cell && 合同的cell
@interface HXBMY_PlanDetail_TypeCell : HXBBaseTableViewCell
- (void) setupValueWithModel: (HXBMYViewModel_PlanDetailViewModel *)planDetailViewModel andLeftStr: (NSString *)leftStr andRightStr: (NSString *)right andRightColor: (UIColor *)rightColor;
@end
