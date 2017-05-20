//
//  HXBMYViewModel_MainCapitalRecortdDetailViewModel.h
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXBMYModel_CapitalRecordDetailModel;

///关于资金统计的 详情页 的ViewModel
@interface HXBMYViewModel_MainCapitalRecortdDetailViewModel : NSObject
///资金统计的Model
@property (nonatomic,strong) HXBMYModel_CapitalRecordDetailModel *capitalRecordDetailModel;
@end
