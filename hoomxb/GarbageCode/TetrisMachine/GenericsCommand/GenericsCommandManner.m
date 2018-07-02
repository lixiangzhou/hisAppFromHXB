//
//  GenericsCommandManner.m
//  命令模式test
//
//  Created by HXB-C on 2018/6/28.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "GenericsCommandManner.h"

@interface GenericsCommandManner()

@property (nonatomic, strong) TetrisMachine *tetrisMachine;
@property (nonatomic, strong) NSMutableArray *commands;

@end


@implementation GenericsCommandManner

- (instancetype)init:(TetrisMachine *)tetrisMachine {
    if (self = [super init]) {
        self.tetrisMachine = tetrisMachine;
        self.commands = [NSMutableArray array];
    }
    return self;
}

- (void)left {
    [self addCommand:@"left"];
    [self.tetrisMachine left];
}
- (void)right {
    [self addCommand:@"right"];
    [self.tetrisMachine right];
}
- (void)transforma {
    [self addCommand:@"transforma"];
    [self.tetrisMachine transforma];
}

- (void)addCommand:(NSString *)CommadnStr {
    SEL method = NSSelectorFromString(CommadnStr);
    [self.commands addObject:[GenericsCommand creatGenericsCommand:self.tetrisMachine andCommandBlock:^(id tetrisMachine) {
        
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
