//
//  HXBMYViewModel_MainCapitalRecordViewModel.h
//  hoomxb
//
//  Created by HXB on 2017/5/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "NYBaseRequest.h"
@class HXBMYModel_CapitalRecordDetailModel;
///关于资金列表的ViewModel
@interface HXBMYViewModel_MainCapitalRecordViewModel : NSObject
@property (nonatomic,strong) HXBMYModel_CapitalRecordDetailModel *capitalRecordModel;
///账户余额
@property (nonatomic,copy) NSString *balance;
///时间
@property (nonatomic,copy) NSString *time;
///支出
@property (nonatomic,copy) NSString *pay;
@end


