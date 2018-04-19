//
//  HXBMY_LoanTruansferModel.m
//  hoomxb
//
//  Created by HXB on 2017/8/1.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_LoanTruansferModel.h"

@implementation HXBMY_LoanTruansferModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"creatTruansAmount" : @"initTransAmount"};
}
@end
