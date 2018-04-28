//
//  HXBLazyCatRequestResultModel.h
//  hoomxb
//
//  Created by HXB-C on 2018/4/28.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBLazyCatRequestResultModel : NSObject

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

@end
