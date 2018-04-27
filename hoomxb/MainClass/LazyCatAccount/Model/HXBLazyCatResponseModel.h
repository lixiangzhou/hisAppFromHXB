//
//  HXBLazyCatResponseModel.h
//  hoomxb
//
//  Created by caihongji on 2018/4/23.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBLazyCatResponseDelegate.h"
#import "HXBLazyCatResultPageModel.h"

@interface HXBLazyCatResponseModel : NSObject

///具体的动作
@property (nonatomic, copy) NSString* action;
///恒丰返回结果。’success’成功，’error’失败，’timeout’超时
@property (nonatomic, copy) NSString* result;
///结果页需要的具体参数
@property (nonatomic, strong) HXBLazyCatResultPageModel* data;

/**
 根据动作指定data的具体类型

 @param action 动作
 @return 实例
 */
- (instancetype)initWithAction:(NSString*)action;
@end
