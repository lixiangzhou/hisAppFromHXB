//
//  HXBRequestAPI_MYMainCapitalRecordAPI.h
//  hoomxb
//
//  Created by HXB on 2017/5/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "NYBaseRequest.h"

@interface HXBRequestAPI_MYMainCapitalRecordAPI : NYBaseRequest
@property (nonatomic,assign) BOOL isUPData;
///页数
@property (nonatomic,copy) NSString *page;
/// 筛选条件
@property (nonatomic,assign) NSInteger filter;
@end
