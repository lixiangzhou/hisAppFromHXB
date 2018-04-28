//
//  HXBLazyCatRequestModel.h
//  hoomxb
//
//  Created by caihongji on 2018/4/19.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXBLazyCatRequestResultModel;
@interface HXBLazyCatRequestModel : NSObject

//懒猫返回结果
@property (nonatomic, strong) HXBLazyCatRequestResultModel* result;

///懒猫网关地址
@property (nonatomic, copy) NSString* url;

@end
