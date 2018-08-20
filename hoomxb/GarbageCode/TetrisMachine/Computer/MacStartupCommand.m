//
//  MacStartupCommand.m
//  命令模式 命令模式test
//
//  Created by HXB-C on 2018/6/27.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "MacStartupCommand.h"

@interface MacStartupCommand()

@property (nonatomic, strong) MacComputer *computer;

@end

@implementation MacStartupCommand

- (instancetype)init:(MacComputer *)computer {
    if (self = [super init]) {
        self.computer = computer;
    }
    return self;
}

- (void)execute {
    [self.computer startup];
}

@end
