//
//  HXBLazyCatResponseModel.m
//  hoomxb
//
//  Created by caihongji on 2018/4/23.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBLazyCatResponseModel.h"

@implementation HXBLazyCatResponseModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"data" : [HXBLazyCatResultPageModel class]
             };
}

- (instancetype)initWithAction:(NSString*)action
{
    self = [super init];
    if (self) {
        if([action isEqualToString:kTransfer] || [action isEqualToString:kPlan] || [action isEqualToString:kLoan]) {
            //购买
            _data = [[HXBLazyCatResultBuyModel alloc] init];
        }
        else if([action isEqualToString:kQuickrecharge]) {
            //快捷充值
            _data = [[HXBLazyCatResultQuickrechargeModel alloc] init];
        }
        else if([action isEqualToString:kWithdrawal]) {
            //提现
            _data = [[HXBLazyCatResultWithdrawalModel alloc] init];
        }
        else {
            //使用默认类型
            _data = [[HXBLazyCatResultPageModel alloc] init];
        }
    }
    return self;
}

- (NSString *)imageName {
    if ([self.result isEqualToString:@"success"]) {
        _imageName = @"successful";
    } else if ([self.result isEqualToString:@"error"]) {
        _imageName = @"failure";
    } else if ([self.result isEqualToString:@"timeout"]) {
        _imageName = @"outOffTime";
    } else {
        _imageName = @"--";
    }
    return _imageName;
}

@end
