//
//  HXBUmengView.h
//  hoomxb
//
//  Created by HXB-C on 2017/11/13.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UShareUI/UShareUI.h>
@interface HXBUmengView : UIView

/**
 点击按钮回调
 */
@property (nonatomic, copy) void (^shareWebPageToPlatformType)(UMSocialPlatformType type);

@end
