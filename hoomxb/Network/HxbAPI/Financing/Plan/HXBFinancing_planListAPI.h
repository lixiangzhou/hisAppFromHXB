//
//  HXBFinancing_planList.h
//  hoomxb
//
//  Created by HXB on 2017/5/6.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "NYBaseRequest.h"
///红利计划列表 的api
@interface HXBFinancing_planListAPI : NYBaseRequest
///是否为上拉刷新
@property (nonatomic,assign) BOOL isUPData;

///页数 从1开始
@property (nonatomic,assign) NSInteger planPage;
@end
