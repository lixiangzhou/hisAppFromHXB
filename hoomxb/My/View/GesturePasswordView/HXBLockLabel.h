//
//  HXBLockLabel.h
//  hoomxb
//
//  Created by HXB-C on 2017/6/20.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBLockLabel : UILabel
/*
 *  普通提示信息
 */
-(void)showNormalMsg:(NSString *)msg;


/*
 *  警示信息
 */
-(void)showWarnMsg:(NSString *)msg;

/*
 *  警示信息(shake)
 */
-(void)showWarnMsgAndShake:(NSString *)msg;

@end
