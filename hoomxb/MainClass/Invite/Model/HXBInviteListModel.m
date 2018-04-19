//
//  HXBInviteListModel.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2017/11/9.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBInviteListModel.h"

@implementation HXBInviteListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"dataList" : [HXBInviteModel class]
             };
}

@end
