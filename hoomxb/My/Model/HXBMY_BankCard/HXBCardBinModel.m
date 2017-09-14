//
//  HXBCardBinModel.m
//  hoomxb
//
//  Created by HXB-C on 2017/9/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBCardBinModel.h"

@implementation HXBCardBinModel


- (void)setCardType:(NSString *)cardType
{
    _cardType = cardType;
    if ([cardType isEqualToString:@"debit"]) {
        self.isDebit = YES;
    }else
    {
        self.isDebit = NO;
    }
}
@end
