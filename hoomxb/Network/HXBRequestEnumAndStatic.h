//
//  HXBRequestEnumAndStatic.h
//  hoomxb
//
//  Created by HXB on 2017/6/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#pragma mark - 通用接口说

/// ======================= 展示hud 并 判断请求是否成功 =======================
#define kHXBResponsShowHUD if ([responseObject[@"status"] intValue]) {\
if (failureBlock) {\
failureBlock(nil);\
[HxbHUDProgress showTextWithMessage:responseObject[@"message"]];\
return;\
}\
}
/// 请求下来后返回给vc
#define kHXBRespons_returnVCError if ([responseObject[kResponseStatus] integerValue]) {\
    if (failureBlock) {\
        failureBlock(nil,request);\
    }\
}\


#define  kHXBRespons_ShowHUDWithError(view) if (request) {\
    if ((view)){\
        [HxbHUDProgress showMessage:request.responseObject[kResponseMessage] inView:(view)];\
    }else\
        [HxbHUDProgress showMessage:request.responseObject[kResponseMessage]];\
}

//MARK: ======================= 理财资产 界面 =======================
/**计划状态*/
typedef enum : NSUInteger {
    /// 等待预售开始超过30分
    kHXBEnum_Fin_Plan_UnifyStatus_0 = 0,
    ///等待预售开始小于30分钟
    kHXBEnum_Fin_Plan_UnifyStatus_1 = 1,
    ///预定
    kHXBEnum_Fin_Plan_UnifyStatus_2,
    ///预定满额
    kHXBEnum_Fin_Plan_UnifyStatus_3,
    ///等待开放购买大于30分钟
    kHXBEnum_Fin_Plan_UnifyStatus_4,
    ///	等待开放购买小于30分钟 (立即加入)
    kHXBEnum_Fin_Plan_UnifyStatus_5,
    /// 开放加入
    kHXBEnum_Fin_Plan_UnifyStatus_6,
    /// 加入满额
    kHXBEnum_Fin_Plan_UnifyStatus_7,
    ///	收益中
    kHXBEnum_Fin_Plan_UnifyStatus_8,
    ///	开放期
    kHXBEnum_Fin_Plan_UnifyStatus_9,
    ///已退出
    kHXBEnum_Fin_Plan_UnifyStatus_10
} kHXBEnum_Fin_Plan_UnifyStatus;




//MARK: ======================= 用户 =======================






//MARK: ======================= 账户内 =======================


//MARK: ======================= 账户设置 =======================



//MARK: ======================= 充值提现 =======================


@interface HXBRequestEnumAndStatic : NSObject

@end
