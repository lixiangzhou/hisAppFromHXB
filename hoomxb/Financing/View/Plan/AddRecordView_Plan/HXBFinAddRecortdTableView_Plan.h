//
//  HXBFinAddRecortdTableView_Plan.h
//  hoomxb
//
//  Created by HXB on 2017/5/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseTableView.h"
@class HXBFinModel_AddRecortdModel_Plan;
@interface HXBFinAddRecortdTableView_Plan : HXBBaseTableView
@property (nonatomic,strong) HXBFinModel_AddRecortdModel_Plan *addRecortdModel_Plan;
@end

@class HXBFinModel_AddRecortdModel_Plan_dataList;
@interface HXBFinAddRecortdTableViewCell_Plan : HXBBaseTableViewCell
@property (nonatomic,strong) HXBFinModel_AddRecortdModel_Plan_dataList *addRecortdModel_plan_dataList;
@end
