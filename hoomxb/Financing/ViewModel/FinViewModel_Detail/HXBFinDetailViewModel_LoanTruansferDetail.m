//
//  HXBFinDetailViewModel_LoanTruansferDetail.m
//  hoomxb
//
//  Created by HXB on 2017/7/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinDetailViewModel_LoanTruansferDetail.h"

@implementation HXBFinDetailViewModel_LoanTruansferDetail
/**
 状态
 */
- (NSString *) status_UI {
    if (!_status_UI) {
        _status_UI = [HXBEnumerateTransitionManager Fin_LoanTruansfer_StatusWith_request:self.status];
    }
    return _status_UI;
}
/**
 状态
 */
- (NSString *) status {
    if (!_status) {
        _status = self.loanTruansferDetailModel.status;
    }
    return _status;
}
@end
