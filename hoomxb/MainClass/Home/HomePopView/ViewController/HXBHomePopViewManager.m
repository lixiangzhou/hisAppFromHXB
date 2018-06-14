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
#import "HXBHomePopVWViewModel.h"
#import "HXBHomePopVWModel.h"
#import <UIImageView+WebCache.h>
#import "HXBBaseTabBarController.h"
#import "NSString+HxbGeneral.h"
#import "HXBVersionUpdateManager.h"
#import "UIImage+HXBUtil.h"
#import "HxbSignUpViewController.h"
#import "HXBNoticeViewController.h"
#import "HXBBannerWebViewController.h"
#import "HXBRootVCManager.h"
#import "NSDate+HXB.h"
#import "HXBExtensionMethodTool.h"

#define kRegisterVC @"/account/register"//注册页面
#define kNoticeVC @"/home/notice"//公告列表
#define kPlanDetailVC @"/plan/detail"//某个计划的详情页
//#define kLoanDetailVC @"/loan/detail"//某个散标的详情页
#define kPlan_fragment @"/home/plan_fragment"//红利计划列表页
//#define kLoan_fragment @"/home/loan_fragment"//散标列表页
//#define kLoantransferfragment @"/home/loan_transfer_fragment"//债权转让列表页

@interface HXBHomePopViewManager ()

@property (nonatomic, strong) HXBHomePopView *popView;
@property (nonatomic, strong) HXBHomePopVWViewModel *homePopViewModel;
@property (nonatomic, strong) NSDictionary *responseDict;

@end

@implementation HXBHomePopViewManager

+ (instancetype)sharedInstance {
    static HXBHomePopViewManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [HXBHomePopViewManager new];
    });
    return manager;
}

/**
 获取首页弹窗数据
 */
- (void)getHomePopViewData
{
    kWeakSelf
    self.homePopViewModel = [[HXBHomePopVWViewModel alloc] initWithBlock:^UIView *{
        return weakSelf.popView;
    }];
    [self.homePopViewModel homePopViewRequestSuccessBlock:^(BOOL isSuccess) {
        
        if (!isSuccess) {
            weakSelf.isHide = YES;
            return ;
        }
        [weakSelf updateUserDefaultsPopViewDate:(NSDictionary *)[self.homePopViewModel.homePopModel yy_modelToJSONObject]];
    }];
}

- (void)updateUserDefaultsPopViewDate:(NSDictionary *)dict{

    _responseDict = (NSDictionary *)[kUserDefaults objectForKey:self.homePopViewModel.homePopModel.ID];
    if (_responseDict[@"image"]) {
        if ([_responseDict[@"updateTime"] longLongValue] < (long long)self.homePopViewModel.homePopModel.updateTime) { //已更新
            
            _responseDict = (NSDictionary *)[self.homePopViewModel.homePopModel yy_modelToJSONObject];
            [self cachePopHomeImage];
        } else {
            if ([_responseDict[@"frequency"] isEqualToString:@"once"] || [_responseDict[@"frequency"] isEqualToString:@"everytime"]) {
                self.isHide = ![kUserDefaults boolForKey:[NSString stringWithFormat:@"%@%@",_responseDict[@"id"],_responseDict[@"frequency"]]];
            } else if ([_responseDict[@"frequency"] isEqualToString:@"everyday"]) {
                long long todayTimestamp = [[NSNumber numberWithDouble:[[NSDate getTodayTimestamp] timeIntervalSince1970] * 1000] longLongValue];//今天零时零分零秒
                long long startTimestamp = [_responseDict[@"start"] longLongValue];
                long long endTimestamp = [_responseDict[@"end"] longLongValue];
                if (todayTimestamp >= startTimestamp && todayTimestamp < endTimestamp) {
                    self.isHide = [kUserDefaults boolForKey:[NSString stringWithFormat:@"%@%@%lld",_responseDict[@"id"],_responseDict[@"frequency"],todayTimestamp]];
                } else {
                    self.isHide = YES;
                    [kUserDefaults setBool:YES forKey:[NSString stringWithFormat:@"%@%@%lld",_responseDict[@"id"],_responseDict[@"frequency"],todayTimestamp]];//下次隐藏
                    [kUserDefaults synchronize];
                }
            }
        }
    } else {
        _responseDict = dict;
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
    
        long long todayTimestamp = [[NSNumber numberWithDouble:[[NSDate getTodayTimestamp] timeIntervalSince1970] * 1000] longLongValue];//今天零时零分零秒
        long long startTimestamp = [weakSelf.responseDict[@"start"] longLongValue];
        long long endTimestamp = [weakSelf.responseDict[@"end"] longLongValue];
        
        if (image) {
            weakSelf.popView.imgView.image = image;
            [kUserDefaults setObject:_responseDict forKey:_responseDict[@"id"]];
            [kUserDefaults synchronize];
            [imageCache storeImage:image forKey:[NSString stringWithFormat:@"%@image",_responseDict[@"id"]] toDisk:YES];
            [imageCache removeImageForKey:_responseDict[@"image"] fromDisk:YES];
            
            weakSelf.isHide = NO;
            [[HXBHomePopViewManager sharedInstance] popHomeViewfromController:[HXBRootVCManager manager].topVC];//展示首页弹窗
   
        } else {

            if ([weakSelf.responseDict[@"frequency"] isEqualToString:@"once"]) {
                [kUserDefaults setBool:NO forKey:[NSString stringWithFormat:@"%@%@",weakSelf.responseDict[@"id"],weakSelf.responseDict[@"frequency"]]];
                [kUserDefaults synchronize];
            } else if ([weakSelf.responseDict[@"frequency"] isEqualToString:@"everytime"]) {
                [kUserDefaults setBool:YES forKey:[NSString stringWithFormat:@"%@%@",weakSelf.responseDict[@"id"],weakSelf.responseDict[@"frequency"]]];
                [kUserDefaults synchronize];
            } else if ([weakSelf.responseDict[@"frequency"] isEqualToString:@"everyday"]) {
                
                if (todayTimestamp >= startTimestamp && todayTimestamp < endTimestamp) { //当天0时在弹窗有效期
                    [kUserDefaults setBool:YES forKey:[NSString stringWithFormat:@"%@%@%lld",weakSelf.responseDict[@"id"],weakSelf.responseDict[@"frequency"],todayTimestamp]];
                } else {
                    [kUserDefaults setBool:NO forKey:[NSString stringWithFormat:@"%@%@%lld",weakSelf.responseDict[@"id"],weakSelf.responseDict[@"frequency"],todayTimestamp]];
                }
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
                [kUserDefaults synchronize];
            } else if ([weakSelf.responseDict[@"frequency"] isEqualToString:@"everytime"]){
                [kUserDefaults setBool:YES forKey:[NSString stringWithFormat:@"%@%@",weakSelf.responseDict[@"id"],weakSelf.responseDict[@"frequency"]]];
                [kUserDefaults synchronize];
            }  else if ([weakSelf.responseDict[@"frequency"] isEqualToString:@"everyday"]){

                long long todayTimestamp = [[NSNumber numberWithDouble:[[NSDate getTodayTimestamp] timeIntervalSince1970] * 1000] longLongValue];//今天零时零分零秒

                [kUserDefaults setBool:YES forKey:[NSString stringWithFormat:@"%@%@%lld",weakSelf.responseDict[@"id"],weakSelf.responseDict[@"frequency"],todayTimestamp]];
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
            if ([HXBHomePopViewManager checkHomePopViewWith:weakSelf.homePopViewModel.homePopModel]) {
                //跳转到原生或h5
                [[HXBHomePopViewManager sharedInstance] jumpPageFromHomePopView:weakSelf.homePopViewModel.homePopModel fromController:controller];
            }
            
        };
        self.popView.clickBgmDismissCompleteBlock = ^{
            NSLog(@"1111点击背景移除完成");
            [weakPopView dismiss];
        };
        // 显示弹框
        if (!self.isHide) {
            UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@image",_responseDict[@"id"]]];
            if (image) {
                weakSelf.popView.imgView.image = image;
                [weakSelf.popView pop];
            }
        }
    }
}

- (void)jumpPageFromHomePopView:(HXBHomePopVWModel *)homePopViewModel fromController:(UIViewController *)controller{
    
    self.popView.userInteractionEnabled = NO;//避免重复点击
    
    BannerModel *pushVCmodel = [[BannerModel alloc] init];
    pushVCmodel.type = homePopViewModel.type;
    pushVCmodel.link = homePopViewModel.url;

    [HXBExtensionMethodTool pushToViewControllerWithModel:pushVCmodel andWithFromVC:controller];
    
    [self.popView dismiss];
}

+ (BOOL)checkHomePopViewWith:(HXBHomePopVWModel *)homePopViewModel{
    
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
