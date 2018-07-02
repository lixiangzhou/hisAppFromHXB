//
//  MacManner.h
//  命令模式test
//
//  Created by HXB-C on 2018/6/27.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MacComputer.h"
#import "MacShutDownCommand.h"
#import "MacStartupCommand.h"
@interface MacManner : NSObject

- (instancetype)init:(MacComputer *)computer andShutDownCommand:(MacShutDownCommand *)shutDownCommand andStartupCommand:(MacStartupCommand *)starupCommand;

- (void)startup;
- (void)shutdown;

@end
