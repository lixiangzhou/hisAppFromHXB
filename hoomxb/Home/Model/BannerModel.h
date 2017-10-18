//
//  BannerModel.h
//  hoomxb
//
//  Created by HXB-C on 2017/5/2.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "BaseModel.h"

@interface BannerModel : NSObject

///标题
@property (nonatomic, copy) NSString *title;
///图片绝对地址
@property (nonatomic, copy) NSString *image;
///跳转链接
@property (nonatomic, copy) NSString *url;
/**
 开始时间
 */
@property (nonatomic, copy) NSString *start;
/**
 结束时间
 */
@property (nonatomic, copy) NSString *end;
/**
 背景色
 */
@property (nonatomic, copy) NSString *color;
/**
 id
 */
@property (nonatomic, copy) NSString *ID;
/**
 创建时间
 */
@property (nonatomic, copy) NSString *createTime;
/**
 更新时间
 */
@property (nonatomic, copy) NSString *updateTime;

@end
