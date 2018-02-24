//
//  HXBCallPhone_BottomView.h
//  hoomxb
//
//  Created by HXB-C on 2017/8/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBCallPhone_BottomView : UIView

/**
 左边的提示文字
 */
@property (nonatomic, copy) NSString *leftTitle;

/**
 PhoneNumber
 */
@property (nonatomic, copy) NSString *phoneNumber;

/**
 补充说明
 */
@property (nonatomic, copy) NSString *supplementText;

@end
