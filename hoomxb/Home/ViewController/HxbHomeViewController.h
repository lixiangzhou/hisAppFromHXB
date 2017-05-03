//
//  HxbHomeViewController.h
//  hoomxb
//
//  Created by HXB-C on 2017/4/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"
#import "BannerModel.h"

@interface HxbHomeViewController : HXBBaseViewController

- (void)showBannerWebViewWithURL:(NSString *)linkUrl;
- (void)showBannerWebViewWithModel:(BannerModel *)model;

@end
