//
//  HXBMyPlanDetailsExitMainView.h
//  hoomxb
//
//  Created by hxb on 2018/3/12.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXBMyPlanDetailsExitModel.h"

@interface HXBMyPlanDetailsExitMainView : UIView

@property (nonatomic,strong) HXBMyPlanDetailsExitModel *myPlanDetailsExitModel;
/**
 确认退出
 */
@property (nonatomic, copy) void(^exitBtnClickBlock)();
/**
 暂不退出
 */
@property (nonatomic, copy) void(^cancelBtnClickBlock)();

@end
