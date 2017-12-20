//
//  MacrosInBusiness.h
//  TR7TreesV3
//
//  Created by hoomsun on 16/6/16.
//  Copyright © 2016年 hoomsun. All rights reserved.
//

#ifndef MacrosInBusiness_h
#define MacrosInBusiness_h

// 标的状态
typedef NS_ENUM(NSInteger, ProductStatus) {
    kProductStatusCreated,  //!< 已创建
    kProductStatusCollecting,   //!<筹款中
    kProductStatusRepaying,     //!<还款中
    kProductStatusSelledOut,    //!<已售罄
    kProductStatusAborted,      //!<流标
    kProductStatusRepayed,      //!<已还款
    kProductStatusRemoved       //!<撤标
    
};
// 红利的状态
typedef NS_ENUM(NSInteger, PlanStatus) {
    kPlanStatusCreated,  //!< 已创建
    kPlanStatusCollecting,   //!<筹款中
    kPlanStatusRepaying,     //!<收益中
    kPlanStatusSoldOut,      //!<已满额
    kPlanStatusFailed,       //!<流标
    kPlanStatusRepaid,       //!<已退出
    kPlanStatusRemoved,       //!<撤标
    kPlanStatusRepaidAHead,  //提前还款
    kPlanStatusExiting         //退出中
};
//# 加入中、已满额、收益中、退出中，已退出
//PLAN_STATUS = {
//# CREATED: '已创建',
//COLLECTING: '加入中',
//SOLD_OUT: '已满额',
//REPAYING: '收益中',
//REPAID: '已退出',
//# FAILED: '流标',
//# REMOVED: '撤标',
//# REPAID_AHEAD: '提前还款',
//EXITING: '退出中',
//    
//}
//CREATED = 0
//COLLECTING = 1
//SOLD_OUT = 3
//REPAYING = 2
//REPAID = 5
//FAILED = 4
//REMOVED = 6
//REPAID_AHEAD = 7
//EXITING = 8


// 标的分类
typedef NS_ENUM(NSInteger, ProductCategory) {
    kProductCategoryHignQualityDebt,
    kProductCategoryCarDebt,
    kProductCategoryPlanning,
    kProductCategoryRegularFinancial
};
typedef NS_ENUM(NSInteger, PayResultCategory) {
    kFail,                              //!< 支付失败
    kSuccess,                           //!< 成功
    kWaitting,                          //!< 等待
    kCancel                             //!< 取消
    
};
typedef NS_ENUM(NSInteger, TopUpResultCategory) {
    kTopUpWaitting,                     //!< 等待
    kTopUpSuccess,                      //!< 成功
    kTopUpFail,                         //!< 支付失败
};
typedef enum {
    FreeTarget = 0,
    CessionOfClaim,
    PlanProduct
}ProductType;
//颜色
//#define BACKGROUNDCOLOR [UIColor colorWithRed:247/255.0f green:248/255.0f blue:249/255.0f alpha:1]
#define BACKGROUNDCOLOR [UIColor colorWithRed:245/255.0f green:245/255.0f blue:249/255.0f alpha:1]
#define DETAIL_TEXT_COLOR [[UIColor alloc]initWithRed:131/255.0f green:131/255.0f blue:131/255.0f alpha:1]
#define BACKITEM_COLOR  [UIColor colorWithRed:131/255.0f green:131/255.0f blue:131/255.0f alpha:1]
#define TITLE_COLOR [UIColor colorWithRed:57/255.0f green:57/255.0f blue:57/255.0f alpha:1]

// trade record
#define ADD_COLOR [[UIColor alloc]initWithRed:55/255.0f green:167/255.0f blue:91/255.0f alpha:1]
#define LESS_COLOR [[UIColor alloc]initWithRed:146/255.0f green:0 blue:0 alpha:1]

//
//主色调
#define MAIN_THEME_COLOR [UIColor colorWithRed:251/255.0f green:91/255.0f blue:91/255.0f alpha:1]
//蓝色主色调
#define MAIN_THEME_BULECOLOR [UIColor colorWithRed:0/255.0f green:180/255.0f blue:255/255.0f alpha:1]
//黑色字体主色调
#define MAIN_THEME_TEXTCOLOR [UIColor colorWithRed:57/255.0f green:57/255.0f blue:57/255.0f alpha:1]
//灰色线条色调
#define GrayLineColor COR13
//#define AssetNaviBarColor 

#define kWindow   [UIApplication sharedApplication].keyWindow

//一般的业务常量
#define CusSerTel                       @"400-1552-888"


/**
 (0 -> Product | 1 -> Develop)Fuiou Pay
*/

#if 1
#define    MchntCD     @"0002900F0096235"
#define    PayKey      @"5old71wihg2tqjug9kkpxnhx9hiujoqj"
#define    isPayTest   1
//Develop
#else
#define    MchntCD     @"0002900F0286298"
#define    PayKey      @"6807d6d98f3533636eb117e6028a5c31"
#define    isPayTest   0
//Product
#endif


#endif /* MacrosInBusiness_h */
