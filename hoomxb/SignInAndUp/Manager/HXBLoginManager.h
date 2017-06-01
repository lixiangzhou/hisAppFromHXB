//
//  HXBLoginManager.h
//  hoomxb
//
//  Created by HXB on 2017/6/1.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

///输入错误密码 几 次 就会进行图验
static int const kLoginTotalNumber = 3;

///登录的管理者  逻辑处理类
@interface HXBLoginManager : NSObject
///记录登录请求的次数， （存到了用户偏好设置中）
@property (nonatomic,strong) NSNumber *reuqestSignINNumber;
@end
