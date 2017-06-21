//
//  HXBModifyGesturePasswordController.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/20.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBModifyGesturePasswordController.h"
#import "HXBCircleViewConst.h"
#import "HXBCircleView.h"
#import "HXBLockLabel.h"
#import "HXBGesturePasswordViewController.h"
@interface HXBModifyGesturePasswordController ()<HXBCircleViewDelegate>

/**
 *  文字提示Label
 */
@property (nonatomic, strong) HXBLockLabel *msgLabel;

@end

@implementation HXBModifyGesturePasswordController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:CircleViewBackgroundColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"验证手势解锁";
    
    HXBCircleView *lockView = [[HXBCircleView alloc] init];
    lockView.delegate = self;
    [lockView setType:CircleViewTypeVerify];
    [self.view addSubview:lockView];
    
    HXBLockLabel *msgLabel = [[HXBLockLabel alloc] init];
    msgLabel.frame = CGRectMake(0, 0, kScreenW, 14);
    msgLabel.center = CGPointMake(kScreenW/2, CGRectGetMinY(lockView.frame) - 30);
    [msgLabel showNormalMsg:gestureTextOldGesture];
    self.msgLabel = msgLabel;
    [self.view addSubview:msgLabel];
}

#pragma mark - login or verify gesture
- (void)circleView:(HXBCircleView *)view type:(CircleViewType)type didCompleteLoginGesture:(NSString *)gesture result:(BOOL)equal
{
    if (type == CircleViewTypeVerify) {
        
        if (equal) {
            NSLog(@"验证成功");
            [KeyChain removeGesture];
            HXBGesturePasswordViewController *gestureVc = [[HXBGesturePasswordViewController alloc] init];
            [gestureVc setType:GestureViewControllerTypeSetting];
            [self.navigationController pushViewController:gestureVc animated:YES];
            
        } else {
            NSLog(@"密码错误！");
            [self.msgLabel showWarnMsgAndShake:gestureTextGestureVerifyError];
        }
    }
}


@end
