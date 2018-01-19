//
//  HXBHomeNewbieProductModel.h
//  hoomxb
//
//  Created by HXB-C on 2018/1/19.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HxbHomePageModel_DataList;
@interface HXBHomeNewbieProductModel : NSObject

/**
 新手产品列表
 */
@property (nonatomic, strong) NSArray <HxbHomePageModel_DataList *>*dataList;

/**
 新手图片img
 */
@property (nonatomic, copy) NSString *img;
@end
