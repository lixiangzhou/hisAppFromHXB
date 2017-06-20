//
//  HXBRequestUserInfoViewModel.h
//  hoomxb
//
//  Created by HXB on 2017/6/1.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBUserInfoModel.h"

///用户相关的VIewmode
@interface HXBRequestUserInfoViewModel : NSObject
@property (nonatomic,strong) HXBUserInfoModel *userInfoModel;
///可用余额
@property (nonatomic,copy) NSString *availablePoint;
@end
