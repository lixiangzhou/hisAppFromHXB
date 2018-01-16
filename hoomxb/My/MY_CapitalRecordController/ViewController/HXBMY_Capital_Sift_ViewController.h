//
//  HXBMY_Capital_Sift_ViewController.h
//  hoomxb
//
//  Created by HXB on 2017/6/28.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"


@interface HXBMY_Capital_Sift_ViewController : HXBBaseViewController
/**
 点击了筛选的类型进行回调
 */
- (void)clickCapital_TitleWithBlock: (void(^)(NSString *typeStr,kHXBEnum_MY_CapitalRecord_Type type))clickCapital_TitleBlock;
@end
