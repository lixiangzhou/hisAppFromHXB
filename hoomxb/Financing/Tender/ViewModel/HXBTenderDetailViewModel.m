//
//  HXBTenderDetailViewModel.m
//  hoomxb
//
//  Created by lxz on 2018/1/19.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBTenderDetailViewModel.h"

@interface HXBTenderDetailViewModel ()
@property (nonatomic, assign) BOOL isFirstRequest;
@end

@implementation HXBTenderDetailViewModel

- (instancetype)initWithBlock:(HugViewBlock)hugViewBlock
{
    self = [super initWithBlock:hugViewBlock];
    if (self) {
        self.totalCount = @"0";
        self.pageSize = @"20";
        self.isFirstRequest = YES;
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

    NYBaseRequest *req = [[NYBaseRequest alloc] initWithDelegate:self];
    req.showHud = self.isFirstRequest;
    req.requestUrl = kHXBFinanc_PlanInvestList;
    req.requestArgument = @{@"pageSize": self.pageSize,
                            @"page": @(page)};
    
    if (self.isFirstRequest) {
        self.isFirstRequest = NO;
    }
    
    [req loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        NSInteger statusCode = [responseObject[kResponseStatus] integerValue];
        if (statusCode != kHXBCode_Success) {
            NSString *message = responseObject[kResponseMessage];
            [req showToast:message];
        } else {
            NSArray *temp = responseObject[kResponseData][@"dataList"];
            if (temp.count) {
                NSMutableArray *tempModels = [NSMutableArray new];
                for (NSInteger i = 0; i < temp.count; i++) {
                    [tempModels addObject:[HXBTenderDetailModel yy_modelWithDictionary:temp[i]]];
                }
                
                if (isNew) {
                    [self.dataSource removeAllObjects];
                    [self.dataSource addObjectsFromArray:tempModels];
                } else {
                    [self.dataSource addObjectsFromArray:tempModels];
                }
            }
            self.totalCount = responseObject[kResponseData][@"totalCount"];
        }
        completion();
    } failure:^(NYBaseRequest *request, NSError *error) {
        completion();
    }];
}

@end
