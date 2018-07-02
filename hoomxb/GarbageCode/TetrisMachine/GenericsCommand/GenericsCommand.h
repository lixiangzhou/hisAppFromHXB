//
//  GenericsCommand.h
//  命令模式test
//
//  Created by HXB-C on 2018/6/28.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TetrisMachineProtocol.h"
#import "TetrisMachine.h"

@interface GenericsCommand<T> : NSObject<TetrisMachineProtocol>

- (instancetype)init:(T)receiver andcommandBlock:(void(^)(T))commandBlock;

+ (instancetype)creatGenericsCommand:(T)receiver andCommandBlock:(void(^)(T))commandBlock;

@end
