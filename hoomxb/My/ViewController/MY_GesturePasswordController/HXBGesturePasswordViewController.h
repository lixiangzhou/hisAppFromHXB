//
//  HXBGesturePasswordViewController.h
//  hoomxb
//
//  Created by HXB-C on 2017/6/20.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"
typedef enum{
    GestureViewControllerTypeSetting = 1,
    GestureViewControllerTypeLogin
}GestureViewControllerType;

typedef enum{
    buttonTagReset = 1,
    buttonTagManager,
    buttonTagForget
    
}buttonTag;
@interface HXBGesturePasswordViewController : HXBBaseViewController

/**
 *  控制器来源类型
 */
@property (nonatomic, assign) GestureViewControllerType type;

@end
