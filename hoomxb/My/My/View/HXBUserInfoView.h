//
//  HXBUserInfoView.h
//  hoomxb
//
//  Created by HXB-C on 2017/7/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBUserInfoView : UIView

@property (nonatomic, strong) NSArray *leftStrArr;

@property (nonatomic, strong) NSArray *rightArr;

/**
 点击协议回调
 */
@property (nonatomic, copy) void(^agreementBlock)();

@end
