//
//  HXBVersionUpdateModel.h
//  hoomxb
//
//  Created by HXB-C on 2017/7/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBVersionUpdateModel : NSObject

/**
 更新代码，0：已是最高版本；1：强制更新；2：非强制更新
 */
@property (nonatomic, copy) NSString *force;

/**
 更新提示文案
 */
@property (nonatomic, copy) NSString *updateinfo;
/**
 app的名称
 */
@property (nonatomic, copy) NSString *appname;
/**
 app更新下载地址
 */
@property (nonatomic, copy) NSString *url;
/**
 app版本号
 */
@property (nonatomic, copy) NSString *versionCode;
@end
