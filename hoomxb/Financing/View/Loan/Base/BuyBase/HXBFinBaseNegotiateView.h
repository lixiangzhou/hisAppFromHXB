//
//  HXBFinBaseNegotiateView.h
//  hoomxb
//
//  Created by HXB on 2017/7/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickDelegate)(NSInteger  type);

///协议的view
@interface HXBFinBaseNegotiateView : UIView

///点击了协议
- (void)clickNegotiateWithBlock:(void(^)())clickNegotiateBlock;
///点击了对勾，
- (void)clickCheckMarkWithBlock:(void(^)(BOOL isSelected))clickCheckMarkBlock;
@property (nonatomic,copy) NSString *negotiateStr;
/** 对有两个协议的单独处理 */
@property (nonatomic, copy) NSString *type;
/** 点击协议的方法 */
@property (nonatomic, copy) clickDelegate block;

@end

