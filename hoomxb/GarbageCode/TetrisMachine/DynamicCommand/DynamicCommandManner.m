//
//  DynamicCommandManner.m
//  命令模式test
//
//  Created by HXB-C on 2018/6/28.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "DynamicCommandManner.h"

@interface DynamicCommandManner()

@property (nonatomic, strong) TetrisMachine *tetrisMachine;
@property (nonatomic, strong) NSMutableArray *commands;

@end

@implementation DynamicCommandManner

- (instancetype)init:(TetrisMachine *)tetrisMachine {
    if (self = [super init]) {
        self.tetrisMachine = tetrisMachine;
        self.commands = [NSMutableArray array];
    }
    return self;
}

- (void)left {
    [self addComand:@"left"];
    [self.tetrisMachine left];
}
- (void)right {
    [self addComand:@"right"];
    [self.tetrisMachine right];
}
- (void)transforma {
    [self addComand:@"transforma"];
    [self.tetrisMachine transforma];
}

- (void)addComand:(NSString *)commandStr {
    SEL method = NSSelectorFromString(commandStr);
    [self.commands addObject:[DynamicCommand creatDynamicCommand:self.tetrisMachine andWithCommandBlock:^(TetrisMachine *tetrisMachine) {
        
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [tetrisMachine performSelector:method];
        #pragma clang diagnostic pop
    }]];
    
}

- (void)undo {
    if (self.commands.count) {
        [self.commands.lastObject execute];
        [self.commands removeLastObject];
    }
}
- (void)undoAll {
    if (self.commands.count) {
        [self.commands removeAllObjects];
    }
}


@end
