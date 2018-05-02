//
//  HXBLazyCatRequestModel.m
//  hoomxb
//
//  Created by caihongji on 2018/4/19.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBLazyCatRequestModel.h"

@implementation HXBLazyCatRequestModel

- (NSString *)serviceName {
    return _serviceName? _serviceName:@"";
}

- (NSString *)platformNo {
    return _platformNo?_platformNo:@"";
}

- (NSString *)reqData {
    return _reqData?_reqData:@"";
}

- (NSString *)sign {
    return _sign?_sign:@"";
}

- (NSString *)url {
    return _url?_url:@"";
}
@end
