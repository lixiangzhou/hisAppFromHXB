//
//  HXBLazyCatResponseModel.h
//  hoomxb
//
//  Created by caihongji on 2018/4/23.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBLazyCatResultPageModel.h"

@interface HXBLazyCatResponseModel : NSObject

///具体的动作
@property (nonatomic, copy) NSString* action;
///恒丰返回结果。’success’成功，’error’失败，’timeout’超时
@property (nonatomic, copy) NSString* result;
///结果页需要的具体参数
@property (nonatomic, strong) HXBLazyCatResultPageModel* data;

@end
