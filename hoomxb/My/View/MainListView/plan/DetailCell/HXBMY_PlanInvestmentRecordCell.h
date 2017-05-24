//
//  HXBMY_PlanInvestmentRecordCell.h
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseTableViewCell.h"
@class HXBMYViewModel_PlanDetailViewModel;

/// 投资记录的Cell
@interface HXBMY_PlanInvestmentRecordCell : HXBBaseTableViewCell
///投资记录 str
@property (nonatomic,copy) NSString *planInvestmentRecord;
/// 投资记录的StrConst
@property (nonatomic,copy) NSString *PlanInvestmentRecord_const;

@property (nonatomic,strong) HXBMYViewModel_PlanDetailViewModel *planDetailViewModel;

@end