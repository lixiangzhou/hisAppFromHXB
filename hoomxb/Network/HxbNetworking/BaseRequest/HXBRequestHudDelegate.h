//
//  HXBRequestHudDelegate.h
//  hoomxb
//
//  Created by lxz on 2017/12/5.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HXBRequestHudDelegate <NSObject>
- (void)showProgress;
- (void)showToast:(NSString *)toast;
- (void)hideProgress;
@end
