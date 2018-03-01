//
//  HXBBaseViewModel+HXB.h
//  hoomxb
//
//  Created by caihongji on 2018/2/26.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBBaseViewModel.h"
#import "HXBRequestUserInfoViewModel.h"

@interface HXBBaseViewModel(KEYCHAIN)

//用户信息
@property (nonatomic, strong) HXBRequestUserInfoViewModel* userInfoModel;

/**
 通过keychain加载用户信息

 @param isShowHud 是否显示加载框
 @param resultBlock 结果回调
 */
- (void)downLoadUserInfo:(BOOL)isShowHud resultBlock:(void(^)(BOOL isSuccess))resultBlock;
@end
