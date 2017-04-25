//
//  HXBBaseNavigationController.h
//  hoomxb
//
//  Created by HXB on 2017/4/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBBaseNavigationController : UINavigationController


#pragma mark -自定义 pop & push 按钮


///左边的pop按钮 -- 图片
@property (nonatomic,strong) UIImage *leftBarButtonItemImage;
///左边的pop按钮 -- 文字
@property (nonatomic,copy) NSString *leftBarButtonItemString;
///左边的pop按钮 -- View
@property (nonatomic,strong) UIView *leftBarButtonItemView;


/**
 * 跳转控制器
 * @parma toViewControllerStr跳转到的控制器的name
 * @parma animated 是否支持动画
 */
- (void)popViewControllerWithToViewController: (NSString *)toViewControllerStr andAnimated: (BOOL)animated;
@end
