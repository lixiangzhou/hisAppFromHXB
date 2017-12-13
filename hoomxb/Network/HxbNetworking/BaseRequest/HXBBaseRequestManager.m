//
//  HXBBaseRequestManager.m
//  hoomxb
//
//  Created by caihongji on 2017/12/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseRequestManager.h"
#import "NYBaseRequest.h"

@interface HXBBaseRequestManager()
// 线程锁
@property (nonatomic, strong) NSCondition* conditionLock;
// request列表
@property (nonatomic, strong) NSMutableArray* requestList;
//等待token获取结果的列表
@property (nonatomic, strong) NSMutableArray* waitTokenResultList;

@end

@implementation HXBBaseRequestManager

+ (instancetype)sharedInstance
{
    static HXBBaseRequestManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


@end
