//
//  HXBFinDetailModel_LoanDetail.h
//  hoomxb
//
//  Created by HXB on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
///散标详情Model
@interface HXBFinDetailModel_LoanDetail : NSObject
@property (nonatomic,copy) NSString *joinCount;
@property (nonatomic,copy) NSString *loanLenderRecord_list;
@property (nonatomic,copy) NSString *myJoinCount;
@end

///散标详情列表Model中的的信息列表
@interface HXBFinDetailModel_LoanDetail_loanLenderRecord_list : NSObject
///量
@property (nonatomic,copy) NSString *amount;
///
@property (nonatomic,copy) NSString *index;
///贷款贷款人类型
@property (nonatomic,copy) NSString *loanLenderType;
@property (nonatomic,copy) NSString *username;
///借出时间
@property (nonatomic,copy) NSString *lendTime;
@property (nonatomic,copy) NSString *type;
@end

/**
{
    "data": {
        "joinCount": 1,
        "loanLenderRecord_list": [
                                  {
                                      "amount": 50000,
                                      "index": 1,
                                      "loanLenderType": "NORMAL_BID",
                                      "username": "HXB2458528",
                                      "lendTime": "1451985509000",
                                      "type": "ALL"
                                  }
                                  ],
        "myJoinCount": 0
    },
    "message": "success",
    "status": 0
}
*/
