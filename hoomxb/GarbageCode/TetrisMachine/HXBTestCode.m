//
//  HXBTestCode.m
//  hoomxb
//
//  Created by HXB-C on 2018/7/2.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBTestCode.h"
#import "MacManner.h"
#import "TetrisMachineManner.h"
#import "DynamicCommandManner.h"
#import "GenericsCommandManner.h"
@implementation HXBTestCode

- (void)testCode {
    TetrisMachine *tetrisMachine = [[TetrisMachine alloc] init];
    GenericsCommandManner *genericsManner = [[GenericsCommandManner alloc] init:tetrisMachine];
    [genericsManner left];
    [genericsManner right];
    [genericsManner transforma];
}

- (void)dynamicCommand {
    TetrisMachine *tetrisMachine = [[TetrisMachine alloc] init];
    DynamicCommandManner *dynamicManner = [[DynamicCommandManner alloc] init:tetrisMachine];
    
    [dynamicManner left];
    [dynamicManner right];
    [dynamicManner transforma];
    
    [dynamicManner undo];
}

- (void)tetrisMachineCommand {
    
    TetrisMachine *tetrisMachine = [[TetrisMachine alloc] init];
    TetrisMachineLeftCommand *leftCommand = [[TetrisMachineLeftCommand alloc] init:tetrisMachine];
    TetrisMachineRightCommand *rightCommand = [[TetrisMachineRightCommand alloc] init:tetrisMachine];
    TetrisMachineTransformaCommand *transformaCommand = [[TetrisMachineTransformaCommand alloc] init:tetrisMachine];
    
    TetrisMachineManner *tmManner = [[TetrisMachineManner alloc] init:tetrisMachine andLeftCommand:leftCommand andRightCommand:rightCommand andTransformaCommand:transformaCommand];
    
    [tmManner left];
    [tmManner right];
    [tmManner transforma];
    
    [tmManner undo];
    [tmManner undoAll];
}


- (void)computerCommand {
    MacComputer *computer = [[MacComputer alloc] init];
    
    MacStartupCommand *startupCommand = [[MacStartupCommand alloc] init:computer];
    
    MacShutDownCommand *shutDownCommand = [[MacShutDownCommand alloc] init:computer];
    
    MacManner *manner = [[MacManner alloc] init:computer andShutDownCommand:shutDownCommand andStartupCommand:startupCommand];
    
    [manner startup];
    [manner shutdown];
}

@end
