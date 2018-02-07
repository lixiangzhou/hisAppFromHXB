//
//  HXBOpenDepositAccountVCViewModel.m
//  hoomxb
//
//  Created by HXB-C on 2018/2/7.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBOpenDepositAccountVCViewModel.h"

@implementation HXBOpenDepositAccountVCViewModel

- (void)openDepositAccountRequestWithArgument:(NSDictionary *)requestArgument andCallBack:(void(^)(BOOL isSuccess))callBackBlock
{
    NYBaseRequest *versionUpdateAPI = [[NYBaseRequest alloc] init];
    versionUpdateAPI.requestUrl = kHXBOpenDepositAccount_Escrow;
    versionUpdateAPI.requestMethod = NYRequestMethodPost;
    versionUpdateAPI.requestArgument = requestArgument;
    [versionUpdateAPI loadData:^(NYBaseRequest *request, id responseObject) {
        
        NSInteger status =  [responseObject[@"status"] integerValue];
        if (status == kHXBOpenAccount_Outnumber) {
            NSString *string = [NSString stringWithFormat:@"您今日开通存管错误次数已超限，请明日再试。如有疑问可联系客服 %@", kServiceMobile];
            
            HXBGeneralAlertVC *alertVC = [[HXBGeneralAlertVC alloc] initWithMessageTitle:@"" andSubTitle:string andLeftBtnName:@"取消" andRightBtnName:@"联系客服" isHideCancelBtn:YES isClickedBackgroundDiss:NO];
            alertVC.isCenterShow = YES;
            [alertVC setRightBtnBlock:^{
                NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", kServiceMobile];
                NSComparisonResult compare = [[UIDevice currentDevice].systemVersion compare:@"10.0" options:NSNumericSearch];
                if (compare == NSOrderedDescending || compare == NSOrderedSame) {
                    /// 大于等于10.0系统使用此openURL方法
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
                } else {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
                }
            }];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:NO completion:nil];
            return;
        }
        if (status != 0) {
            if (callBackBlock) {
                callBackBlock(NO);
            }
            if (status == 1) {
                [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
            }
            return;
        }
        if (callBackBlock) {
            callBackBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (callBackBlock) {
            callBackBlock(NO);
        }
    }];
    
}



@end
