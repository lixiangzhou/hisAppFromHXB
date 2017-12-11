//
//  HXBGesturePasswordViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/20.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBGesturePasswordViewController.h"
#import "HXBCircleView.h"
#import "HXBCircleViewConst.h"
#import "HXBLockLabel.h"
#import "HXBCircle.h"
#import "HXBRootVCManager.h"
#import "HxbMyAccountSecurityViewController.h"

@interface HXBGesturePasswordViewController ()<HXBCircleViewDelegate, UIGestureRecognizerDelegate>
/**
 *  重设按钮
 */
@property (nonatomic, strong) UIButton *resetBtn;
/**
 *  提示Title
 */
@property (nonatomic, strong) UILabel *titleLabel;
/**
 *  提示Title
 */
@property (nonatomic, strong) UILabel *phoneLabel;
/**
 *  提示Label
 */
@property (nonatomic, strong) HXBLockLabel *msgLabel;

/**
 *  解锁界面
 */
@property (nonatomic, strong) HXBCircleView *lockView;

@end

@implementation HXBGesturePasswordViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:CircleViewBackgroundColor];
    
    // 1.界面相同部分生成器
    [self setupSameUI];
    
    // 2.界面不同部分生成器
    [self setupDifferentUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 禁用全屏滑动手势
    ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = NO;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.isHiddenNavigationBar = YES;
    
    if (self.type == GestureViewControllerTypeSetting) {
        [self alertSkipSetting];
    }
}


#pragma mark - UI
/// 界面相同部分生成器
- (void)setupSameUI
{
    // 解锁界面
    HXBCircleView *lockView = [[HXBCircleView alloc] init];
    lockView.delegate = self;
    lockView.arrow = NO;
    lockView.isDisplayTrajectory = YES;
    self.lockView = lockView;
    [self.view addSubview:lockView];

    HXBLockLabel *msgLabel = [[HXBLockLabel alloc] init];
    msgLabel.frame = CGRectMake(0, 0, kScreenW, 14);
    msgLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
    self.msgLabel = msgLabel;
    [self.view addSubview:msgLabel];
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.resetBtn];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.offset(kScrAdaptationH(82));
    }];
    
    [self.resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(kScrAdaptationH(-70));
        make.centerX.equalTo(self.view);
        make.height.offset(kScrAdaptationH(15));
        make.width.offset(kScrAdaptationW(74));
    }];
}

/// 界面不同部分生成器
- (void)setupDifferentUI
{
    switch (self.type) {
        case GestureViewControllerTypeSetting:
            [self setupSubViewsSettingVc];
            break;
        case GestureViewControllerTypeLogin:
            [self setupSubViewsLoginVc];
            break;
        default:
            break;
    }
}

/// 设置手势密码界面
- (void)setupSubViewsSettingVc
{
    self.title = @"设置手势密码";
    self.isWhiteColourGradientNavigationBar = YES;
    
    [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kScrAdaptationH(10));
    }];
    
    [self.lockView setType:CircleViewTypeSetting];
    
    self.titleLabel.text = gestureTextBeforeSet;
    [self.msgLabel showNormalMsg:gestureTextConnectLess];
}

/// 登陆手势密码界面
- (void)setupSubViewsLoginVc
{
    self.titleLabel.text = @"您好";
    [self.lockView setType:CircleViewTypeLogin];
    
    // 手机号
    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.text = [KeyChain.mobile replaceStringWithStartLocation:3 lenght:4];
    phoneLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
    phoneLabel.textColor = RGB(51, 51, 51);
    self.phoneLabel = phoneLabel;
    [self.view addSubview:self.phoneLabel];
    
    // 管理手势密码
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self creatButton:leftBtn frame:CGRectMake(CircleViewEdgeMargin + 20, kScreenH - 60, kScreenW/2, 20) title:@"账号密码登录" alignment:UIControlContentHorizontalAlignmentCenter tag:buttonTagManager];
    
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(kScrAdaptationH(-70));
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kScrAdaptationH(10));
        make.height.offset(kScrAdaptationH(16));
    }];
    
    [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.phoneLabel.mas_bottom).offset(kScrAdaptationH(10));
    }];

}

#pragma mark - Action
- (void)didClickBtn:(UIButton *)sender
{
    NSLog(@"%ld", (long)sender.tag);
    switch (sender.tag) {
        case buttonTagReset:
        {
            NSLog(@"点击了重设按钮");
            self.title = @"设置手势密码";
            // 1.隐藏按钮
            [self.resetBtn setHidden:YES];
            
            // 3.msgLabel提示文字复位
            [self.msgLabel showNormalMsg:gestureTextConnectLess];
            self.titleLabel.text = gestureTextBeforeSet;
            // 4.清除之前存储的密码
//            [HXBCircleViewConst saveGesture:nil Key:gestureOneSaveKey];
//            KeyChain.gesturePwd = nil;
            [self.lockView resetGesturePassword];
        }
            break;
        case buttonTagManager:
        {
            NSLog(@"点击了账户密码登录");
            [KeyChain signOut];
            [[HXBRootVCManager manager] makeTabbarRootVC];
            [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
        }
            break;
        case buttonTagForget:
            NSLog(@"点击了登录其他账户按钮");
            
            break;
        default:
            break;
    }
}

#pragma mark - circleView - delegate
#pragma mark - circleView - delegate - setting
- (void)circleView:(HXBCircleView *)view type:(CircleViewType)type connectCirclesLessThanNeedWithGesture:(NSString *)gesture
{
    NSString *gestureOne = gesture;
    
    // 看是否存在第一个密码
    if ([gestureOne length] > CircleSetCountLeast) {
        [self.resetBtn setHidden:NO];
        [self.msgLabel showWarnMsgAndShake:gestureTextDrawAgainError];
    } else {
        NSLog(@"密码长度不合法%@", gesture);
        [self.msgLabel showWarnMsgAndShake:gestureTextConnectLess];
    }
}

- (void)circleView:(HXBCircleView *)view type:(CircleViewType)type didCompleteSetFirstGesture:(NSString *)gesture
{
    NSLog(@"获得第一个手势密码%@", gesture);
    
    self.title = @"确认手势密码";
    self.titleLabel.text = gestureTextDrawAgain;
    [self.resetBtn setHidden:NO];
    
    [self.msgLabel showWarnMsg:gestureTextDrawAgain];
}

- (void)circleView:(HXBCircleView *)view type:(CircleViewType)type didCompleteSetSecondGesture:(NSString *)gesture result:(BOOL)equal
{
    NSLog(@"获得第二个手势密码%@",gesture);
    
    if (equal) {
        
        NSLog(@"两次手势匹配！可以进行本地化保存了");
        [self.msgLabel showWarnMsg:gestureTextSetSuccess];
        KeyChain.gesturePwd = gesture;
        KeyChain.gesturePwdCount = @"5";
        [kUserDefaults setBool:YES forKey:kHXBGesturePWD];
        
        __block UIViewController *popToVC = nil;
        [self.navigationController.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[HxbMyAccountSecurityViewController class]]) {
                [kUserDefaults setBool:NO forKey:kHXBGesturePwdSkipeKey];
                [kUserDefaults synchronize];
                popToVC = obj;
                *stop = YES;
            }
        }];
        
        if (popToVC && self.switchType == HXBAccountSecureSwitchTypeOn) {
            [self.navigationController popToViewController:popToVC animated:YES];
        } else {
            [self.navigationController popToRootViewControllerAnimated:NO];
        }
        
    } else {
        NSLog(@"两次手势不匹配！");
        [self.msgLabel showWarnMsgAndShake:gestureTextDrawAgainError];
        [self.resetBtn setHidden:NO];
    }
}

#pragma mark - circleView - delegate - login or verify gesture
- (void)circleView:(HXBCircleView *)view type:(CircleViewType)type didCompleteLoginGesture:(NSString *)gesture result:(BOOL)equal
{
    // 此时的type有两种情况 Login or verify
    if (type == CircleViewTypeLogin) {
        
        if (equal) {
            NSLog(@"登陆成功！");
            KeyChain.gesturePwdCount = @"5";
            [[HXBRootVCManager manager] makeTabbarRootVC];
        } else {
           
            
            NSLog(@"密码错误！");
            int cout = [KeyChain.gesturePwdCount intValue];
            cout--;
            KeyChain.gesturePwdCount = [NSString stringWithFormat:@"%d",cout];
            if (cout <= 0) {
                
                HXBXYAlertViewController *alertVC = [[HXBXYAlertViewController alloc] initWithTitle:@"温馨提示" Massage:@"很抱歉，您的手势密码五次输入错误" force:2 andLeftButtonMassage:@"取消" andRightButtonMassage:@"确定"];
                alertVC.isCenterShow = YES;
                [alertVC setClickXYRightButtonBlock:^{
                    [KeyChain signOut];
                    [[HXBRootVCManager manager] makeTabbarRootVC];
                    [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:@{kHXBMY_VersionUpdateURL : @YES}];
                }];
                [alertVC setClickXYLeftButtonBlock:^{
                    [KeyChain signOut];
                    [[HXBRootVCManager manager] makeTabbarRootVC];
                }];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
                return;
            }
            [self.msgLabel showWarnMsgAndShake:[NSString stringWithFormat:@"密码错了，还可输入%@次", KeyChain.gesturePwdCount]];
        }
    } else if (type == CircleViewTypeVerify) {
        
        if (equal) {
            NSLog(@"验证成功，跳转到设置手势界面");
            
        } else {
            NSLog(@"原手势密码输入错误！");
            
        }
    }
}

#pragma mark - Helper
- (void)alertSkipSetting {
    // 忽略手势密码弹窗提示
    BOOL appeared = [kUserDefaults boolForKey:kHXBGesturePwdSkipeAppeardKey];
    if (appeared == NO) {
        // 只出现一次弹窗
        [kUserDefaults setBool:YES forKey:kHXBGesturePwdSkipeAppeardKey];
        [kUserDefaults synchronize];
        // 弹窗
        HXBXYAlertViewController *alertVC = [[HXBXYAlertViewController alloc] initWithTitle:@"" Massage:@"为了您的账户安全，\n建议您设置手势密码" force:2 andLeftButtonMassage:@"跳过设置" andRightButtonMassage:@"开始设置"];
        alertVC.clickXYLeftButtonBlock = ^{ // 跳过设置
            [kUserDefaults setBool:YES forKey:kHXBGesturePwdSkipeKey];
            [kUserDefaults synchronize];
            
            [[HXBRootVCManager manager] makeTabbarRootVC];
        };
        
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}

- (void)creatButton:(UIButton *)btn frame:(CGRect)frame title:(NSString *)title alignment:(UIControlContentHorizontalAlignment)alignment tag:(NSInteger)tag
{
    btn.frame = frame;
    btn.tag = tag;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setContentHorizontalAlignment:alignment];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font =kHXBFont_PINGFANGSC_REGULAR(15);
    [btn setTitleColor:RGB(115, 173, 255) forState:UIControlStateNormal];
    [self.view addSubview:btn];
}

#pragma mark - Lazy
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(19);
        _titleLabel.textColor = rgba(51, 51, 51, 1.0);
    }
    return _titleLabel;
}

- (UIButton *)resetBtn
{
    if (!_resetBtn) {
        _resetBtn = [[UIButton alloc] init];
        [_resetBtn setTitle:@"重新绘制" forState:UIControlStateNormal];
        [_resetBtn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        _resetBtn.titleLabel.font =kHXBFont_PINGFANGSC_REGULAR(15);
        _resetBtn.tag = buttonTagReset;
        [_resetBtn setHidden:YES];
        [_resetBtn setTitleColor:RGB(115, 173, 255) forState:UIControlStateNormal];
    }
    return _resetBtn;
}
@end
