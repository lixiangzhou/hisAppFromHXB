//
//  HXBFinAddRecordVC_Plan.h
//  hoomxb
//
//  Created by HXB on 2017/5/11.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBFinHomePageViewModel_PlanList;
@interface HXBFinAddRecordVC_Plan : HXBBaseViewController
/**
 planID
 */
@property (nonatomic, copy) NSString *planID;
@property (nonatomic,strong) HXBFinHomePageViewModel_PlanList *planListViewModel;
@end
