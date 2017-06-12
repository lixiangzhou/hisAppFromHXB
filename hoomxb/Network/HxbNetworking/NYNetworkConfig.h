//
//  NYNetworkConfig.h
//  NYNetwork
//
//  Created by 牛严 on 16/6/28.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
///网络请求 的基本配置，网络状态的监听
@interface NYNetworkConfig : NSObject

/**
 *  获取单例
 */
+ (NYNetworkConfig *)sharedInstance;

//基本地址
@property (nonatomic, copy) NSString *baseUrl;
//app版本号
@property (nonatomic, copy) NSString *version;
//请求头添加的内容，根据token和version生成，无法直接设置
@property (nonatomic, strong, readonly) NSDictionary *additionalHeaderFields;

//请求超时时间
@property (nonatomic, assign) NSTimeInterval defaultTimeOutInterval;

@property (nonatomic, strong) NSIndexSet *defaultAcceptableStatusCodes;

@property (nonatomic, strong) NSSet *defaultAcceptableContentTypes;



// -------------------------- readMe -----------------------------
/*
 APPdelegate中用这个类的单利对象设置了
 1. 设置了网络的baseURL，
 2. 设置了请求头
 
 在单利创建的时候，对网络环境进行了检测
 */
@end
