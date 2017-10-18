//
//  HXBFinancing_LoanDetailsViewController.h
//  hoomxb
//
//  Created by HXB on 2017/5/4.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBFinDetail_TableViewCellModel;
@class HXBFinHomePageViewModel_LoanList;

///散标详情页的控制器
@interface HXBFinancing_LoanDetailsViewController : HXBBaseViewController

///剩余可投是否分为左右两个
@property (nonatomic,assign) BOOL isFlowChart;

///底部的tableView的模型数组
@property (nonatomic,strong) NSArray <HXBFinDetail_TableViewCellModel *>*modelArray;

///loanID
@property (nonatomic,copy) NSString *loanID;

@property (nonatomic,strong) HXBFinHomePageViewModel_LoanList *loanListViewMode;
@end
