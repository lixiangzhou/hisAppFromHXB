//
//  HXBHomeTitleModel.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBHomeTitleModel.h"

@implementation HXBHomeTitleModel

- (void)setBaseTitle:(NSString *)baseTitle {
    _baseTitle = baseTitle;
    KeyChain.baseTitle = baseTitle;
}
@end
