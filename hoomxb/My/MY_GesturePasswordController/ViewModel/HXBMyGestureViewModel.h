//
//  HXBMyGestureViewModel.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/2/9.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"

@interface HXBMyGestureViewModel : HXBBaseViewModel

/**
 设置手势密码

 @param password 登录密码
 @param resultBlock 返回结果
 */
- (void)accountSetGesturePasswordWithPassword:(NSString *)password
                                  resultBlock: (void(^)(BOOL isSuccess))resultBlock;

@end
