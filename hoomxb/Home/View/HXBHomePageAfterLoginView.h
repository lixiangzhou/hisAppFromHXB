//
//  HXBHomePageAfterLoginView.h
//  HongXiaoBao
//
//  Created by HXB-C on 2016/11/15.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AssetOverviewModel.h"

@interface HXBHomePageAfterLoginView : UIView
//@property (nonatomic,strong)AssetOverviewModel * profitModel;
@property (nonatomic, strong) NSString *tipString;

/**
 各种认证按钮的点击回调Block
 */
@property (nonatomic, copy) void(^tipButtonClickBlock)();


//- (void)setProfitData;
@end
