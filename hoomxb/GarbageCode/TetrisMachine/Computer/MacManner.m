//
//  MacManner.m
//  命令模式test
//
//  Created by HXB-C on 2018/6/27.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "MacManner.h"

@interface MacManner ()

@property (nonatomic, strong) MacComputer *computer;
@property (nonatomic, strong) MacShutDownCommand *shutDownCommand;
@property (nonatomic, strong) MacStartupCommand *starupCommand;

@end


@implementation MacManner

- (instancetype)init:(MacComputer *)computer andShutDownCommand:(MacShutDownCommand *)shutDownCommand andStartupCommand:(MacStartupCommand *)starupCommand {
    if (self = [super init]) {
        self.computer = computer;
        self.shutDownCommand = shutDownCommand;
        self.starupCommand = starupCommand;
    }
    return self;
}

- (void)startup {
    [self.starupCommand execute];
}

- (void)shutdown {
    [self.shutDownCommand execute];
}

@end
