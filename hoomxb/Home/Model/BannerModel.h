//
//  BannerModel.h
//  hoomxb
//
//  Created by HXB-C on 2017/5/2.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "BaseModel.h"

@interface BannerModel : BaseModel
///标题
@property (nonatomic, copy) NSString *title;
///图片绝对地址
@property (nonatomic, copy) NSString *picUrl;
///跳转链接
@property (nonatomic, copy) NSString *linkUrl;

@end
