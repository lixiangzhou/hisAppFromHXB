//
//  DynamicCommand.m
//  命令模式test
//
//  Created by HXB-C on 2018/6/28.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "DynamicCommand.h"
@interface DynamicCommand ()

@property (nonatomic, strong) TetrisMachine *tetrisMachine;

@property (nonatomic, strong) dynamicCommandBlock commandBlock;

@end

@implementation DynamicCommand

- (instancetype)init:(TetrisMachine *)tetrisMachine andWithCommandBlock:(dynamicCommandBlock)commandBlock {
    if (self = [super init]) {
        self.tetrisMachine = tetrisMachine;
        self.commandBlock = commandBlock;
    }
    return self;
}

- (void)execute {
    self.commandBlock(self.tetrisMachine);
}

+ (instancetype)creatDynamicCommand:(TetrisMachine *)tetrisMachine andWithCommandBlock:(dynamicCommandBlock)commandBlock {
    return [[DynamicCommand alloc] init:tetrisMachine andWithCommandBlock:commandBlock];
}


@end
