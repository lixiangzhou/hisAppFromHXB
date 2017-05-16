//
//  HXBMYRequest.h
//  hoomxb
//
//  Created by HXB on 2017/5/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXBMYViewModel_MianPlanViewModel;//我的plan 主界面的ViewModel


///关于个人主页的红利计划的 （账户内）
@interface HXBMYRequest : NSObject
///创建单利对象
+ (instancetype) sharedMYRequest;

#pragma mark - 红利计划的相关网络请求



@end
