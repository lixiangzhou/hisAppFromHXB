//
//  HXBBannerViewModel.m
//  hoomxb
//
//  Created by caihongji on 2018/2/5.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBannerViewModel.h"
#import "HXBRequestUserInfoViewModel.h"
#import "HXBUMShareViewModel.h"
#import "BannerModel.h"
#import "HXBUMengShareManager.h"
@implementation HXBBannerViewModel


- (BOOL)isNeedShare {
    
     if ([self.model.share.status isEqualToString:@"link"]) {
     //连接分享
         return YES;
     } else if([self.model.share.status isEqualToString:@"picture"]){
     //图片分享
         return YES;
     } else if([self.model.share.status isEqualToString:@"none"]){
     //不分享
         return NO;
     }
    return NO;
}

- (void)share {
    //连接分享
    HXBUMShareViewModel *shareViewModel = [[HXBUMShareViewModel alloc] init];
    shareViewModel.shareModel = self.model.share;
    [HXBUMengShareManager showShareMenuViewInWindowWith:shareViewModel];
}

@end
