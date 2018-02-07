//
//  HXBCouponListViewModel.h
//  hoomxb
//
//  Created by lxz on 2018/2/7.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBMyCouponListModel.h"

@interface HXBCouponListViewModel : HXBBaseViewModel

@property (nonatomic, strong) NSMutableArray <HXBMyCouponListModel *>*appendCouponList;

- (void)downLoadMyAccountListInfoHUDWithParameterDict:(NSDictionary *)parameterDict completion:(void (^)(BOOL isSuccess))completion;
@end
