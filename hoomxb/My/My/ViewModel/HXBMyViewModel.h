//
//  HXBMyViewModel.h
//  hoomxb
//
//  Created by lxz on 2018/2/7.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBMyRequestAccountModel.h"

@interface HXBMyViewModel : HXBBaseViewModel
@property (nonatomic, strong) HXBMyRequestAccountModel *accountModel;

- (void)downLoadAccountInfo:(void (^)(BOOL isSuccess))completion;
@end
