//
//  HXBAdvertiseManager.m
//  hoomxb
//
//  Created by lxz on 2018/6/13.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBAdvertiseManager.h"
#import "SDImageCache.h"
#import "SDWebImageDownloader.h"

#define kSplashDataKey @"kSplashDataKey"

@interface HXBAdvertiseManager ()
@property (nonatomic, assign, readwrite) BOOL canShow;
@end

@implementation HXBAdvertiseManager
+ (instancetype)shared {
    static HXBAdvertiseManager *mgr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [HXBAdvertiseManager new];
    });
    return mgr;
}

- (void)getSplashImage {
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:nil];
    request.requestUrl = kHXBSplash;
    
    kWeakSelf
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        weakSelf.canShow = YES;
        [weakSelf cacheResponse:responseObject];
    } failure:^(NYBaseRequest *request, NSError *error) {
        weakSelf.canShow = NO;
    }];
}

- (void)cacheResponse:(NSDictionary *)responseObject {
    NSDictionary *data = responseObject[kResponseData];
    NSString *imageURL = data[@"image"];
    
    NSString *oldImageURL = [self getCacheData][@"image"];
    // 不同的URL就更新缓存
    if ([imageURL isEqualToString:oldImageURL] == NO) {
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imageURL] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:nil];
    } else {
        if ([[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imageURL] == NO) {
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imageURL] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:nil];
        }
    }
    
    [kUserDefaults setObject:data forKey:kSplashDataKey];
    [kUserDefaults synchronize];

}

- (NSDictionary *)getCacheData {
    return [kUserDefaults objectForKey:kSplashDataKey];
}
@end
