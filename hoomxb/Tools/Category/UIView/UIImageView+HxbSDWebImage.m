//
//  UIImageView+HxbSDWebImage.m
//  hoomxb
//
//  Created by HXB on 2017/4/14.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "UIImageView+HxbSDWebImage.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (HxbSDWebImage)
- (void)hxb_downloadImage:(NSString *)urlStr placeholder:(NSString *)imageName {
    
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:imageName] options:SDWebImageRetryFailed|SDWebImageLowPriority];
}

- (void)hxb_downloadImage:(NSString *)urlStr placeholder:(NSString *)imageName success:(void(^)(UIImage *image))downImageSuccessBlock failed:(void(^)(NSError *error))downImageFailedBlock progress:(void(^)(CGFloat progress))downImageProgressBlock {
    
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:imageName] options:SDWebImageRetryFailed|SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        downImageProgressBlock(receivedSize * 1.0 / expectedSize);
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (error) {
            downImageFailedBlock(error);
        } else {
            self.image = image;
            downImageSuccessBlock(image);
        }
        
    }];
}
//MARK: 切图
+ (instancetype)hxb_capImageWithName: (NSString *)capImageName {
    UIImage *img = [UIImage imageNamed:capImageName];
    [img stretchableImageWithLeftCapWidth:img.size.width * 0.5 topCapHeight:img.size.height * 0.5];
    return img;
}
@end
