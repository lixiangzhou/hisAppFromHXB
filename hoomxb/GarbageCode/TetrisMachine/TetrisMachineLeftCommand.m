//
//  TetrisMachineLeftCommand.m
//  命令模式test
//
//  Created by HXB-C on 2018/6/27.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "TetrisMachineLeftCommand.h"

@interface TetrisMachineLeftCommand ()

@property (nonatomic, strong) TetrisMachine *tetrisMachine;

@end

@implementation TetrisMachineLeftCommand

- (instancetype)init:(TetrisMachine *)tetrisMachine {
    if (self = [super init]) {
        self.tetrisMachine = tetrisMachine;
    }
    return self;
}

- (void)execute {
    [self.tetrisMachine left];
}


@end
