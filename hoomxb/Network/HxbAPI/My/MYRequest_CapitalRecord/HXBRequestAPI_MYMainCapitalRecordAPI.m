//
//  HXBRequestAPI_MYMainCapitalRecordAPI.m
//  hoomxb
//
//  Created by HXB on 2017/5/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRequestAPI_MYMainCapitalRecordAPI.h"

@implementation HXBRequestAPI_MYMainCapitalRecordAPI
- (NSString *)requestUrl {
//    return [NSString stringWithFormat:@"/account/plan/%@/loanRecord?page=%@",self.planID,self.page];
    return [NSString stringWithFormat:@"/account/tradlist?page=%@&filter=%@",self.page,@(self.filter)];
//    return @"/account/tradlist";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodGet;
}
@end
