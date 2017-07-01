//
//  HxbHUDProgress.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbHUDProgress.h"
@interface HxbHUDProgress () <MBProgressHUDDelegate>
@property (strong, nonatomic) MBProgressHUD *HUD;
@property (assign, nonatomic)int  mTime;
//@property (nonatomic, strong) ToastAnimationView *animtionView;
@end


@implementation HxbHUDProgress
{
    NSTimer *timer;
}
+ (void)showTextWithMessage:(NSString *)message{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:keyWindow];
    [keyWindow addSubview:HUD];
    HUD.removeFromSuperViewOnHide = YES;
        NSString *text = message;
        HUD.detailsLabel.text = text;
        HUD.detailsLabel.font = [UIFont systemFontOfSize:16];
        HUD.mode = MBProgressHUDModeText;
        
        int sec = text.length > 6? 2:1;
    
        [HUD showAnimated:YES whileExecutingBlock:^{
            sleep(sec);
        } completionBlock:^{
            [HUD removeFromSuperview];
        }];
}

+ (void)errorWithErrorCode:(NSInteger)errorCode{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:keyWindow];
    HUD.removeFromSuperViewOnHide = YES;
    [keyWindow addSubview:HUD];
    if (errorCode == 401) {
        NSString *text = @"验证失效,请您重新刷新";
        HUD.detailsLabel.text = text;
        HUD.detailsLabel.font = [UIFont systemFontOfSize:16];
        HUD.mode = MBProgressHUDModeText;
        
        int sec = text.length > 6? 2:1;
        
        [HUD showAnimated:YES whileExecutingBlock:^{
            sleep(sec);
        } completionBlock:^{
            [HUD removeFromSuperview];
        }];
    }
}

+ (void)errorWithErrorCode:(int )errorCode message:(NSString *)message{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithWindow:keyWindow];
    HUD.removeFromSuperViewOnHide = YES;
    [keyWindow addSubview:HUD];
        NSString *text = message;
        HUD.detailsLabelText = text;
        HUD.detailsLabelFont = [UIFont systemFontOfSize:16];
        HUD.mode = MBProgressHUDModeText;
        
        int sec = text.length > 6? 2:1;
        
        [HUD showAnimated:YES whileExecutingBlock:^{
            sleep(sec);
        } completionBlock:^{
            [HUD removeFromSuperview];
        }];
 
}

- (void)showAnimation
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    _HUD = [[MBProgressHUD alloc]initWithView:keyWindow];
    _HUD.removeFromSuperViewOnHide = YES;
    [keyWindow addSubview:_HUD];
    _HUD.delegate = self;//添加代理
    _HUD.mode = MBProgressHUDModeIndeterminate;
    [_HUD showAnimated:YES];
}

- (void)showAnimationWithText:(NSString *)text
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    _HUD = [[MBProgressHUD alloc]initWithView:keyWindow];
    _HUD.removeFromSuperViewOnHide = YES;
    [keyWindow addSubview:_HUD];
    _HUD.label.text = text;
    _HUD.delegate = self;//添加代理
    
    [_HUD showAnimated:YES];
    self.mTime =0;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:30];
    timer.fireDate = [NSDate distantPast];
    
}

-(void)timerFired:(NSTimer *)time{
    
    self.mTime++;
    
    if (self.mTime >= 12) {
        timer.fireDate = [NSDate distantFuture];
        [self hide];
    }
}

-(void)hide
{
    _HUD.removeFromSuperViewOnHide = YES;
    [_HUD hideAnimated:YES];
    if (timer) {
        timer.fireDate = [NSDate distantFuture];
    }
}

#pragma mark MBProgressHUD代理方法
-(void)hudWasHidden:(MBProgressHUD *)hud
{
    [_HUD removeFromSuperview];
    if (_HUD != nil) {
        _HUD = nil;
    }
}

/**
 自定义HUD加载
 */
+ (void)showLoadDataHUD:(UIView *)showView{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (showView == nil) {
        showView = keyWindow;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:showView animated:YES];
    //    hud.backgroundColor = [UIColor colorWithRed:125/255.0f green:125/255.0f blue:125/255.0f alpha:1.f];
    hud.bezelView.backgroundColor = [UIColor colorWithRed:125/255.0f green:125/255.0f blue:125/255.0f alpha:1.f];
    hud.label.text = NSLocalizedString(@"加载中...", @"HUD loading title");
    hud.label.textColor = [UIColor whiteColor];
    hud.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    //加载完成
    //    [hud hideAnimated:YES];
}

+ (void)hidenHUD:(UIView *)hidenView
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (hidenView == nil) {
        hidenView = keyWindow;
    }
    [MBProgressHUD hideHUDForView:hidenView animated:YES];
}

/**
// 自定义HUD
// */
//- (void)customViewExampleWithView:(UIView *)view andImage: (UIImage *) {
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//    
//    // Set the custom view mode to show any view.
//    hud.mode = MBProgressHUDModeCustomView;
//    // Set an image view with a checkmark.
//    UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    hud.customView = [[UIImageView alloc] initWithImage:image];
//    // Looks a bit nicer if we make it square.
//    hud.square = YES;
//    // Optional label text.
//    hud.label.text = NSLocalizedString(@"Done", @"HUD done title");
//    
//    [hud hideAnimated:YES afterDelay:3.f];
//}

/**
 带有label的HUD
 */
//- (void)labelExample {
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//    hud.bezelView.backgroundColor = [UIColor colorWithRed:125/255.0f green:125/255.0f blue:125/255.0f alpha:1.f];
//    hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
//    hud.label.textColor = [UIColor whiteColor];
//    
//    //加载完成
//    //    [hud hideAnimated:YES];
//}
@end
