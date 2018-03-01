//
//  HXBAdvertiseViewModel.h
//  hoomxb
//
//  Created by lxz on 2018/1/11.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"

@interface HXBAdvertiseViewModel : HXBBaseViewModel
- (void)requestSplashImages:(void (^)(NSString *imageUrl))resultBlock;
@end
