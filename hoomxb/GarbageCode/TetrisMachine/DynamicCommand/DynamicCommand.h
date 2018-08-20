//
//  DynamicCommand.h
//  命令模式test
//
//  Created by HXB-C on 2018/6/28.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TetrisMachineProtocol.h"
#import "TetrisMachine.h"

typedef void(^dynamicCommandBlock)(TetrisMachine * tetrisMachine);

@interface DynamicCommand : NSObject<TetrisMachineProtocol>

- (instancetype)init:(TetrisMachine *)tetrisMachine andWithCommandBlock:(dynamicCommandBlock)commandBlock;

+ (instancetype)creatDynamicCommand:(TetrisMachine *)tetrisMachine andWithCommandBlock:(dynamicCommandBlock)commandBlock;

@end
