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

@interface HXBHomePopViewManager ()

@property (nonatomic, strong) HXBHomePopViewModel *homePopViewModel;

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
    [HXBHomePopViewRequest homePopViewRequestSuccessBlock:^(id responseObject) {
//        self.homePopViewModel = [[HXBHomePopViewViewModel alloc] init];
        self.homePopViewModel = [HXBHomePopViewModel yy_modelWithDictionary:responseObject[@"data"]];
//        [HXBHomePopViewManager popHomeViewWith:weakSelf.homePopViewVM.homePopModel fromController:weakSelf];//弹出首页弹窗
    } andFailureBlock:^(NSError *error) {
        
    }];
}

- (void)popHomeViewfromController:(UIViewController *)controller{
    
    kWeakSelf
    if ([HXBHomePopViewManager checkHomePopViewWith:self.homePopViewModel]) {
        
        // 1.初始化
        HXBHomePopView *popView = [HXBHomePopView sharedManager];
//        [popView.imgView sd_setImageWithURL:[NSURL URLWithString:self.homePopViewModel.]];
        // 2.设置属性，可不设置使用默认值，见注解
        // 2.1 显示时点击背景是否移除弹框
        popView.isClickBGDismiss = YES;
        // 2.2 显示时背景的透明度
        popView.popBGAlpha = 0.5f;
        // 2.6 显示完成回调
        popView.popCompleteBlock = ^{
            NSLog(@"1111显示完成");
        };
        // 2.7 移除完成回调
        popView.dismissCompleteBlock = ^{
            NSLog(@"1111移除完成");
        };
        // 3.1处理自定义视图操作事件
        __weak typeof(popView) weakPopView = popView;
        popView.closeActionBlock = ^{
            NSLog(@"1111点击关闭按钮");
            [weakPopView dismiss];
        };
        popView.clickImageBlock = ^{
            NSLog(@"1111点击图片");
            //跳转到原生或h5
            [[HXBHomePopViewManager sharedInstance] jumpPageFromHomePopView:weakSelf.homePopViewModel fromController:controller];
        };
        popView.clickBgmDismissCompleteBlock = ^{
            NSLog(@"1111点击背景移除完成");
            [weakPopView dismiss];
        };
        // 4.显示弹框
        [popView pop];
    }
}

+ (void)popHomeViewWith:(HXBHomePopViewModel *)homePopViewModel fromController:(UIViewController *)controller{
    
    if ([HXBHomePopViewManager checkHomePopViewWith:homePopViewModel]) {
        // 1.初始化
        //    ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithCustomView:_customView popStyle:popStyle dismissStyle:dismissStyle];
        HXBHomePopView *popView = [HXBHomePopView sharedManager];
        // 2.设置属性，可不设置使用默认值，见注解
        // 2.1 显示时点击背景是否移除弹框
        popView.isClickBGDismiss = YES;
        // 2.2 显示时背景的透明度
        popView.popBGAlpha = 0.5f;
        // 2.6 显示完成回调
        popView.popCompleteBlock = ^{
            NSLog(@"显示完成");
        };
        // 2.7 移除完成回调
        popView.dismissCompleteBlock = ^{
            NSLog(@"移除完成");
        };
        
        // 3.处理自定义视图操作事件
        __weak typeof(popView) weakPopView = popView;
        popView.closeActionBlock = ^{
            NSLog(@"点击关闭按钮");
            [weakPopView dismiss];
        };
        popView.clickImageBlock = ^{
            NSLog(@"点击图片");
            //跳转到原生或h5
            [[HXBHomePopViewManager sharedInstance] jumpPageFromHomePopView:homePopViewModel fromController:controller];
        };
        popView.clickBgmDismissCompleteBlock = ^{
            [weakPopView dismiss];
        };
        // 4.显示弹框
        [popView pop];
    }
}

- (void)jumpPageFromHomePopView:(HXBHomePopViewModel *)homePopViewModel fromController:(UIViewController *)controller{
    
    //校验可不可以跳转
    
    //相关置位
    if (@"原生") { //哪种类型
        //确定哪个页面 及参数


        //计划列表
        HXBFinancing_PlanDetailsViewController *planDetailsVC = [[HXBFinancing_PlanDetailsViewController alloc]init];
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"红利计划##" style:UIBarButtonItemStylePlain target:nil action:nil];
        controller.navigationItem.backBarButtonItem = leftBarButtonItem;
//        HxbHomePageModel_DataList *homePageModel = weakSelf.homeView.homeBaseModel.homePlanRecommend[indexPath.section];
//        planDetailsVC.title = homePageModel.name;
//        planDetailsVC.planID = homePageModel.ID;
        planDetailsVC.isPlan = YES;
        planDetailsVC.isFlowChart = YES;
        [controller.navigationController pushViewController:planDetailsVC animated:YES];
        //详情页面


    } else if (@"H5"){
    
        NSString *str = [NSString stringWithFormat:@"%@/about/announcement/%@",[KeyChain h5host],@"0b025dfa-4613-4ba9-a9e8-5805fdb6a829"];
        [HXBBaseWKWebViewController pushWithPageUrl:str fromController:controller];
    }
    
    [[HXBHomePopView sharedManager]dismiss];
//    controller.navigationController pushViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#>
}

+ (BOOL)checkHomePopViewWith:(HXBHomePopViewModel *)homePopViewModel{
    
    
    return YES;
}



@end
