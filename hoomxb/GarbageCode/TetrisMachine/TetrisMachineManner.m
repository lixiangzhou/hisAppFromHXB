//
//  TetrisMachineManner.m
//  命令模式test
//
//  Created by HXB-C on 2018/6/27.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "TetrisMachineManner.h"

@interface TetrisMachineManner ()

@property (nonatomic, strong) NSMutableArray *commands;
@property (nonatomic, strong) TetrisMachine *tetrisMachine;
@property (nonatomic, strong) TetrisMachineLeftCommand *leftCommand;
@property (nonatomic, strong) TetrisMachineRightCommand *rightCommand;
@property (nonatomic, strong) TetrisMachineTransformaCommand *transformaCommand;
@end

@implementation TetrisMachineManner

- (instancetype)init:(TetrisMachine *)tetrisMachine andLeftCommand:(TetrisMachineLeftCommand *)leftCommand andRightCommand:(TetrisMachineRightCommand *)rightCommand andTransformaCommand:(TetrisMachineTransformaCommand *)transformaCommand {
    if (self = [super init]) {
        self.commands = [NSMutableArray array];
        self.tetrisMachine = tetrisMachine;
        self.leftCommand = leftCommand;
        self.rightCommand = rightCommand;
        self.transformaCommand = transformaCommand;
    }
    return self;
}

- (void)left {
    [self.leftCommand execute];
    [self.commands addObject:[[TetrisMachineLeftCommand alloc] init:self.tetrisMachine]];
}
- (void)right {
    [self.rightCommand execute];
    [self.commands addObject:[[TetrisMachineRightCommand alloc] init:self.tetrisMachine]];
}
- (void)transforma {
    [self.transformaCommand execute];
    [self.commands addObject:[[TetrisMachineTransformaCommand alloc] init:self.tetrisMachine]];
}

- (void)undo {
    if (self.commands.count) {
        NSLog(@"撤销单个操作");
        //撤销操作
        [self.commands removeLastObject];
    }
}

- (void)undoAll {
    if (self.commands.count) {
        NSLog(@"撤销所有操作");
        [self.commands removeAllObjects];
    }
}

@end
