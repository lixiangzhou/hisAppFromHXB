//
//  HXBAdvertisementManager.h
//  hoomxb
//
//  Created by HXB on 2017/5/25.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
///imageName
static NSString *const adImageName;
///广告管理
@interface HXBAdvertisementManager : NSObject

///下载广告图片
+ (void)downLoadAdvertisementImageWithadvertisementImageURLStr:(NSString *) advertisementImageURLStr andDownLoadBlock: (void(^)(NSString *imagePath))downLoadBlock;
///广告图片路径的获取
+ (UIImage *)getAdvertisementImagePath;
@end
