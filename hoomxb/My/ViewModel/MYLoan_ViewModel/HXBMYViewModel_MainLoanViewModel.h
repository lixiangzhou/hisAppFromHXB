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

/// 返回的type （投标中，收益中）
typedef enum : NSInteger{
    ///收益中
    HXBRequestType_MY_LoanResponsType_XYRZ,
    ///投标中
    HXBRequestType_MY_LoanResponsType_SDRZ
}HXBRequestType_MY_LoanResponsType;


//MARK: 账户内 散标 枚举
typedef enum : NSUInteger {
    ///收益中
    HXBRequestType_MY_LoanRequestType_REPAYING_LOAN = 1,
    ///投标中
    HXBRequestType_MY_LoanRequestType_BID_LOAN,
    ///已结清
    HXBRequestType_MY_LoanRequestType_FINISH_LOAN
}HXBRequestType_MY_LoanRequestType;


//MARK: ----- request loan -------
///已结清
static NSString *const HXBRequestType_MY_FINISH_LOAN = @"FINISH_LOAN";
///已结清的UI 显示
static NSString *const HXBRequestType_MY_FINISH_LOAN_UI = @"已结清";
///收益中
static NSString *const HXBRequestType_MY_REPAYING_LOAN = @"REPAYING_LOAN";
///收益中的UI显示
static NSString *const HXBRequestType_MY_REPAYING_LOAN_UI = @"收益中";
///投标中
static NSString *const HXBRequestType_MY_BID_LOAN = @"BID_LOAN";
///投标中的UI显示
static NSString *const HXBRequestType_MY_BID_LOAN_UI = @"投标中";

//MARK: loan 列表页 返回的type
///我的账户内散标（收益中）
static NSString *const HXBRequestType_MY_XYRZ_Loan = @"XYRZ";
///我的账户内散标（投标中）
static NSString *const HXBRequestType_MY_SDRZ_Loan = @"SDRZ";




///我的 loan ViewModel
@interface HXBMYViewModel_MainLoanViewModel : NSObject

@property (nonatomic,strong) HXBMyModel_MainLoanModel *loanModel;
///请求的类型
@property (nonatomic,assign) HXBRequestType_MY_LoanResponsType responsType;
///请求的类型
@property (nonatomic,assign) HXBRequestType_MY_LoanRequestType requestType;
///相应的类型
@property (nonatomic,copy) NSString *responsStatus;


/// 根据枚举值返回对应的请求参数字符串 ———— 我的Loan界面
+ (HXBRequestType_MY_LoanRequestType)myLoan_RequestTypeStr: (NSString *)typeStr;

/**
 *  根据枚举值返回对应的请求参数字符串 ———— 我的Loan主界面
 *  type 是程序表示， UI_Type是UI显示表示
 */
+ (void)myLoan_requestType: (HXBRequestType_MY_LoanRequestType)type andReturnParamBlock: (void(^)(NSString *type, NSString *UI_Type))returnParamBlock;

///根据loan  返回的type （投标中，收益中）的类型，生成枚举类型
+ (HXBRequestType_MY_LoanResponsType)myLoan_ResponsType: (NSString *)responsType;
@end




