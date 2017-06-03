//
//  NSString+HXBPhonNumber.h
//  hoomxb
//
//  Created by HXB on 2017/6/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
///隐藏了手机号码中的中间字段
@interface NSString (HXBPhonNumber)
///隐藏了手机号码中的中间字段
- (NSString *) hxb_hiddenPhonNumberWithMid;
@end
