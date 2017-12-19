//
//  HXBBaseContDownModel.m
//  hoomxb
//
//  Created by caihongji on 2017/12/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseContDownModel.h"

@implementation HXBBaseContDownModel

- (id)copyWithZone:(NSZone *)zone{
    HXBBaseContDownModel *model = [[[self class] allocWithZone:zone] init];
    model.countDownString = [self.countDownString copy];
    model.countDownLastStr  = [self.countDownLastStr copy];

    return model;
}

@end
