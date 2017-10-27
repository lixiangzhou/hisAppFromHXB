//
//  HXBFinPlanContract_contraceWebViewVC.h
//  hoomxb
//
//  Created by HXB on 2017/5/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBFinPlanContract_contraceWebViewVC : HXBBaseViewController
/**
 H5页面的URL
 */
@property (nonatomic,copy) NSString *URL;
/**
 是否显示导航栏右边的按钮
 */
@property (nonatomic, assign) BOOL isShowRightBtn;
@end
