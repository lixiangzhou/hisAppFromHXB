//
//  HXBFinancing_PlanViewController.h
//  hoomxb
//
//  Created by HXB on 2017/5/4.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBFinDetail_TableViewCellModel;
///红利计划详情页的控制器
@interface HXBFinancing_PlanDetailsViewController : HXBBaseViewController
///剩余可投是否分为左右两个
@property (nonatomic,assign) BOOL isFlowChart;

///是否为红利计划
@property (nonatomic,assign) BOOL isPlan;

///底部的tableView的模型数组
@property (nonatomic,strong) NSArray <HXBFinDetail_TableViewCellModel *>*modelArray;

///计划id
@property (nonatomic,copy) NSString *planID;
@end
