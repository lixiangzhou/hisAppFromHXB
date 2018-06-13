//
//  HXBAdvertiseViewModel.m
//  hoomxb
//
//  Created by lxz on 2018/1/11.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBAdvertiseViewModel.h"
#import "SDImageCache.h"
#import "SDWebImageDownloader.h"

#define kSplashDataKey @"kSplashDataKey"

@implementation HXBAdvertiseViewModel

- (BOOL)hasSplashData {
    return [kUserDefaults objectForKey:kSplashDataKey];
}

- (void)requestSplashImages:(void (^)(NSString *imageUrl))resultBlock {
    // 无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
    NYBaseRequest *splashTRequest = [[NYBaseRequest alloc] initWithDelegate:self];
    splashTRequest.requestUrl = kHXBSplash;
    splashTRequest.showHud = NO;
    
    [splashTRequest loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        NSString *imageURL = responseObject[kResponseData][@"url"];
        if (resultBlock) {
            resultBlock(imageURL);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) {
            resultBlock(nil);
        }
    }];
}


- (void)getSplashImage:(void (^)(BOOL isSuccess))resultBlock {
    // 显示缓存图片
    NSDictionary *splashData = [kUserDefaults objectForKey:kSplashDataKey];
    NSString *imageUrl = splashData[@"image"];
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imageUrl];
    if (image) {
        resultBlock(YES);
    } else {
        resultBlock(NO);
    }

    [self downloadSplashImageWithCache:splashData];
}

- (void)downloadSplashImageWithCache:(NSDictionary *)splashData {
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestUrl = kHXBSplash;
    request.showHud = NO;
    
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        NSDictionary *data = responseObject[kResponseData];
        NSString *imageURL = data[@"image"];
        NSString *oldImageURL = splashData[@"image"];
        // 不同的URL就更新缓存
        if ([imageURL isEqualToString:oldImageURL] == NO) {
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imageURL] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:nil];
        }
        
        [kUserDefaults setObject:data forKey:kSplashDataKey];
        [kUserDefaults synchronize];
    } failure:^(NYBaseRequest *request, NSError *error) {
    }];
}

     
@end
