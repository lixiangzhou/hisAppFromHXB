//
//  HXBBaseUrlManager.h
//  hoomxb
//
//  Created by lxz on 2017/11/16.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBBaseUrlManager : NSObject

@property (nonatomic, copy) NSString *baseUrl;

+ (instancetype)manager;

@end
