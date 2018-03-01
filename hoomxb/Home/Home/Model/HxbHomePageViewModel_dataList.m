//
//  HxbHomePageViewModel_dataList.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbHomePageViewModel_dataList.h"

@implementation HxbHomePageViewModel_dataList
- (void)setHomePageModel_DataList:(HxbHomePageModel_DataList *)homePageModel_DataList{
    _homePageModel_DataList = homePageModel_DataList;
    _name = homePageModel_DataList.name;
}
@end
