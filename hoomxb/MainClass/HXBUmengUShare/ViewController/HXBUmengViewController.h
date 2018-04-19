//
//  HXBUmengViewController.h
//  hoomxb
//
//  Created by HXB-C on 2017/11/13.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBUMShareViewModel;
@interface HXBUmengViewController : UIViewController

/**
 分享的数据
 */
@property (nonatomic, strong) HXBUMShareViewModel *shareVM;
/**
 展示分享视图
 */
- (void)showShareView;

@end
