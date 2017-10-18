//
//  HXBNoticModel.h
//  hoomxb
//
//  Created by HXB-C on 2017/7/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBNoticModel : NSObject
/*
 id = dac5acdf-378e-49f9-b1eb-8c666eb38cad;
	title = app公告1;
	content = 测试埃里克森大姐夫可拉伸的附件阿斯顿发撒旦法;
	updateTime = 1499930840974;
	date = 1499875200000;
 */

/**
 ID
 */
@property (nonatomic, copy) NSString *ID;
/**
 title
 */
@property (nonatomic, copy) NSString *title;
/**
 content
 */
@property (nonatomic, copy) NSString *content;
/**
 updateTime
 */
@property (nonatomic, copy) NSString *updateTime;
/**
 date
 */
@property (nonatomic, copy) NSString *date;

@end
