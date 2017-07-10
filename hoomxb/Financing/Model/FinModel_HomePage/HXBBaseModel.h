//
//  HXBBaseViewModel.h
//  hoomxb
//
//  Created by HXB on 2017/7/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBBaseModel : NSObject
/**
 总长度
 */
@property (nonatomic,copy) NSString * totalCount;
/**
 每页数量
 */
@property (nonatomic,copy) NSString * pageSize;
/**
 页数
 */
@property (nonatomic,copy) NSString * pageNumber;
@end
