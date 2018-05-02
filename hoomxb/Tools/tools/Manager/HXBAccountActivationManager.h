//
//  HXBAccountActivationManager.h
//  hoomxb
//
//  Created by caihongji on 2018/5/2.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBAccountActivationManager : NSObject

//是否已经弹出. 当激活弹窗消失后， 需要设置这个值为FALSE; 反之亦然
@property (nonatomic, assign) BOOL isPoped;

+ (instancetype)sharedInstance;
/**
 激活账户
 */
- (void)activeAccount;

@end
