//
//  HXBTenderDetailViewModel.h
//  hoomxb
//
//  Created by lxz on 2018/1/19.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBTenderDetailModel.h"

@interface HXBTenderDetailViewModel : HXBBaseViewModel
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, assign) BOOL showNoMoreData;
@property (nonatomic, assign) BOOL showPullup;

- (void)getData:(BOOL)isNew completion:(void(^)(BOOL))completion;
@end
