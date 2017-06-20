//
//  HXBHomeTitleModel.h
//  hoomxb
//
//  Created by HXB-C on 2017/6/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBHomeTitleModel : NSObject
/*
 planTitle	String	计划提示标题
 baseTitle	String	底部提示
 */
/**
 计划提示标题
 */
@property (nonatomic, copy) NSString *planTitle;
/**
 底部提示
 */
@property (nonatomic, copy) NSString *baseTitle;

@end
