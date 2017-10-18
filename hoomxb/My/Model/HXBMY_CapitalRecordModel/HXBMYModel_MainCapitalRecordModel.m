//
//  HXBMYModel_MainCapitalRecordModel.m
//  hoomxb
//
//  Created by HXB on 2017/5/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMYModel_MainCapitalRecordModel.h"

@implementation HXBMYModel_MainCapitalRecordModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"dataList":[HXBMYModel_MainCapitalRecordModel_dataList class],
             };
}
@end
@implementation HXBMYModel_MainCapitalRecordModel_dataList
@end
