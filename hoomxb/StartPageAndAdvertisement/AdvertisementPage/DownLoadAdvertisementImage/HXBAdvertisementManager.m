//
//  HXBAdvertisementManager.m
//  hoomxb
//
//  Created by HXB on 2017/5/25.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBAdvertisementManager.h"
#define kHXBUserDefaults [NSUserDefaults standardUserDefaults]

static NSString *const adImageName = @"adImageName";

@implementation HXBAdvertisementManager

///下载广告图片
+ (void)downLoadAdvertisementImageWithadvertisementImageURLStr:(NSString *) advertisementImageURLStr andDownLoadBlock: (void(^)(NSString *imagePath))downLoadBlock
{
    if (!advertisementImageURLStr) {
        // TODO 请求广告接口
        NSArray *imageArray = @[@"https://a-ssl.duitang.com/uploads/item/201505/31/20150531222441_kVZXU.jpeg", @"https://a-ssl.duitang.com/uploads/item/201505/31/20150531222425_zFKGY.thumb.700_0.jpeg", @"https://a-ssl.duitang.com/uploads/item/201505/31/20150531222413_ak25z.thumb.700_0.jpeg", @"https://a-ssl.duitang.com/uploads/item/201604/06/20160406172034_TVkJs.thumb.700_0.jpeg"];
//        NSString *imageUrl = imageArray[arc4random() % imageArray.count];
        NSString *imageUrl = imageArray[1];
        
        advertisementImageURLStr = imageUrl;
    }
    [self getAdvertisingImageWithImageURL:advertisementImageURLStr andDownLoadBlock:downLoadBlock];
    
}

+ (void)getAdvertisingImageWithImageURL: (NSString *)imageUrl andDownLoadBlock: (void(^)(NSString *imagePath))downLoadBlock
{
    // 获取图片名:43-130P5122Z60-50.jpg
    NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
    NSString *imageName = stringArr.lastObject;
    
    // 拼接沙盒路径
    NSString *filePath = [HxbFileManager getFilePathWithImageName:imageName];
    BOOL isExist = [HxbFileManager isFileExistWithFilePath:filePath];
    // 如果该图片存在，则直接返回这个地址
    if (isExist){
        downLoadBlock(filePath);
        return;
    }
    // 如果该图片不存在，则删除老图片，下载新图片
    [self downloadAdImageWithUrl:imageUrl imageName:imageName andDownLoadBlock:downLoadBlock];
}

/**
 *  下载新图片
 */
+ (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName andDownLoadBlock: (void(^)(NSString *imagePath))downLoadBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        
        NSString *filePath = [HxbFileManager getFilePathWithImageName:adImageName]; // 保存文件的名称
        
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES])
        {// 保存成功
            NSLog(@"保存成功");
            [self deleteOldImage];
            [kUserDefaults setValue:imageName forKey:adImageName];
            [kUserDefaults synchronize];
            // 如果有广告链接，将广告链接也保存下来
            if (downLoadBlock) {
                downLoadBlock(filePath);
            }
        }else{
            if (downLoadBlock) {
                downLoadBlock(nil);
            }
            NSLog(@"保存失败");
        }
        
    });
}

/**
 *  删除旧图片
 */
+ (void)deleteOldImage
{
    NSString *imageName = [kUserDefaults valueForKey:adImageName];
    if (imageName) {
        NSString *filePath = [HxbFileManager getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

///广告图片路径的获取
+ (UIImage *)getAdvertisementImagePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:adImageName];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    return image;
}
@end
