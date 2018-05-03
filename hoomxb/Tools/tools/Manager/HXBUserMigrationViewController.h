//
//  HXBUserMigrationViewController.h
//  hoomxb
//
//  Created by hxb on 2018/5/2.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"

@interface HXBUserMigrationViewController : UIViewController

/**
 是否需要内部自动dismiss,默认是YES内部自动帮你释放
 */
@property (nonatomic, assign) BOOL isAutomaticDismiss;
/**
 subTitle描述是否居中
 */
@property (nonatomic, assign) BOOL isCenterShow;//默认居中


@end
