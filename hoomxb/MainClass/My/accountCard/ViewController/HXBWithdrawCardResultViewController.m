//
//  HXBWithdrawCardResultViewController.m
//  hoomxb
//
//  Created by hxb on 2018/4/27.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//  绑卡结果页

#import "HXBWithdrawCardResultViewController.h"
#import "HXBCommonResultController.h"
#import "HXBLazyCatResponseDelegate.h"
#import "HXBLazyCatResponseModel.h"
#import "HxbWithdrawCardViewController.h"

/// 来源
typedef NS_ENUM(NSInteger, PopViewController) {
    kHXBPopBuysController,  //!< 计划、散标、债转购买页
    kHXBPopTopUpAndWithdrawAndWithdrawCardController,   //!< 充值、提现,账户内 绑卡
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
}


#pragma mark - HXBLazyCatResponseDelegate
- (void)setResultPageWithPopViewControllers:(NSArray *)vcArray
{
    self.popViewControllersArray = vcArray;
}

- (void)setResultPageProperty:(HXBLazyCatResponseModel *)model {
    kWeakSelf
    self.responseModel = model;
    self.commonResultVC = [[HXBCommonResultController alloc]init];
    HXBCommonResultContentModel *commonResultModel = nil;
    
    if ([self respondsToSelector:@selector(setResultPageWithPopViewControllers:)]) {
        if (self.popViewControllersArray.count > 0) {
            if ([self.popViewControllersArray[0] isKindOfClass:NSClassFromString(@"HXBFin_Plan_Buy_ViewController")] || [self.popViewControllersArray[0] isKindOfClass:NSClassFromString(@"HXBFin_Loan_Buy_ViewController")] ||[self.popViewControllersArray[0] isKindOfClass:NSClassFromString(@"HXBFin_creditorChange_buy_ViewController")]) {
                self.popControllerType = kHXBPopBuysController;
            } else if ([self.popViewControllersArray[0] isKindOfClass:NSClassFromString(@"HxbWithdrawCardViewController")]) { //充值、提现,账户内 绑卡
                self.popControllerType = kHXBPopTopUpAndWithdrawAndWithdrawCardController;
            } else {
                return;
            }
        }
    }
    
    if ([model.result isEqualToString:@"success"]) { //成功
        if (self.popControllerType == kHXBPopBuysController) {
            return; //从购买来的绑卡 成功不进结果页
        }
        commonResultModel = [[HXBCommonResultContentModel alloc]initWithImageName:@"successful" titleString:model.data.title descString:model.data.content firstBtnTitle: @"完成"];
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
            }
        };
    } else if ([model.result isEqualToString:@"error"]){ //失败
        commonResultModel = [[HXBCommonResultContentModel alloc]initWithImageName:@"failure" titleString:model.data.title descString:model.data.content firstBtnTitle: @"重新绑卡"];
        commonResultModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
            //返回绑卡界面
            if (weakSelf.popViewControllersArray.count>0) {
                [weakSelf.navigationController pushViewController:weakSelf.popViewControllersArray[0] animated:YES];
            }
        };
    }else if ([model.result isEqualToString:@"timeout"]) { //超时
        commonResultModel = [[HXBCommonResultContentModel alloc]initWithImageName:@"outOffTime" titleString:model.data.title descString:model.data.content firstBtnTitle: @"返回"];
        commonResultModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
            
        };
    }
    
    self.commonResultVC.contentModel = commonResultModel;
    [self.view addSubview: self.commonResultVC.view];
}

- (void)leftBackBtnClick {
    if (self.popControllerType == kHXBPopBuysController) { //购买过来的 返回购买页
        [self.navigationController popToViewController:self.popViewControllersArray[0] animated:YES];
    } else {
        //返回绑卡前一个界面
        int i = 0;
        for (; i<self.navigationController.viewControllers.count; i++) {
            if ([self.navigationController.viewControllers[i] isKindOfClass:NSClassFromString(@"HxbWithdrawCardViewController")]) {
                break;
            }
        }
        if (i>0) {
            [self.navigationController popToViewController:self.navigationController.viewControllers[i-1] animated:YES];
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
