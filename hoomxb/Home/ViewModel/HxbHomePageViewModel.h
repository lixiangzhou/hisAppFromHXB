//
//  HxbHomePageViewModel.h
//  hoomxb
//
//  Created by HXB-C on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HxbHomePageModel,HXBHomeBaseModel;

@interface HxbHomePageViewModel : NSObject
@property (nonatomic,strong)HxbHomePageModel *homePageModel;
@property (nonatomic,strong) NSString *assetsTotal;

@property (nonatomic, strong) HXBHomeBaseModel *homeBaseModel;

@end
