//
//  HXBMYViewModel_MainLoanViewModel.h
//  hoomxb
//
//  Created by HXB on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBRequestType_MYManager.h"
@class HXBMyModel_MainLoanModel;

///我的 loan ViewModel
@interface HXBMYViewModel_MainLoanViewModel : NSObject
@property (nonatomic,strong) HXBMyModel_MainLoanModel *loanModel;
///请求的类型
@property (nonatomic,assign) HXBRequestType_MY_LoanRequestType requestType;
///相应的类型
@property (nonatomic,copy) NSString *responsStatus;
@end
