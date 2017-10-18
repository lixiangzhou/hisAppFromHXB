//
//  HxbFileManager.h
//  hoomxb
//
//  Created by HXB-C on 2017/4/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HxbFileManager : NSObject

+ (BOOL)isFileExistWithFilePath:(NSString *)filePath;
+ (NSString *)getFilePathWithImageName:(NSString *)imageName;

@end
