//
//  HXBVersionUpdateViewModel.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBVersionUpdateViewModel.h"
#import "HXBVersionUpdateModel.h"
@implementation HXBVersionUpdateViewModel

- (void)setVersionUpdateModel:(HXBVersionUpdateModel *)versionUpdateModel
{
    _versionUpdateModel = versionUpdateModel;
    
    HXBAlertManager *alertManager = [HXBAlertManager alertViewWithTitle:@"更新提示" andMessage:@""];
    
    if ([versionUpdateModel.force isEqualToString:@"0"]) return;
    
    if ([versionUpdateModel.force isEqualToString:@"2"]) {
        [alertManager addButtonWithBtnName:@"取消" andWitHandler:^{
            
        }];
    }
    
    [alertManager addButtonWithBtnName:@"确认" andWitHandler:^{
        NSURL *url = [NSURL URLWithString:versionUpdateModel.url];
        [[UIApplication sharedApplication] openURL:url];
    }];
    
    [alertManager showWithVC:[UIApplication sharedApplication].keyWindow.rootViewController];
    
}





@end
