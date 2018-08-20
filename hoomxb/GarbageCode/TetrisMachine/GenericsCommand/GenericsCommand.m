//
//  GenericsCommand.m
//  命令模式test
//
//  Created by HXB-C on 2018/6/28.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "GenericsCommand.h"
@interface GenericsCommand<T>()

@property (nonatomic, strong) T receiver;
@property (nonatomic, strong) void (^commandBlock)(T);

@end

@implementation GenericsCommand : NSObject
- (instancetype)init:(id)receiver andcommandBlock:(void(^)(id))commandBlock {
    if (self = [super init]) {
        self.receiver = receiver;
        self.commandBlock = commandBlock;
    }
    return self;
}

- (void)execute {
    self.commandBlock(self.receiver);
}

+ (instancetype)creatGenericsCommand:(id)receiver andCommandBlock:(void(^)(id))commandBlock {
    return [[GenericsCommand alloc] init:receiver andcommandBlock:commandBlock];
}

@end
