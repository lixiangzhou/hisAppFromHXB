//
//  HXBRemoteUpdateInterface.h
//  hoomxb
//
//  Created by caihongji on 2018/4/26.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HXBRemoteUpdateInterface <NSObject>

@optional
/**
 通知更新网络数据
 */
- (void)updateNetWorkData;

@end
