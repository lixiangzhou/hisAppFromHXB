//
//  HXBHomeFooterView.h
//  hoomxb
//
//  Created by HXB-C on 2018/3/1.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HxbHomePageViewModel,HXBHomePlatformIntroductionModel;
@interface HXBHomeFooterView : UIView

/**
 请求下来的数据模型
 */
@property (nonatomic, strong) HxbHomePageViewModel *homeBaseViewModel;

/**
 回调的block
 */
@property (nonatomic, copy) void (^homePlatformIntroduction)(HXBHomePlatformIntroductionModel *model);

@end
