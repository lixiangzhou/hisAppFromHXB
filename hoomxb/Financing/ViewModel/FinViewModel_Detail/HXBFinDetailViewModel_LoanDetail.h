//
//  HXBFinDetailViewModel_LoanDetail.h
//  hoomxb
//
//  Created by HXB on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBFinDatailModel_LoanDetail.h"
@class HXBFin_Detail_DetailVC_LoanManager;
///散标投递的详情页的ViewModel
@interface HXBFinDetailViewModel_LoanDetail : NSObject
@property (nonatomic,strong) HXBFinDatailModel_LoanDetail *loanDetailModel;
/**
 已还期数 4/ 12
 */
@property (nonatomic,copy) NSString *loanPeriodStr;

/**
 status 标的状态
 */
@property (nonatomic,copy) NSString * status;
/**
 string	剩余可投金额
 */
@property (nonatomic,copy) NSString *surplusAmount;
/**
 剩余可投：为0时或状态为已满标、收益中时，字段变为标的金额
 */
@property (nonatomic,copy) NSString *surplusAmount_ConstStr;

///左边的月数
@property (nonatomic,copy) NSString *leftMonths;
/**
 标的期限
 */
@property (nonatomic,copy) NSString *months;

///收益方法
@property (nonatomic,copy) NSString *loanType;
/// ￥1000起投，1000递增 placeholder
@property (nonatomic,copy) NSString *addCondition;
///加入上线
@property (nonatomic,copy) NSString *unRepaid;
///预计收益 在 加入计划的 view 内部计算
@property (nonatomic,copy) NSString *totalInterestPer100;
///服务协议 button str
@property (nonatomic,copy) NSString *agreementTitle;
/**
 标的期限
 */
@property (nonatomic,copy) NSString * lockPeriodStr;
/**
 ///确认加入的Buttonstr
 */
@property (nonatomic,copy) NSString * addButtonStr;

/**
 addButton是否可以点击
 */
@property (nonatomic,assign) BOOL isAddButtonEditing;
/// 加入按钮的颜色
@property (nonatomic,strong) UIColor *addButtonBackgroundColor;
///加入按钮的字体颜色
@property (nonatomic,strong) UIColor *addButtonTitleColor;
///addbutton 边缘的颜色
@property (nonatomic,strong) UIColor *addButtonBorderColor;

/**
 剩余时间
 */
@property (nonatomic,copy) NSString *remainTime;
/**
  URL赋予协议
 */
//@property (nonatomic,copy) NSString *agreementURL;


// MARK ----- 标的详情-- 详情
/**
 身份证号
 */
@property (nonatomic,copy) NSString *idNo;
/**
 名字
 */
@property (nonatomic,copy) NSString * name;
/**
 婚姻状态
 */
@property (nonatomic,copy) NSString *marriageStatus;
/**
 年龄
 */
@property (nonatomic,copy) NSString * age;

/**
 月收入
 */
@property (nonatomic,copy) NSString * monthlyIncome;

/**
房产
*/
@property (nonatomic,copy) NSString *hasHouse;
/**
 房贷
 */
@property (nonatomic,copy) NSString *hasHouseLoan;
/**
 是否有 车贷
 */
@property (nonatomic,copy) NSString *hasCar;
/**
 是否有 车贷
 */
@property (nonatomic,copy) NSString *hasCarLoan;
/**
 学历
 */
@property (nonatomic,copy) NSString *university;
/**
 籍贯
 */
@property (nonatomic,copy) NSString *homeTown;
///@"公司类别：",
@property (nonatomic,copy) NSString *companyCategory;
///@"职位：",
@property (nonatomic,copy) NSString *companyPost;
///@"工作行业：",
@property (nonatomic,copy) NSString *companyIndustry;
///@"工作城市："
@property (nonatomic,copy) NSString *companyLocation;
@property (nonatomic,strong) HXBFin_Detail_DetailVC_LoanManager *fin_LoanInfoView_Manager;
@end
