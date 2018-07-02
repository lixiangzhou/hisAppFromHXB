//
//  TetrisMachineLeftCommand.h
//  命令模式test
//
//  Created by HXB-C on 2018/6/27.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TetrisMachineProtocol.h"
#import "TetrisMachine.h"
@interface TetrisMachineLeftCommand : NSObject <TetrisMachineProtocol>

- (instancetype)init:(TetrisMachine *)tetrisMachine;

@end
