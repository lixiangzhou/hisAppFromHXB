//
//  HXBMyAccountSecurityViewModel.h
//  hoomxb
//
//  Created by hxb on 2018/2/27.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBBaseViewModel+KEYCHAIN.h"
#import "HXBLazyCatRequestModel.h"
@interface HXBMyAccountSecurityViewModel : HXBBaseViewModel
@property (nonatomic, strong) HXBLazyCatRequestModel *lazyCatRequestModel;
/// 修改交易密码
- (void)modifyTransactionPasswordResultBlock:(void(^)(BOOL isSuccess))resultBlock;
@end
