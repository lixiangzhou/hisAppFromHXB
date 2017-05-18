//
//  HXBBaseView_MYList_TableViewCell.h
//  hoomxb
//
//  Created by HXB on 2017/5/16.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBMYViewModel_MianPlanViewModel;
@class HXBMYViewModel_MainLoanViewModel;
///红利计划的tableView 的cell
@interface HXBBaseView_MYList_TableViewCell : UITableViewCell
///数据源
@property (nonatomic,strong) HXBMYViewModel_MianPlanViewModel *planViewMode;
@property (nonatomic,strong) HXBMYViewModel_MainLoanViewModel *loanViewModel;
@end



    
