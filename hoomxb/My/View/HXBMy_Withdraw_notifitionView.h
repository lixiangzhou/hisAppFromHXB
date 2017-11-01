//
//  HXBMy_Withdraw_notifitionView.h
//  hoomxb
//
//  Created by 肖扬 on 2017/9/21.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickMessgae)(void);

@interface HXBMy_Withdraw_notifitionView : UIView

/** 消息个数 */
@property (nonatomic, copy)  NSString *messageCount;
/**
 富文本形式
 */
@property (nonatomic, copy) NSAttributedString *attributedMessageCount;
/** 点击消息 */
@property (nonatomic, copy)  clickMessgae block;

@end
