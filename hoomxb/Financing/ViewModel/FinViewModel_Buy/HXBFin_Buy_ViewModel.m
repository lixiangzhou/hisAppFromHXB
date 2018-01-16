//
//  HXBFin_Buy_ViewModel.m
//  hoomxb
//
//  Created by 肖扬 on 2017/9/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_Buy_ViewModel.h"

@implementation HXBFin_Buy_ViewModel

+ (void)requestForBankCardSuccessBlock:(successModelBlock)successDateBlock {
    NYBaseRequest *bankCardAPI = [[NYBaseRequest alloc] init];
    bankCardAPI.requestUrl = kHXBUserInfo_BankCard;
    bankCardAPI.requestMethod = NYRequestMethodGet;
    [bankCardAPI startWithHUDStr:@"加载中..." Success:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
        NSInteger status =  [responseObject[@"status"] integerValue];
        if (status != 0) {
            kHXBBuyErrorResponsShowHUD
        }
        HXBBankCardModel *bankCardModel = [HXBBankCardModel yy_modelWithJSON:responseObject[@"data"]];
        successDateBlock(bankCardModel);
    } failure:^(NYBaseRequest *request, NSError *error) {
        NSLog(@"%@",error);
        successDateBlock(nil);
        [HxbHUDProgress showTextWithMessage:@"银行卡请求失败"];
    }];

}

@end
