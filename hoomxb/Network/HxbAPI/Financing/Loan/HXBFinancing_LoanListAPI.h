//
//  HXBFinancing_LoanListAPI.h
//  hoomxb
//
//  Created by HXB on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "NYBaseRequest.h"

///升序
static NSString *const HXBFin_LoanListOrder_ASC;
///降序
static NSString *const HXBFin_LoanListOrder_DESC;
///升序降序 的枚举
typedef enum : NSUInteger {
    ///升序
    HXBFin_LoanListOrder_TYPE_ASC,
    ///降序
    HXBFin_LoanListOrder_TYPE_DESC
} HXBFin_LoanListOrder_TYPE;


@interface HXBFinancing_LoanListAPI : NYBaseRequest
///是否为上拉刷新
@property (nonatomic,assign) BOOL isUPData;
///page 从1 开始，
@property (nonatomic,assign) NSInteger loanPage;
@end
