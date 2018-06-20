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
wechat    string    微信分享的链接（跳转）地址，相对地址，相对h5host
moments    string    微信朋友圈分享的链接（跳转）地址，相对地址，相对h5host
qq    string    QQ分享的链接（跳转）地址，相对地址，相对h5host
qzone    string    QQ空间分享的链接（跳转）地址，相对地址，相对h5host
image    string    分享的logo图片地址,绝对地址
*/

/**
2.9.0新增活动可分享状态
*/
@property (nonatomic, copy) NSString *status;

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
  微信分享的链接（跳转）地址，相对地址，相对h5host
 */
@property (nonatomic, copy) NSString *wechat;
/**
 微信朋友圈分享的链接（跳转）地址，相对地址，相对h5host
 */
@property (nonatomic, copy) NSString *moments;
/**
 QQ分享的链接（跳转）地址，相对地址，相对h5host
 */
@property (nonatomic, copy) NSString *qq;
/**
 QQ空间分享的链接（跳转）地址，相对地址，相对h5host
 */
@property (nonatomic, copy) NSString *qzone;
/**
 分享的logo图片地址,绝对地址
 */
@property (nonatomic, copy) NSString *image;
@end
