//
//  HXBHomePlatformIntroductionModel.h
//  hoomxb
//
//  Created by HXB-C on 2018/3/1.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBHomePlatformIntroductionModel : NSObject

/**
 跳转的H5地址
 */
@property (nonatomic, copy) NSString *url;

/**
 图片地址
 */
@property (nonatomic, copy) NSString *image;

/**
 跳转类型
 */
@property (nonatomic, copy) NSString *type;

@end
