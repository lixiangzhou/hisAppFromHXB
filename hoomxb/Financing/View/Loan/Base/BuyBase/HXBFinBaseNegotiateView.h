//
//  HXBFinBaseNegotiateView.h
//  hoomxb
//
//  Created by HXB on 2017/7/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
///协议的view
@interface HXBFinBaseNegotiateView : UIView

///点击了协议
- (void)clickNegotiateWithBlock:(void(^)())clickNegotiateBlock;
///点击了对勾，
- (void)clickCheckMarkWithBlock:(void(^)(BOOL isSelected))clickCheckMarkBlock;
@property (nonatomic,copy) NSString *negotiateStr;
@end
