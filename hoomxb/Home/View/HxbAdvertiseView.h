//
//  HxbAdvertiseView.h
//  hoomxb
//
//  Created by HXB-C on 2017/4/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *const adImageName = @"adImageName";
static NSString *const adUrl = @"adUrl";
@interface HxbAdvertiseView : UIView
/** 图片路径*/
@property (nonatomic, copy) NSString *filePath;

/** 显示广告页面方法*/
- (void)show;
@end
