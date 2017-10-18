//
//  HXBMYCapitalRecord_TableViewCell.h
//  hoomxb
//
//  Created by HXB on 2017/5/23.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBMYModel_CapitalRecordDetailModel;///资金记录的MOdel
@class HXBMYViewModel_MainCapitalRecordViewModel;///资金记录的ViewModel
///资产记录的TableViewCell
@interface HXBMYCapitalRecord_TableViewCell : UITableViewCell
///资金统计的列表
@property (nonatomic,strong) HXBMYViewModel_MainCapitalRecordViewModel *capitalRecortdDetailViewModel;
// 是否显示横线
@property (nonatomic, assign) int isShowCellLine;

@end
