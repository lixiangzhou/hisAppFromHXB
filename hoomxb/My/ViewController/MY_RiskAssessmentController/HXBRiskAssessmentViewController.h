//
//  HXBRiskAssessmentViewController.h
//  hoomxb
//
//  Created by HXB-C on 2017/7/4.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseWKWebViewController.h"

@interface HXBRiskAssessmentViewController : HXBBaseWKWebViewController

- (void)popWithBlock:(void(^)(NSString *type))popBlock;
@end
