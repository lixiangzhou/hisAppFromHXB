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
    if ([versionUpdateModel.force isEqualToString:@"0"]) return;
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"更新提示" message:versionUpdateModel.updateinfo preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:versionUpdateModel.url];
        [[UIApplication sharedApplication] openURL:url];
    }];
    [alertController addAction:okAction];
    if ([versionUpdateModel.force isEqualToString:@"2"]) {
        UIAlertAction *cancalAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertController addAction:cancalAction];
    }
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}





@end
