//
//  HXBLazyCatResponseModel.m
//  hoomxb
//
//  Created by caihongji on 2018/4/23.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBLazyCatResponseModel.h"

@implementation HXBLazyCatResponseModel

- (instancetype)initWithAction:(NSString*)action
{
    self = [super init];
    if (self) {
        //使用默认类型
        _data = [[HXBLazyCatResultPageModel alloc] init];
    }
    return self;
}

@end
