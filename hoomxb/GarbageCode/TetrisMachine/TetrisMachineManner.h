//
//  TetrisMachineManner.h
//  命令模式test
//
//  Created by HXB-C on 2018/6/27.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TetrisMachine.h"
#import "TetrisMachineLeftCommand.h"
#import "TetrisMachineRightCommand.h"
#import "TetrisMachineTransformaCommand.h"
@interface TetrisMachineManner : NSObject

- (instancetype)init:( TetrisMachine *)tetrisMachine andLeftCommand:(TetrisMachineLeftCommand *)leftCommand andRightCommand:(TetrisMachineRightCommand *)rightCommand andTransformaCommand:(TetrisMachineTransformaCommand *)transformaCommand;

- (void)left;
- (void)right;
- (void)transforma;
- (void)undo;
- (void)undoAll;
@end
