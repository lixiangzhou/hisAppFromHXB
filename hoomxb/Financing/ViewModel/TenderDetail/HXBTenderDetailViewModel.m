//
//  HXBTenderDetailViewModel.m
//  hoomxb
//
//  Created by lxz on 2018/1/19.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBTenderDetailViewModel.h"

@implementation HXBTenderDetailViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.totalCount = @"0";
        self.pageSize = @"20";
    }
    return self;
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)getData:(BOOL)isNew completion:(void (^)())completion {
    NSInteger page = 1;
    if (isNew == NO) {
        page = ceil(self.dataSource.count * 1.0 / self.pageSize.integerValue);
        if (self.dataSource.count < self.totalCount.integerValue) {
            page++;
        }
        page = MAX(page, 1);
    }

    NYBaseRequest *req = [NYBaseRequest new];
    req.requestUrl = kHXBFinanc_PlanInvestList;
    req.requestArgument = @{@"pageSize": self.pageSize,
                            @"page": @(page)};
    kWeakSelf
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        completion();
    });
    
//    [req startWithSuccess:^(NYBaseRequest *request, NSDictionary *responseObject) {
//        NSInteger statusCode = [responseObject[kResponseStatus] integerValue];
//        if (statusCode != kHXBCode_Success) {
//            NSString *message = responseObject[kResponseMessage];
//            [HxbHUDProgress showTextWithMessage:message andView:weakSelf.view];
//        } else {
//            self.totalCount = responseObject[kResponseData][@"totalCount"];
//        }
//        completion();
//    } failure:^(NYBaseRequest *request, NSError *error) {
//        completion();
//    }];
}

@end
