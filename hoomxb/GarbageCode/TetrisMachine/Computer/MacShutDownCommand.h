//
//  MacShutDownCommand.h
//  命令模式test
//
//  Created by HXB-C on 2018/6/27.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ComputerProtocol.h"
#import "MacComputer.h"
@interface MacShutDownCommand : NSObject<ComputerProtocol>

- (instancetype)init:(MacComputer *)computer;

@end
