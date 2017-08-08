//
//  UIImageView+HxbSDWebImage.m
//  hoomxb
//
//  Created by HXB on 2017/4/14.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "UIImageView+HxbSDWebImage.h"
#import <UIImageView+WebCache.h>
#import "SVGKImage.h"
#import <objc/runtime.h>

static NSString *const kHXBSVGImageName = @"kHXBSVGImageName";
static NSString *const kHXBSVGImage = @"kHXBSVGImage";

@implementation UIImageView (HxbSDWebImage)

- (void)setSvgImageString:(NSString *)svgImageString {
    self.image = [UIImage imageNamed:svgImageString];
    if (self.image == nil) {
        self.image = [SVGKImage imageNamed:svgImageString].UIImage;
    }
    objc_setAssociatedObject(self, &kHXBSVGImageName, svgImageString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)svgImageString {
    return objc_getAssociatedObject(self, &kHXBSVGImageName);
}


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
- (void)hxb_capImageWithName: (NSString *)capImageName {
    UIImage *img = [UIImage imageNamed:capImageName];
    [img stretchableImageWithLeftCapWidth:img.size.width * 0.5 topCapHeight:img.size.height * 0.5];
    self.image = img;
}

- (void)hxb_SVGImageWihtName: (NSString *)svgImageName {
    self.image = [SVGKImage imageNamed:svgImageName].UIImage;
}
@end
