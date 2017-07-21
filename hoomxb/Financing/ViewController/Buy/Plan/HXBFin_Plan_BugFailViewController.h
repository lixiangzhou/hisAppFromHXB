//
//  HXBFin_Plan_BugFailViewController.h
//  hoomxb
//
//  Created by HXB on 2017/6/28.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"
////购买失败VC
@interface HXBFin_Plan_BugFailViewController : HXBBaseViewController
///image
@property (nonatomic,copy) NSString *image;
///信息的字符串
@property (nonatomic,copy) NSString *massage;
///购买失败
@property (nonatomic,copy) NSString *failLabelStr;
@property (nonatomic,copy) NSString *buttonStr;

- (void)clickButtonWithBlcok: (void(^)(UIButton *button))clickButtonBlcok;
@end
