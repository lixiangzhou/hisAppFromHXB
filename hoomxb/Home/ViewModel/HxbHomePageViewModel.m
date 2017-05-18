//
//  HxbHomePageViewModel.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbHomePageViewModel.h"

@implementation HxbHomePageViewModel
- (void)setHomePageModel:(HxbHomePageModel *)homePageModel{
    _homePageModel = homePageModel;
    _assetsTotal = [NSString stringWithFormat:@"%@",@(homePageModel.assetsTotal)];
    
}

@end
