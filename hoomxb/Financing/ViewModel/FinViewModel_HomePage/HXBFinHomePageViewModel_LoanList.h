//
//  HXBFinHomePageViewModel_LoanList.h
//  hoomxb
//
//  Created by HXB on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXBFinHomePageModel_LoanList;

/// -信用认证标
static NSString *const kHXBFinHomePageModel_LoanList_certificateType_XYRZ = @"XYRZ";
/// -实地认证标
static NSString *const kHXBFinHomePageModel_LoanList_certificateType_SDRZ = @"SDRZ";
/// -机构担保标
static NSString *const kHXBFinHomePageModel_LoanList_certificateType_JGDB = @"JGDB";
/// -智能理财标
static NSString *const kHXBFinHomePageModel_LoanList_certificateType_ZNLC = @"ZNLC";

/**信用认证*/
typedef enum : NSUInteger {
    ///-信用认证标、
    HXBFinHomePageModel_LoanList_certificateType_XYRZ,
    ///-实地认证标、
    HXBFinHomePageModel_LoanList_certificateType_SDRZ,
    ///-机构担保标、
    HXBFinHomePageModel_LoanList_certificateType_JGDB,
    ///-智能理财标
    HXBFinHomePageModel_LoanList_certificateType_ZNLC,
} HXBFinHomePageModel_LoanList_certificateType;



///散标列表页- 一级界面ViewModel
@interface HXBFinHomePageViewModel_LoanList : NSObject
@property (nonatomic,strong) HXBFinHomePageModel_LoanList *loanListModel;
///状态
@property (nonatomic,copy) NSString *status;
///年计划利率
@property (nonatomic,copy) NSAttributedString *expectedYearRateAttributedStr;
/// 加入按钮的颜色
@property (nonatomic,strong) UIColor *addButtonBackgroundColor;
///加入按钮的字体颜色
@property (nonatomic,strong) UIColor *addButtonTitleColor;
///addbutton 边缘的颜色
@property (nonatomic,strong) UIColor *addButtonBorderColor;
@end
