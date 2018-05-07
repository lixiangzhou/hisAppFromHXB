//
//  HXBUserMigrationViewModel.h
//  hoomxb
//
//  Created by hxb on 2018/5/4.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBLazyCatRequestModel.h"

@interface HXBUserMigrationViewModel : HXBBaseViewModel

@property (nonatomic, strong) HXBLazyCatRequestModel *lazyCatRequestModel;

/**
 懒猫用户激活（迁移）
 */
- (void)requestUserMigrationInfoFinishBlock:(void (^)(BOOL isSuccess))finishBlock;

@end
