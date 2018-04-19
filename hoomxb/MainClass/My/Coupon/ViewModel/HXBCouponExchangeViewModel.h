//
//  HXBCouponExchangeViewModel.h
//  hoomxb
//
//  Created by lxz on 2018/2/7.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBMyCouponListModel.h"

@interface HXBCouponExchangeViewModel : HXBBaseViewModel
@property (nonatomic, strong) HXBMyCouponListModel *couponListModel;
@property (nonatomic, copy) NSString *promptMessage;

- (void)downLoadMyCouponExchangeInfoHUDWithCode:(NSString *)code completion:(void (^)(BOOL isSuccess))completion;
@end
