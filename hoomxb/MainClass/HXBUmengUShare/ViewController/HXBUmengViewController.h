//
//  HXBUmengViewController.h
//  hoomxb
//
//  Created by HXB-C on 2017/11/13.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBUMShareViewModel;

typedef NS_ENUM(NSUInteger, HXBShareType) {
    HXBShareTypeWebPage,
    HXBShareTypeImage,
};

@interface HXBUmengViewController : UIViewController
/**
 分享的类型
 */
@property (nonatomic, assign) HXBShareType shareType;
/**
 分享的数据
 */
@property (nonatomic, strong) HXBUMShareViewModel *shareVM;
/**
 展示分享视图
 */
- (void)showShareView;

@end
