//
//  HXBUMShareModel.h
//  hoomxb
//
//  Created by HXB-C on 2017/11/15.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBUMShareModel : NSObject
/*
title    string    分享标题
desc    string    分享具体描述
link    string    分享的链接（跳转）地址，相对地址，相对h5host
image    string    分享的logo图片地址,绝对地址
*/

/**
分享标题
*/
@property (nonatomic, copy) NSString *title;
/**
 分享具体描述
 */
@property (nonatomic, copy) NSString *desc;
/**
 分享的链接（跳转）地址，相对地址，相对h5host
 */
@property (nonatomic, copy) NSString *link;
/**
 分享的logo图片地址,绝对地址
 */
@property (nonatomic, copy) NSString *image;
@end
