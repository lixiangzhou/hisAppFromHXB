//
//  HXBMyTraderPasswordGetVerifyCodeViewModel.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/2/9.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"

@interface HXBMyTraderPasswordGetVerifyCodeViewModel : HXBBaseViewModel


/**
 获取修改交易密码的验证码API

 @param action 验证码类型
 @param resultBlock 返回结果
 */
- (void)myTraderPasswordGetverifyCodeWithAction: (NSString *)action
                                    resultBlock: (void(^)(BOOL isSuccess))resultBlock;

@end
