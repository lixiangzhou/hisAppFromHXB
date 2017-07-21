//
//  HXBFinModel_AddRecortdModel_LoanTruansfer.m
//  hoomxb
//
//  Created by HXB on 2017/7/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinModel_AddRecortdModel_LoanTruansfer.h"

@implementation HXBFinModel_AddRecortdModel_LoanTruansfer
- (void)setUserName:(NSString *)userName {
    _userName = userName;
}
- (NSString *)userName_Hidden {
    if (!_userName_Hidden) {
        _userName_Hidden = [NSString hiddenStr:self.userName MidWithFistLenth:3 andLastLenth:2];
    }
    return _userName_Hidden;
}
- (NSString *)principal_YUAN {
    if (!_principal_YUAN) {
        _principal_YUAN = [NSString hxb_getPerMilWithDouble:self.principal.floatValue];
    }
    return _principal_YUAN;
}
@end
