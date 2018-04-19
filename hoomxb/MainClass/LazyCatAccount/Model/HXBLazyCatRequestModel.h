//
//  HXBLazyCatRequestModel.h
//  hoomxb
//
//  Created by caihongji on 2018/4/19.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBLazyCatRequestModel : NSObject

///接口名称
@property (nonatomic, copy) NSString* serviceName;
///平台编号
@property (nonatomic, copy) NSString* platformNo;
///业务数据报文
@property (nonatomic, copy) NSString* reqData;
///证书序号
@property (nonatomic, copy) NSString* keySerial;
///签名
@property (nonatomic, copy) NSString* sign;
///懒猫网关地址
@property (nonatomic, copy) NSString* url;

@end
