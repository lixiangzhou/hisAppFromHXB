//
//  DynamicCommandManner.h
//  命令模式test
//
//  Created by HXB-C on 2018/6/28.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DynamicCommand.h"
@interface DynamicCommandManner : NSObject

- (instancetype)init:(TetrisMachine *)tetrisMachine;

- (void)left;
- (void)right;
- (void)transforma;
- (void)undo;
- (void)undoAll;

@end
