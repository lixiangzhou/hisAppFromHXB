//
//  HXBExtensionMethodTool.h
//  hoomxb
//
//  Created by HXB-C on 2018/6/13.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BannerModel;
@interface HXBExtensionMethodTool : NSObject
+ (void)pushToViewControllerWithModel:(BannerModel *)model andWithFromVC:(HXBBaseViewController *)comeFromVC;
@end
