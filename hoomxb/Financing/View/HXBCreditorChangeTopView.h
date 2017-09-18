//
//  HXBCreditorChangeTopView.h
//  hoomxb
//
//  Created by 肖扬 on 2017/9/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^buyBlock)();
typedef void(^textfieldDidChange)(NSString *text);

@interface HXBCreditorChangeTopView : UIView

/** 待转让金额 */
@property (nonatomic, copy) NSString * creditorMoney;
/** 一键购买金额 */
@property (nonatomic, copy) NSString * totalMoney;
/** 占位符 */
@property (nonatomic, copy) NSString * placeholderStr;
/** buyBlock */
@property (nonatomic, copy) buyBlock block;
/** buyBlock */
@property (nonatomic, copy) textfieldDidChange changeBlock;

@end
