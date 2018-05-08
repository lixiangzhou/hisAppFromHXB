//
//  HXBWithdrawCardResultViewController.m
//  hoomxb
//
//  Created by hxb on 2018/4/27.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//  绑卡结果页

#import "HXBWithdrawCardResultViewController.h"
#import "HXBLazyCatResponseDelegate.h"
#import "HXBLazyCatResponseModel.h"
#import "HxbWithdrawCardViewController.h"
#import "HXBCommonResultController.h"
/// 来源
typedef NS_ENUM(NSInteger, PopViewController) {
    kHXBPopBuysController,  //!< 计划、散标、债转购买页
    kHXBPopTopUpAndWithdrawAndWithdrawCardController   //!< 充值、提现,账户内 绑卡
};

@interface HXBWithdrawCardResultViewController ()<HXBLazyCatResponseDelegate>
@property (nonatomic,strong) NSArray *popViewControllersArray;
@property (nonatomic,assign) PopViewController popControllerType;
@property (nonatomic,strong) HXBLazyCatResponseModel *responseModel;
@property (nonatomic,strong) HXBCommonResultController *commonResultVC;
@end

@implementation HXBWithdrawCardResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPopControllerType];
    [self setAction];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 禁用全屏滑动手势
    ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 恢复全屏滑动手势
    ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = YES;
}

- (void)setPopControllerType {
    
    if (self.popViewControllersArray.count > 0) {
        if ([self.popViewControllersArray[0] isKindOfClass:NSClassFromString(@"HXBFin_Plan_Buy_ViewController")] || [self.popViewControllersArray[0] isKindOfClass:NSClassFromString(@"HXBFin_Loan_Buy_ViewController")] ||[self.popViewControllersArray[0] isKindOfClass:NSClassFromString(@"HXBFin_creditorChange_buy_ViewController")]) {
            self.popControllerType = kHXBPopBuysController;
        } else if ([self.popViewControllersArray[0] isKindOfClass:NSClassFromString(@"HxbWithdrawCardViewController")]) { //充值、提现,账户内 绑卡
            self.popControllerType = kHXBPopTopUpAndWithdrawAndWithdrawCardController;
        }
    }
}

- (void)setAction {
    kWeakSelf
    self.commonResultVC = [HXBCommonResultController new];
    HXBCommonResultContentModel *commonResultModel = nil;
    if ([self.responseModel.result isEqualToString:@"success"]) { //成功
        if (self.popControllerType == kHXBPopBuysController) {
            return; //从购买来的绑卡 成功不进结果页
        }
        commonResultModel = [[HXBCommonResultContentModel alloc]initWithImageName:@"successful" titleString:self.responseModel.data.title descString:self.responseModel.data.content firstBtnTitle: @"完成"];
        commonResultModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
            //返回绑卡前界面
            int i = 0;
            for (; i<weakSelf.navigationController.viewControllers.count; i++) {
                if ([weakSelf.navigationController.viewControllers[i] isKindOfClass:NSClassFromString(@"HxbWithdrawCardViewController")]) {
                    break;
                }
            }
            if (i>0) {
                [weakSelf.navigationController popToViewController:weakSelf.navigationController.viewControllers[i-1] animated:YES];
            } //
        };
    } else if ([self.responseModel.result isEqualToString:@"error"]){ //失败
        commonResultModel = [[HXBCommonResultContentModel alloc]initWithImageName:@"failure" titleString:self.responseModel.data.title descString:self.responseModel.data.content firstBtnTitle: @"重新绑卡"];
        commonResultModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
            //返回绑卡界面
            int i = 0;
            for (; i<weakSelf.navigationController.viewControllers.count; i++) {
                if ([weakSelf.navigationController.viewControllers[i] isKindOfClass:NSClassFromString(@"HxbWithdrawCardViewController")]) {
                    break;
                }
            }
            if (i>0) {
                [weakSelf.navigationController popToViewController:weakSelf.navigationController.viewControllers[i] animated:YES];
            }
        };
    }else if ([self.responseModel.result isEqualToString:@"timeout"]) { //超时
        commonResultModel = [[HXBCommonResultContentModel alloc]initWithImageName:@"outOffTime" titleString:self.responseModel.data.title descString:self.responseModel.data.content firstBtnTitle: @"返回"];
        commonResultModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
            //无论从购买 充值 提现 我的，都返回到第0个
            [weakSelf.navigationController popToViewController:weakSelf.popViewControllersArray[0] animated:YES];
        };
    }
    
    self.commonResultVC.contentModel = commonResultModel;
    [self.view addSubview: self.commonResultVC.view];
}

#pragma mark - HXBLazyCatResponseDelegate
- (void)setResultPageWithPopViewControllers:(NSArray *)vcArray
{
    self.popViewControllersArray = vcArray;
}

- (void)setResultPageProperty:(HXBLazyCatResponseModel *)model {
    self.responseModel = model;
}

- (void)leftBackBtnClick {
    if (self.popControllerType == kHXBPopBuysController) { //购买过来的 返回购买页
        [self.navigationController popToViewController:self.popViewControllersArray[0] animated:YES];
    } else {
        
        int i = 0;
        for (; i<self.navigationController.viewControllers.count; i++) {
            if ([self.navigationController.viewControllers[i] isKindOfClass:NSClassFromString(@"HxbWithdrawCardViewController")]) {
                break;
            }
        }
        if (i>0 && i<self.navigationController.viewControllers.count) {
            //充值 提现 我的，成功返回我的，失败和超时返回绑卡页
            if ([self.responseModel.result isEqualToString:@"success"]) {
                [self.navigationController popToViewController:self.navigationController.viewControllers[i-1] animated:YES];
            } else if ([self.responseModel.result isEqualToString:@"error"]||[self.responseModel.result isEqualToString:@"timeout"]) {
                [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
            }
            else {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }
        else {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

- (NSArray *)popViewControllersArray{
    if (!_popViewControllersArray) {
        _popViewControllersArray = [NSArray array];
    }
    return _popViewControllersArray;
}

@end
