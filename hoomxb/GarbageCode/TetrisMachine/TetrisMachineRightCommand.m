//
//  TetrisMachineRightCommand.m
//  命令模式test
//
//  Created by HXB-C on 2018/6/27.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "TetrisMachineRightCommand.h"

@interface TetrisMachineRightCommand()

@property (nonatomic, strong) TetrisMachine *tetrisMachine;

@end


@implementation TetrisMachineRightCommand

- (instancetype)init:(TetrisMachine *)tetrisMachine {
    if (self = [super init]) {
        self.tetrisMachine = tetrisMachine;
    }
    return self;
}

- (void)execute {
    [self.tetrisMachine right];
}

@end
