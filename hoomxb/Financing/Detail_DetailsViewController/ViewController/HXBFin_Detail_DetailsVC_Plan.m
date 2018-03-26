//
//  HXBFin_Detail_DetailsVC_Plan.m
//  hoomxb
//
//  Created by HXB on 2017/5/11.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//  计划详情-》计划详情

#import "HXBFin_Detail_DetailsVC_Plan.h"
#import "HXBFinDetailViewModel_PlanDetail.h"
#import "HXBFinDetailModel_PlanDetail.h"
#import "HXBFinPlanDetail_DetailView.h"//详情中的详情 plan
@interface HXBFin_Detail_DetailsVC_Plan ()
//// ------ view
//@property (nonatomic,strong) UIView *addView;
/////计划金额
//@property (nonatomic,strong) UILabel *planAmountLabel;
//@property (nonatomic,strong) UILabel *planAmountLabel_const;
//
/////加入条件
//@property (nonatomic,strong) UILabel *joinConditionLabel;
//@property (nonatomic,strong) UILabel *joinConditionLabel_const;
//
/////Joined on the line加入上线
//@property (nonatomic,strong) UILabel *joinedOnTheLineLabel;
//@property (nonatomic,strong) UILabel *joinedOnTheLineLabel_const;
//
////----- view
//@property (nonatomic,strong) UIView *dateView;
/////开始加入日期
//@property (nonatomic,strong) UILabel *startByDateLabel;
//@property (nonatomic,strong) UILabel *startByDateLabel_const;
//
/////退出日期
//@property (nonatomic,strong) UILabel *exitDateLabel;
//@property (nonatomic,strong) UILabel *exitDateLabel_const;
//
/////期限
//@property (nonatomic,strong) UILabel *theTermLabel;
//@property (nonatomic,strong) UILabel *theTermLabel_const;
//
//
////----- view
//@property (nonatomic,strong) UIView *typeView;
/////到期退出方式
//@property (nonatomic,strong) UILabel *expiredExitMethodLabel;
//@property (nonatomic,strong) UILabel *expiredExitMethodLabel_const;
//
/////安全保障
//@property (nonatomic,strong) UILabel *securityLabel;
//@property (nonatomic,strong) UILabel *securityLabel_const;
//
/////收益处理方式
//@property (nonatomic,strong) UILabel *revenueApproachLabel;
//@property (nonatomic,strong) UILabel *revenueApproachLabel_const;
//
////-----view
//@property (nonatomic,strong) UIView *serviceView;
/////服务费
//@property (nonatomic,strong) UIButton *serviceChargeButton;
//@property (nonatomic,strong) UILabel *serviceChargeLabel;
//@property (nonatomic,strong) UILabel *serviceChargeLabel_const;

@property (nonatomic,strong) HXBFinPlanDetail_DetailView *planDetail_DetailView;
@property (nonatomic,strong) UITableView *hxbBaseVCScrollView;
@property (nonatomic,copy) void(^trackingScrollViewBlock)(UIScrollView *scrollView);
@end

@implementation HXBFin_Detail_DetailsVC_Plan

- (void) setPlanDetailModel:(HXBFinDetailViewModel_PlanDetail *)planDetailModel {
    _planDetailModel = planDetailModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isColourGradientNavigationBar = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"计划详情";
    [self setUP];
}


///初始化展示网络数据的lable
- (void)setUP {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.planDetail_DetailView = [[HXBFinPlanDetail_DetailView alloc]initWithFrame:CGRectMake(0, HXBStatusBarAndNavigationBarHeight, kScreenWidth, kScreenHeight - HXBStatusBarAndNavigationBarHeight) withCashType:self.planDetailModel.planDetailModel.cashType];
    
    [self.hxbBaseVCScrollView addSubview:self.planDetail_DetailView];
    self.hxbBaseVCScrollView.bounces = YES;
//    [self.planDetail_DetailView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
    
    __weak typeof(self)weakSelf = self;
    [self.planDetail_DetailView setValueManager_PlanDetail_Detail:^HXBFinPlanDetail_DetailViewManager *(HXBFinPlanDetail_DetailViewManager *manager) {
         HXBFinDetailModel_PlanDetail *detailData = weakSelf.planDetailModel.planDetailModel;
        if (!detailData) {
            return manager;
        }

        manager.addViewManager.leftStrArray = @[
                                                @"计划金额",
                                                @"加入条件",
                                                @"加入上限",
                                                ];
        manager.addViewManager.rightStrArray = @[
                                                [NSString hxb_getPerMilWithIntegetNumber:detailData.amount],//@"测试加入原因";//计化金额
                                                weakSelf.planDetailModel.addCondition_detail,//加入条件
                                                weakSelf.planDetailModel.singleMaxRegisterAmount//加入上线
                                                ];
        manager.dateViewManager.leftStrArray = @[
                                                @"开始加入日期",
                                                @"锁定期结束日",
                                                @"锁定期",
                                                ];
        manager.dateViewManager.rightStrArray = @[
                                                 weakSelf.planDetailModel.beginSellingTime,//开始时间
                                                 weakSelf.planDetailModel.financeEndTime,//结束时间
                                                 weakSelf.planDetailModel.lockPeriod//期限
                                                ];
        if ([detailData.cashType isEqualToString:FIN_PLAN_INCOMEAPPROACH_MONTHLY]) {
            manager.typeViewManager.leftStrArray = @[
                                                     @"收益方式",
                                                     @"收益提取日",
                                                     ];
            manager.typeViewManager.rightStrArray = @[
                                                      detailData.incomeApproach?detailData.incomeApproach:@"",
                                                      detailData.interestDate?detailData.interestDate:@"",
                                                      ];
        } else {
            manager.typeViewManager.leftStrArray = @[
                                                     @"收益方式",
                                                     ];
            manager.typeViewManager.rightStrArray  = @[
                                                      detailData.incomeApproach?detailData.incomeApproach:@"",
                                                      ];
        }
        
        manager.quitWaysDesc = weakSelf.planDetailModel.planDetailModel.quitWaysDesc;
        
        manager.serverViewManager.leftStrArray = @[
                                                @"服务费"
                                                ];
        manager.serverViewManager.rightStrArray = @[
                                                weakSelf.planDetailModel.contractName
                                                ];
        NSString *str = [NSString stringWithFormat:@"参见%@",weakSelf.planDetailModel.contractName];
//        if ([detailData.cashType isEqualToString:FIN_PLAN_INCOMEAPPROACH_MONTHLY]) {
//            str = [NSString stringWithFormat:@"参见%@",@"《按月付息服务协议》"];
//        }
        NSRange range = NSMakeRange(2, str.length - 2);
        manager.serverViewAttributedStr = [NSAttributedString setupAttributeStringWithString:str WithRange:range andAttributeColor:kHXBColor_RGB(115/250.0, 163.0/255.0, 1, 1) andAttributeFont:kHXBFont_PINGFANGSC_REGULAR(15)];
        return manager;
    }];
    [self.planDetail_DetailView clickServerButtonWithBlock:^(UILabel *button) {
        //跳转 协议
        
        NSString *urlStr = [weakSelf.planDetailModel.planDetailModel.cashType isEqualToString:FIN_PLAN_INCOMEAPPROACH_MONTHLY] ? kHXB_Negotiate_ServePlanMonthURL : kHXB_Negotiate_ServePlanURL;
        [HXBBaseWKWebViewController pushWithPageUrl:[NSString splicingH5hostWithURL:urlStr] fromController:weakSelf];
    }];
    
}

- (UITableView *)hxbBaseVCScrollView {
    if (!_hxbBaseVCScrollView) {
        
        _hxbBaseVCScrollView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        
        [self.view insertSubview:_hxbBaseVCScrollView atIndex:0];
        [_hxbBaseVCScrollView.panGestureRecognizer addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
        _hxbBaseVCScrollView.tableFooterView = [[UIView alloc]init];
        _hxbBaseVCScrollView.backgroundColor = kHXBColor_BackGround;
        [HXBMiddlekey AdaptationiOS11WithTableView:_hxbBaseVCScrollView];
    }
    return _hxbBaseVCScrollView;
}

- (void)dealloc {
    [self.hxbBaseVCScrollView.panGestureRecognizer removeObserver: self forKeyPath:@"state"];
    NSLog(@"✅被销毁 %@",self);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"state"]) {
        NSNumber *tracking = change[NSKeyValueChangeNewKey];
        if (tracking.integerValue == UIGestureRecognizerStateBegan && self.trackingScrollViewBlock) {
            self.trackingScrollViewBlock(self.hxbBaseVCScrollView);
        }
        return;
    }
    
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:nil];
}
@end
