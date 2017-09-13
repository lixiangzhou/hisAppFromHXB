//
//  HxbHomePageViewModel_dataList.h
//  hoomxb
//
//  Created by HXB-C on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HxbHomePageModel_DataList.h"
@interface HxbHomePageViewModel_dataList : NSObject
@property (nonatomic, strong) HxbHomePageModel_DataList *homePageModel_DataList;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *lockPeriod;
@property (nonatomic, strong) NSString *expectedYearRate;
@property (nonatomic, strong) NSString *status;

@end
