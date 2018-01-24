//
//  HXBHomePopViewManager.m
//  hoomxb
//
//  Created by hxb on 2017/12/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBHomePopViewManager.h"
#import "HXBHomePopView.h"
#import "HxbHomeViewController.h"
#import "HXBFinancing_PlanDetailsViewController.h"
#import "HXBHomePopViewRequest.h"
#import "HXBHomePopViewModel.h"
#import <UIImageView+WebCache.h>
#import "HXBBaseTabBarController.h"
#import "NSString+HxbGeneral.h"
#import "HXBVersionUpdateManager.h"
#import "UIImage+HXBUtil.h"
#import "HxbSignUpViewController.h"
#import "HXBNoticeViewController.h"
#import "HXBBannerWebViewController.h"
#import "HXBRootVCManager.h"

#define kRegisterVC @"/account/register"//注册页面
#define kNoticeVC @"/home/notice"//公告列表
#define kPlanDetailVC @"/plan/detail"//某个计划的详情页
//#define kLoanDetailVC @"/loan/detail"//某个散标的详情页
#define kPlan_fragment @"/home/plan_fragment"//红利计划列表页
//#define kLoan_fragment @"/home/loan_fragment"//散标列表页
//#define kLoantransferfragment @"/home/loan_transfer_fragment"//债权转让列表页

@interface HXBHomePopViewManager ()

@property (nonatomic, strong) HXBHomePopView *popView;
@property (nonatomic, strong) HXBHomePopViewModel *homePopViewModel;
@property (nonatomic, strong) NSDictionary *responseDict;

@end

@implementation HXBHomePopViewManager

+ (instancetype)sharedInstance {
    static HXBHomePopViewManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [HXBHomePopViewManager new];
//        [manager getHomePopViewData];
    });
    return manager;
}

/**
 获取首页弹窗数据
 */
- (void)getHomePopViewData
{
    kWeakSelf
    [HXBHomePopViewRequest homePopViewRequestSuccessBlock:^(id responseObject) {
        
        if ([responseObject[@"data"] isKindOfClass:[NSDictionary class]] && !responseObject[@"data"][@"id"]) {
            weakSelf.isHide = YES;
            return ;
        }
        weakSelf.homePopViewModel = [HXBHomePopViewModel yy_modelWithDictionary:responseObject[@"data"]];
        [weakSelf updateUserDefaultsPopViewDate:responseObject[@"data"]];
    } andFailureBlock:^(NSError *error) {
        self.isHide = YES;
    }];
}

- (void)updateUserDefaultsPopViewDate:(NSDictionary *)dict {
    _responseDict = (NSDictionary *)[kUserDefaults objectForKey:dict[@"id"]];
    if (_responseDict[@"image"]) {
        if (_responseDict[@"updateTime"] < dict[@"updateTime"]) { //已更新
            _responseDict = dict;
            //            [kUserDefaults setObject:_responseDict forKey:_responseDict[@"id"]];
            //            [kUserDefaults synchronize];
            [self cachePopHomeImage];
        } else {
            self.isHide = ![kUserDefaults boolForKey:[NSString stringWithFormat:@"%@%@",_responseDict[@"id"],_responseDict[@"frequency"]]];
        }
    } else {
        _responseDict = dict;
        //        [kUserDefaults setObject:_responseDict forKey:_responseDict[@"id"]];
        //        [kUserDefaults synchronize];
        [self cachePopHomeImage];
    }
}

- (void)cachePopHomeImage{
    kWeakSelf
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    UIImage *image = [imageCache imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@image",_responseDict[@"id"]]];
    if (image) {
        [imageCache removeImageForKey:[NSString stringWithFormat:@"%@image",_responseDict[@"id"]] fromDisk:YES];
    }
    [self.popView.imgView sd_setImageWithURL:[NSURL URLWithString:_responseDict[@"image"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            //            UIImage *img = [UIImage createRoundedRectImage:image size:image.size radius:kScrAdaptationW(4)];
            //            weakSelf.popView.imgView.image = img;
            weakSelf.popView.imgView.image = image;
            [kUserDefaults setObject:_responseDict forKey:_responseDict[@"id"]];
            [kUserDefaults synchronize];
            [imageCache storeImage:image forKey:[NSString stringWithFormat:@"%@image",_responseDict[@"id"]] toDisk:YES];
            [imageCache removeImageForKey:_responseDict[@"image"] fromDisk:YES];
            
//            [kUserDefaults setBool:YES forKey:[NSString stringWithFormat:@"%@frequency",_responseDict[@"id"]]];
//            [kUserDefaults synchronize];
            weakSelf.isHide = NO;
            
            [[HXBHomePopViewManager sharedInstance] popHomeViewfromController:[HXBRootVCManager manager].topVC];//展示首页弹窗
        } else {
//            [kUserDefaults setBool:NO forKey:[NSString stringWithFormat:@"%@frequency",_responseDict[@"id"]]];
//            [kUserDefaults synchronize];
            if ([weakSelf.responseDict[@"frequency"] isEqualToString:@"once"]) {
                [kUserDefaults setBool:NO forKey:[NSString stringWithFormat:@"%@%@",weakSelf.responseDict[@"id"],weakSelf.responseDict[@"frequency"]]];
                //                weakSelf.isHide = YES;
                [kUserDefaults synchronize];
            } else {
                [kUserDefaults setBool:YES forKey:[NSString stringWithFormat:@"%@%@",weakSelf.responseDict[@"id"],weakSelf.responseDict[@"frequency"]]];
                //                weakSelf.isHide = YES;
                [kUserDefaults synchronize];
            }
            self.isHide = YES;
        }
    }];
}

- (void)popHomeViewfromController:(UIViewController *)controller{
    
    if ([controller isKindOfClass:[HxbHomeViewController class]] && [HXBVersionUpdateManager sharedInstance].isShow) {
        kWeakSelf
        // 显示完成回调
        __weak typeof(_popView) weakPopView = self.popView;
        self.popView.popCompleteBlock = ^{
            NSLog(@"1111显示完成");
            if ([weakSelf.responseDict[@"frequency"] isEqualToString:@"once"]) {
                [kUserDefaults setBool:NO forKey:[NSString stringWithFormat:@"%@%@",weakSelf.responseDict[@"id"],weakSelf.responseDict[@"frequency"]]];
//                weakSelf.isHide = YES;
                [kUserDefaults synchronize];
            } else {
                [kUserDefaults setBool:YES forKey:[NSString stringWithFormat:@"%@%@",weakSelf.responseDict[@"id"],weakSelf.responseDict[@"frequency"]]];
                //                weakSelf.isHide = YES;
                [kUserDefaults synchronize];
            }

            weakSelf.isHide = YES;
            
        };
        // 移除完成回调
        self.popView.dismissCompleteBlock = ^{
            NSLog(@"1111移除完成");
        };
        // 处理自定义视图操作事件
        self.popView.closeActionBlock = ^{
            NSLog(@"1111点击关闭按钮");
            [weakPopView dismiss];
        };
        self.popView.clickImageBlock = ^{
            NSLog(@"1111点击图片");
            //校验可不可以跳转
            if ([HXBHomePopViewManager checkHomePopViewWith:weakSelf.homePopViewModel]) {
                //跳转到原生或h5
                [[HXBHomePopViewManager sharedInstance] jumpPageFromHomePopView:weakSelf.homePopViewModel fromController:controller];
            }
            
        };
        self.popView.clickBgmDismissCompleteBlock = ^{
            NSLog(@"1111点击背景移除完成");
            [weakPopView dismiss];
        };
        // 显示弹框
        if (!self.isHide) {
//            UIImage *image = [UIImage imageWithData: [kUserDefaults objectForKey:[NSString stringWithFormat:@"%@image",_responseDict[@"id"]]]];
            UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@image",_responseDict[@"id"]]];
//            UIImage *img = [UIImage createRoundedRectImage:image size:image.size radius:kScrAdaptationW(4)];
            if (image) {
//                weakSelf.popView.imgView.image = img;
                weakSelf.popView.imgView.image = image;
                [weakSelf.popView pop];
//                [kUserDefaults setBool:YES forKey:[NSString stringWithFormat:@"%@frequency",_responseDict[@"id"]]];
//                [kUserDefaults synchronize];
            }
        }
    }
}

- (void)jumpPageFromHomePopView:(HXBHomePopViewModel *)homePopViewModel fromController:(UIViewController *)controller{
    
    self.popView.userInteractionEnabled = NO;//避免重复点击
    if ([homePopViewModel.type isEqualToString:@"native"]) { //哪种类型
        
        if ([homePopViewModel.url hasPrefix:kPlan_fragment]) {
            //计划列表
            HXBBaseTabBarController *tabBarVC = (HXBBaseTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            tabBarVC.selectedIndex = 1;
            [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_PlanAndLoan_Fragment object:@{@"selectedIndex" : @0}];
        } else if ([homePopViewModel.url hasPrefix:kPlanDetailVC]){
            //某个计划的详情页
            HXBFinancing_PlanDetailsViewController *planDetailsVC = [[HXBFinancing_PlanDetailsViewController alloc]init];
            NSDictionary *parameterDict = [NSString urlDictFromUrlString:homePopViewModel.url];
            if (parameterDict[@"productId"]) {
                planDetailsVC.planID = parameterDict[@"productId"];
                planDetailsVC.isPlan = YES;
                planDetailsVC.isFlowChart = YES;
                [controller.navigationController pushViewController:planDetailsVC animated:YES];
            } else {
                return;
            }
        } else if([homePopViewModel.url hasPrefix:kRegisterVC]){
            //注册
            //跳转登录注册
            [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowSignUpVC object:nil];
            
        }else if ([homePopViewModel.url hasPrefix:kNoticeVC]){
            //公告列表
            HXBNoticeViewController *noticeVC = [[HXBNoticeViewController alloc] init];
            [controller.navigationController pushViewController:noticeVC animated:YES];
        }
    } else if ([homePopViewModel.type isEqualToString:@"broswer"]) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:homePopViewModel.url]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:homePopViewModel.url]];
        }
    } else if ([homePopViewModel.type isEqualToString:@"h5"]) {
        
        if (homePopViewModel.url.length) {
            HXBBannerWebViewController *webViewVC = [[HXBBannerWebViewController alloc] init];
            webViewVC.pageUrl = homePopViewModel.url;
            [controller.navigationController pushViewController:webViewVC animated:YES];
        }
    }
    
    [self.popView dismiss];
}

+ (BOOL)checkHomePopViewWith:(HXBHomePopViewModel *)homePopViewModel{
    
    if ([homePopViewModel.url isEqualToString:@""] || [homePopViewModel.url isEqualToString:@"/"]) {
        return NO;
    } else {
        return YES;
    }
}

- (HXBHomePopView *)popView{
    if (!_popView) {
         _popView = [[HXBHomePopView alloc]init];
        // 显示时点击背景是否移除弹框
        _popView.isClickBGDismiss = YES;
        // 显示时背景的透明度
        _popView.popBGAlpha = 0.6f;
    }
    return _popView;
}

@end
