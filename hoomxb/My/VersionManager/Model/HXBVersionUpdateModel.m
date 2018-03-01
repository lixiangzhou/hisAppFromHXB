//
//  HXBVersionUpdateModel.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBVersionUpdateModel.h"

@implementation HXBVersionUpdateModel


- (void)setH5host:(NSString *)h5host
{
    KeyChain.h5host = h5host;
    _h5host = h5host;
}

@end
