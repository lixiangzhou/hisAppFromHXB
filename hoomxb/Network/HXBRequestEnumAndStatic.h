//
//  HXBRequestEnumAndStatic.h
//  hoomxb
//
//  Created by HXB on 2017/6/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
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



//MARK: ======================= 理财资产 界面 =======================





//MARK: ======================= 用户 =======================






//MARK: ======================= 账户内 =======================


//MARK: ======================= 账户设置 =======================



//MARK: ======================= 充值提现 =======================


@interface HXBRequestEnumAndStatic : NSObject

@end
