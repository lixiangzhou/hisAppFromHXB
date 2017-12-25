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

//#define kRegisterVC @"/account/register"//注册页面
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
        
//        [HXBHomePopViewManager popHomeViewWith:weakSelf.homePopViewVM.homePopModel fromController:weakSelf];//弹出首页弹窗
    } andFailureBlock:^(NSError *error) {
        self.isHide = YES;
    }];
}

- (void)updateUserDefaultsPopViewDate:(NSDictionary *)dict{
    _responseDict = (NSDictionary *)[kUserDefaults objectForKey:dict[@"id"]];
    if (_responseDict[@"image"]) {
        if (_responseDict[@"updateTime"] < dict[@"updateTime"]) { //已更新
            _responseDict = dict;
            [self cachePopHomeImage];
            [kUserDefaults setBool:YES forKey:[NSString stringWithFormat:@"%@frequency",_responseDict[@"id"]]];
            self.isHide = NO;
            [kUserDefaults setObject:_responseDict forKey:dict[@"id"]];
            [kUserDefaults synchronize];
        }
    } else {
        _responseDict = dict;
        [self cachePopHomeImage];
        [kUserDefaults setBool:YES forKey:[NSString stringWithFormat:@"%@frequency",_responseDict[@"id"]]];
        self.isHide = NO;
        [kUserDefaults setObject:_responseDict forKey:_responseDict[@"id"]];
        [kUserDefaults synchronize];
    }
}

- (void)cachePopHomeImage{
    kWeakSelf
    [self.popView.imgView sd_setImageWithURL:[NSURL URLWithString:@"https://picsum.photos/1482/1395/?image=3"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) { //_responseDict[@"image"]
        if (image) {
            weakSelf.popView.imgView.image = image;
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:_responseDict[@"image"]]];
                    [kUserDefaults setObject:data forKey:[NSString stringWithFormat:@"%@image",_responseDict[@"id"]]];
            [kUserDefaults synchronize];
            
//                SDImageCache *imageCache = [SDImageCache sharedImageCache];
//                [imageCache storeImage:image forKey:[NSString stringWithFormat:@"%@image",_responseDict[@"id"]] toDisk:YES];
            }
        }];
    
    
    
    
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:_responseDict[@"image"]]];
//    [kUserDefaults setObject:data forKey:[NSString stringWithFormat:@"%@image",_responseDict[@"id"]]];
//    [kUserDefaults synchronize];
}

- (void)popHomeViewfromController:(UIViewController *)controller{
    
    if ([controller isKindOfClass:[HxbHomeViewController class]] && [HXBVersionUpdateManager sharedInstance].isShow) {
        kWeakSelf
        // 1.初始化
        _popView = [[HXBHomePopView alloc]init];
        //        [popView.imgView sd_setImageWithURL:[NSURL URLWithString:self.homePopViewModel.]];
        // 2.设置属性，可不设置使用默认值，见注解
        // 2.1 显示时点击背景是否移除弹框
        _popView.isClickBGDismiss = YES;
        // 2.2 显示时背景的透明度
        _popView.popBGAlpha = 0.5f;
        // 2.6 显示完成回调
        __weak typeof(_popView) weakPopView = _popView;
        _popView.popCompleteBlock = ^{
            NSLog(@"1111显示完成");
            
            if ([weakSelf.responseDict[@"frequency"] isEqualToString:@"once"]) {
                [kUserDefaults setBool:NO forKey:[NSString stringWithFormat:@"%@frequency",weakSelf.responseDict[@"id"]]];
                weakSelf.isHide = YES;
                //                [weakPopView dismiss];
            }
            
            
            
            if ([weakSelf.responseDict[@"frequency"] isEqualToString:@"everyTime"]) {
                [kUserDefaults setBool:NO forKey:[NSString stringWithFormat:@"%@frequency",weakSelf.responseDict[@"id"]]];
                weakSelf.isHide = YES;
            }
            
            
            
            
            [kUserDefaults synchronize];
        };
        // 2.7 移除完成回调
        _popView.dismissCompleteBlock = ^{
            NSLog(@"1111移除完成");
        };
        // 3.1处理自定义视图操作事件
        _popView.closeActionBlock = ^{
            NSLog(@"1111点击关闭按钮");
            [weakPopView dismiss];
        };
        _popView.clickImageBlock = ^{
            NSLog(@"1111点击图片");
            //校验可不可以跳转
            if ([HXBHomePopViewManager checkHomePopViewWith:self.homePopViewModel]) {
                //跳转到原生或h5
                [[HXBHomePopViewManager sharedInstance] jumpPageFromHomePopView:weakSelf.homePopViewModel fromController:controller];
            }
            
        };
        _popView.clickBgmDismissCompleteBlock = ^{
            NSLog(@"1111点击背景移除完成");
            [weakPopView dismiss];
        };
        // 4.显示弹框
        if (!self.isHide) {
            UIImage *image = [UIImage imageWithData: [kUserDefaults objectForKey:[NSString stringWithFormat:@"%@image",_responseDict[@"id"]]]];
            if (image) {
                _popView.imgView.image = image;
                [_popView pop];
            }
        }
    }
}

- (void)jumpPageFromHomePopView:(HXBHomePopViewModel *)homePopViewModel fromController:(UIViewController *)controller{
    
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
            }
        }
    } else if ([homePopViewModel.type isEqualToString:@"broswer"]) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:homePopViewModel.url]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:homePopViewModel.url]];
        }
    } else {
        //        NSString *str = [NSString stringWithFormat:@"%@/about/announcement/%@",[KeyChain h5host],@"0b025dfa-4613-4ba9-a9e8-5805fdb6a829"];
        //        [HXBBaseWKWebViewController pushWithPageUrl:str fromController:controller];
        //[HXBBaseWKWebViewController pushWithPageUrl:[NSString splicingH5hostWithURL:homePopViewModel.link] fromController:controller];
        [HXBBaseWKWebViewController pushWithPageUrl:homePopViewModel.url fromController:controller];
    }
    
    [_popView dismiss];
}

+ (BOOL)checkHomePopViewWith:(HXBHomePopViewModel *)homePopViewModel{
    
    if ([homePopViewModel.url isEqualToString:@""] || [homePopViewModel.url isEqualToString:@"/"]) {
        return NO;
    } else {
        return YES;
    }
}

@end
