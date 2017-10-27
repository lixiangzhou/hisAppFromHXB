//
//  HXBWithdrawRecordListModel.m
//  hoomxb
//
//  Created by HXB-C on 2017/10/26.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBWithdrawRecordListModel.h"
#import "HXBWithdrawRecordModel.h"
@implementation HXBWithdrawRecordListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"dataList" : [HXBWithdrawRecordModel class]
             };
}
@end
