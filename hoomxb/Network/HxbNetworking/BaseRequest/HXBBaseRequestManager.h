//
//  HXBBaseRequestManager.h
//  hoomxb
//
//  Created by caihongji on 2017/12/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBBaseRequestManager : NSObject
//当前是否正在获取令牌
@property (nonatomic, assign) BOOL isGettingToken;

+ (instancetype)sharedInstance;
- (void)addRequest:(NYBaseRequest*)request;
@end
