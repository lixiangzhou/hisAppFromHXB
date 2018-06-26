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
#import "BannerModel.h"

#define kSplashDataKey @"kSplashDataKey"

@interface HXBAdvertiseManager ()
@property (nonatomic, assign, readwrite) BOOL requestSuccess;
@property (nonatomic, strong) BannerModel *bannerModel;
@property (nonatomic, assign) BOOL requestCompleted;
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

- (void)getSplash {
    // 请求闪屏数据
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:nil];
    request.requestUrl = kHXBSplash;
    
    kWeakSelf
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        weakSelf.requestSuccess = YES;
        [weakSelf cacheResponse:responseObject];
        weakSelf.requestCompleted = YES;
    } failure:^(NYBaseRequest *request, NSError *error) {
        weakSelf.requestSuccess = NO;
        weakSelf.requestCompleted = YES;
    }];
}

/// 缓存闪屏数据
- (void)cacheResponse:(NSDictionary *)responseObject {
    NSDictionary *data = responseObject[kResponseData];
    NSString *imageURL = data[@"image"];
    
    NSString *oldImageURL = [self getCacheData][@"image"];
    
    kWeakSelf
    // 不同的URL就更新缓存，相同就检查有没有缓存成功，没有缓存成功就重新缓存
    if ([imageURL isEqualToString:oldImageURL]) {
        UIImage *cachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imageURL];
        if (cachedImage == nil) {
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imageURL] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                weakSelf.advertieseImage = image;
            }];
        } else {
            weakSelf.advertieseImage = cachedImage;
        }
    } else {
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imageURL] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            weakSelf.advertieseImage = image;
        }];
    }
    
    [kUserDefaults setObject:data forKey:kSplashDataKey];
    [kUserDefaults synchronize];
    
    self.bannerModel = [BannerModel yy_modelWithDictionary:data];
}

- (NSDictionary *)getCacheData {
    return [kUserDefaults objectForKey:kSplashDataKey];
}
@end
