//
//  HXBUserMigrationViewController.h
//  hoomxb
//
//  Created by hxb on 2018/5/2.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"
typedef void(^pushClick)();
@interface HXBUserMigrationViewController : UIViewController
@property (nonatomic, copy) pushClick pushBlock;
@end
