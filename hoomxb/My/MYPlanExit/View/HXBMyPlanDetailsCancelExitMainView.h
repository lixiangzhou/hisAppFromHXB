//
//  HXBMyPlanDetailsCancelExitMainView.h
//  hoomxb
//
//  Created by hxb on 2018/3/19.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXBMyPlanDetailsExitModel.h"

@interface HXBMyPlanDetailsCancelExitMainView : UIView

@property (nonatomic,strong) HXBMyPlanDetailsExitModel *myPlanDetailsExitModel;

/**
 确认取消
 */
@property (nonatomic, copy) void(^cancelExitBtnClickBlock)();
/**
 暂不取消
 */
@property (nonatomic, copy) void(^notCancelBtnClickBlock)();

@end
