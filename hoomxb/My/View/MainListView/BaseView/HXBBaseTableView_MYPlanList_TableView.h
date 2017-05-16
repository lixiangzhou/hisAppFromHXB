//
//  HXBBaseTableView_MYPlanList_TableView.h
//  hoomxb
//
//  Created by HXB on 2017/5/16.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBMYViewModel_MianPlanViewModel;

///底部的TableView
@interface HXBBaseTableView_MYPlanList_TableView : HXBBaseTableView
///数据源
@property (nonatomic,strong) NSArray <HXBMYViewModel_MianPlanViewModel *>*mainPlanViewModelArray;
///点击了cell
@property (nonatomic,copy) void (^clickCellBlock)(id ViewModel, NSIndexPath *indexPath);
@end
