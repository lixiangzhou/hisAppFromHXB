//
//  HXBLazyCatResponseDelegate.h
//  hoomxb
//
//  Created by caihongji on 2018/4/25.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HXBLazyCatResponseModel;

@protocol HXBLazyCatResponseDelegate <NSObject>

@required
- (void)setResultPageProperty:(HXBLazyCatResponseModel*)model;

@end
