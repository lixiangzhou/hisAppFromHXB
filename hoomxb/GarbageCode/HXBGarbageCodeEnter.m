//
//  HXBGarbageCodeEnter.m
//  hoomxb
//
//  Created by caihongji on 2018/7/2.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBGarbageCodeEnter.h"
#import "HXBG1.h"

@implementation HXBGarbageCodeEnter
+ (instancetype)shared {
    static HXBGarbageCodeEnter *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [HXBGarbageCodeEnter new];
    });
    return _instance;
}

- (void)forWordCup {
    [[HXBG1 shared] inject];
}
@end
