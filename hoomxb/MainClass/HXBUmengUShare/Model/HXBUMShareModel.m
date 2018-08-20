//
//  HXBUMShareModel.m
//  hoomxb
//
//  Created by HXB-C on 2017/11/15.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBUMShareModel.h"

@implementation HXBUMShareModel

- (NSString *)status {
    if (!_status.length) {
        //设置默认值是因为购买结果页面没有这个数据字段
        _status = @"link";
    }
    return _status;
}

@end
