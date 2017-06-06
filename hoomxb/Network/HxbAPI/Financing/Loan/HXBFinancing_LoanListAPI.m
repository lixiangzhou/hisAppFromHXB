//
//  HXBFinancing_LoanListAPI.m
//  hoomxb
//
//  Created by HXB on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinancing_LoanListAPI.h"
///升序
static NSString *const HXBFin_LoanListOrder_ASC = @"ASC";
///降序
static NSString *const HXBFin_LoanListOrder_DESC = @"DESC";
@implementation HXBFinancing_LoanListAPI
//192.168.1.21:3000/lend/loanindex 散标列表 POST   散标list、

- (NSInteger) loanPage {
    if (!_loanPage) {
        _loanPage = 1;
    }
    return _loanPage;
}

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"/loan?page=%ld",self.loanPage];
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodGet;
}

//- (id)requestArgument {
//    return @{};
//}

@end
