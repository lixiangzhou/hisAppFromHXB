//
//  HxbHomeRequest_dataList.h
//  hoomxb
//
//  Created by HXB-C on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HxbHomePageViewModel_dataList.h"

//#import "hx"

@interface HxbHomeRequest_dataList : NSObject

- (void)homeDataListSuccessBlock: (void(^)(NSMutableArray <HxbHomePageViewModel_dataList *>*homeDataListViewModelArray))successDateBlock
                 andFailureBlock: (void(^)(NSError *error))failureBlock;

@end
