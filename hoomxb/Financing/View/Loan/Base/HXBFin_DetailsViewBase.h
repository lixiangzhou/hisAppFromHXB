//
//  HXBFin_DetailsViewBase.h
//  hoomxb
//
//  Created by HXB on 2017/5/5.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBFin_DetailsViewBase : UIView
///显示视图，在给相关的属性赋值后，一定要调用show方法
- (void)show;
///剩余可投是否分为左右两个
@property (nonatomic,assign) BOOL isFlowChart;
@end
