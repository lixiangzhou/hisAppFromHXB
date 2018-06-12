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

#define kSplashImageUrlKey @"kSplashImageUrlKey"

@implementation HXBAdvertiseViewModel

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


- (void)getSplashImage:(void (^)(NSString *imageUrl))resultBlock {
    // 显示缓存图片
    NSString *splashImageUrl = [kUserDefaults objectForKey:kSplashImageUrlKey];
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:kSplashImageUrlKey];
    if (image) {
        resultBlock(splashImageUrl);
    } else {
        resultBlock(nil);
    }
    
    [self downloadSplashImageWithCache:splashImageUrl];
}

- (void)downloadSplashImageWithCache:(NSString *)splashImageUrl {
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestUrl = kHXBSplash;
    request.showHud = NO;
    
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        NSString *imageURL = responseObject[kResponseData][@"url"];
        // 不同的URL就更新缓存
        if ([imageURL isEqualToString:splashImageUrl] == NO) {
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imageURL] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                if (image) {
                    [kUserDefaults setObject:imageURL forKey:kSplashImageUrlKey];
                    [kUserDefaults synchronize];
                }
            }];
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
    }];
}

@end
