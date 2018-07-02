//
//  TetrisMachineTransformaCommand.m
//  命令模式test
//
//  Created by HXB-C on 2018/6/27.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "TetrisMachineTransformaCommand.h"

@interface TetrisMachineTransformaCommand ()

@property (nonatomic, strong) TetrisMachine *tetrisMachine;

@end

@implementation TetrisMachineTransformaCommand

- (instancetype)init:(TetrisMachine *)tetrisMachine {
    if (self = [super init]) {
        self.tetrisMachine = tetrisMachine;
    }
    return self;
}

- (void)execute {
    [self.tetrisMachine transforma];
}

@end
