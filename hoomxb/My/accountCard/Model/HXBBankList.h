//
//  HXBBankList.h
//  hoomxb
//
//  Created by HXB-C on 2017/7/24.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBBankList : NSObject

/**
 name
 */
@property (nonatomic, copy) NSString *name;

/**
 single
 */
@property (nonatomic, copy) NSString *single;

/**
 day
 */
@property (nonatomic, copy) NSString *day;

/**
 bankCode
 */
@property (nonatomic, copy) NSString *bankCode;

/**
 对限额字符串处理
 */
@property (nonatomic, copy) NSString *quota;

@end
