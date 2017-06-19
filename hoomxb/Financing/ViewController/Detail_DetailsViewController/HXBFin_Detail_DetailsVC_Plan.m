//
//  HXBFin_Detail_DetailsVC_Plan.m
//  hoomxb
//
//  Created by HXB on 2017/5/11.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_Detail_DetailsVC_Plan.h"
#import "HXBFinDetailViewModel_PlanDetail.h"
#import "HXBFinDetailModel_PlanDetail.h"
#import "HXBFin_Detail_Detail_PlanWebViewController.h"
@interface HXBFin_Detail_DetailsVC_Plan ()
///计划金额
@property (nonatomic,strong) UILabel *planAmountLabel;
@property (nonatomic,strong) UILabel *planAmountLabel_const;

///加入条件
@property (nonatomic,strong) UILabel *joinConditionLabel;
@property (nonatomic,strong) UILabel *joinConditionLabel_const;

///Joined on the line加入上线
@property (nonatomic,strong) UILabel *joinedOnTheLineLabel;
@property (nonatomic,strong) UILabel *joinedOnTheLineLabel_const;

///开始加入日期
@property (nonatomic,strong) UILabel *startByDateLabel;
@property (nonatomic,strong) UILabel *startByDateLabel_const;

///退出日期
@property (nonatomic,strong) UILabel *exitDateLabel;
@property (nonatomic,strong) UILabel *exitDateLabel_const;

///期限
@property (nonatomic,strong) UILabel *theTermLabel;
@property (nonatomic,strong) UILabel *theTermLabel_const;

///到期退出方式
@property (nonatomic,strong) UILabel *expiredExitMethodLabel;
@property (nonatomic,strong) UILabel *expiredExitMethodLabel_const;

///安全保障
@property (nonatomic,strong) UILabel *securityLabel;
@property (nonatomic,strong) UILabel *securityLabel_const;

///收益处理方式
@property (nonatomic,strong) UILabel *revenueApproachLabel;
@property (nonatomic,strong) UILabel *revenueApproachLabel_const;

///服务费
@property (nonatomic,strong) UIButton *serviceChargeButton;
@property (nonatomic,strong) UILabel *serviceChargeLabel;
@property (nonatomic,strong) UILabel *serviceChargeLabel_const;
@end

@implementation HXBFin_Detail_DetailsVC_Plan

- (void) setPlanDetailModel:(HXBFinDetailViewModel_PlanDetail *)planDetailModel {
    _planDetailModel = planDetailModel;
    if (!self.theTermLabel_const) {
        [self setUP];
        [self setUP_const];
        [self setUP_constStr];
        [self setUPAlignment];
        [self layoutLables];
        [self layoutLable_const];
    }
    [self setUPStr];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}


///初始化展示网络数据的lable
- (void)setUP {
    self.planAmountLabel = [[UILabel alloc]init];
    self.joinConditionLabel = [[UILabel alloc]init];
    self.joinedOnTheLineLabel = [[UILabel alloc]init];
    self.startByDateLabel = [[UILabel alloc]init];
    self.exitDateLabel = [[UILabel alloc]init];
    self.theTermLabel = [[UILabel alloc]init];
    self.expiredExitMethodLabel = [[UILabel alloc]init];
//    self.securityLabel = [[UILabel alloc]init];
    self.revenueApproachLabel = [[UILabel alloc]init];
    self.serviceChargeLabel = [[UILabel alloc]init];
    
    
    [self.view addSubview:self.planAmountLabel];
    [self.view addSubview:self.joinConditionLabel];
    [self.view addSubview:self.joinedOnTheLineLabel];
    [self.view addSubview:self.startByDateLabel];
    [self.view addSubview:self.exitDateLabel];
    [self.view addSubview:self.theTermLabel];
    [self.view addSubview:self.expiredExitMethodLabel];
//    [self.view addSubview:self.securityLabel];
    [self.view addSubview:self.revenueApproachLabel];
    [self.view addSubview:self.serviceChargeLabel];
}

///布局展示网络数据的label
- (void)layoutLables {
    kWeakSelf
    [self.planAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view);
        make.top.equalTo(@64);
        make.height.equalTo(@20);
    }];
    [self.joinConditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.planAmountLabel.mas_bottom);
        make.height.equalTo(@20);
    }];
    [self.joinedOnTheLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.joinConditionLabel.mas_bottom);
        make.height.equalTo(@20);
    }];
    [self.startByDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.joinedOnTheLineLabel.mas_bottom);
        make.height.equalTo(@20);
    }];
    [self.exitDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.startByDateLabel.mas_bottom);
        make.height.equalTo(@20);
    }];
    [self.theTermLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.exitDateLabel.mas_bottom);
        make.height.equalTo(@20);
    }];
    [self.expiredExitMethodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.theTermLabel.mas_bottom);
        make.height.equalTo(@(kScrAdaptationH(20)));
    }];
//    [self.securityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(weakSelf.view);
//        make.top.equalTo(weakSelf.expiredExitMethodLabel.mas_bottom);
//        make.height.equalTo(@20);
//    }];
    [self.revenueApproachLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.expiredExitMethodLabel.mas_bottom);
        make.height.equalTo(@20);
    }];
    [self.serviceChargeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.revenueApproachLabel.mas_bottom);
        make.height.equalTo(@20);
    }];
}


///设置展示网络数据的label的值
- (void)setUPStr {
//    HXBFinDetailModel_PlanDetail_DataList *dataList = self.planDetailModel.planDetailModel.dataList.firstObject;
    HXBFinDetailModel_PlanDetail *detailData = self.planDetailModel.planDetailModel;
    self.planAmountLabel.text = detailData.amount; //@"测试加入原因";//计化金额
    self.joinConditionLabel.text = self.planDetailModel.addCondition;//加入条件
    self.joinedOnTheLineLabel.text = self.planDetailModel.singleMaxRegisterAmount;//加入上线
    self.startByDateLabel.text = self.planDetailModel.beginSellingTime;//开始时间
    self.exitDateLabel.text = self.planDetailModel.financeEndTime;//结束时间
    self.theTermLabel.text = self.planDetailModel.lockPeriod;//期限
    self.expiredExitMethodLabel.text = @"系统通过债权转让的方式自动完成退出";
//    self.securityLabel.text = detailData.principalBalanceContractName;//安全保障
    self.revenueApproachLabel.text = @"收益再投资";//收益处理方式
    //协议
    self.serviceChargeLabel.text = self.planDetailModel.contractName;
    self.serviceChargeLabel.textColor = [UIColor blueColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickServiceChargeLabel:)];
    [self.serviceChargeLabel addGestureRecognizer:tap];
    self.serviceChargeLabel.userInteractionEnabled = true;
}
- (void)clickServiceChargeLabel:(UITapGestureRecognizer *)tap {
    //跳转 协议
    HXBFin_Detail_Detail_PlanWebViewController *planWebViewController = [[HXBFin_Detail_Detail_PlanWebViewController alloc]init];
    
    [self.navigationController pushViewController:planWebViewController animated:true];
}


///设置展示网络数据的Lable的对其方式
- (void)setUPAlignment {
    self.planAmountLabel.textAlignment = NSTextAlignmentRight;
    self.joinConditionLabel.textAlignment = NSTextAlignmentRight;
    self.joinedOnTheLineLabel.textAlignment = NSTextAlignmentRight;
    self.startByDateLabel.textAlignment = NSTextAlignmentRight;
    self.exitDateLabel.textAlignment = NSTextAlignmentRight;
    self.theTermLabel.textAlignment = NSTextAlignmentRight;
    self.expiredExitMethodLabel.textAlignment = NSTextAlignmentRight;
//    self.securityLabel.textAlignment = NSTextAlignmentRight;
    self.revenueApproachLabel.textAlignment = NSTextAlignmentRight;
    self.serviceChargeLabel.textAlignment = NSTextAlignmentRight;
}

///初始化提示label
- (void)setUP_const {
    self.planAmountLabel_const = [[UILabel alloc]init];
    self.joinConditionLabel_const = [[UILabel alloc]init];
    self.joinedOnTheLineLabel_const = [[UILabel alloc]init];
    self.startByDateLabel_const = [[UILabel alloc]init];
    self.exitDateLabel_const = [[UILabel alloc]init];
    self.theTermLabel_const = [[UILabel alloc]init];
    self.expiredExitMethodLabel_const = [[UILabel alloc]init];
//    self.securityLabel_const = [[UILabel alloc]init];
    self.revenueApproachLabel_const = [[UILabel alloc]init];
    self.serviceChargeLabel_const = [[UILabel alloc]init];
    
    
    
    [self.view addSubview:self.planAmountLabel_const];
    [self.view addSubview:self.joinConditionLabel_const];
    [self.view addSubview:self.joinedOnTheLineLabel_const];
    [self.view addSubview:self.startByDateLabel_const];
    [self.view addSubview:self.exitDateLabel_const];
    [self.view addSubview:self.theTermLabel_const];
    [self.view addSubview:self.expiredExitMethodLabel_const];
//    [self.view addSubview:self.securityLabel_const];
    [self.view addSubview:self.revenueApproachLabel_const];
    [self.view addSubview:self.serviceChargeLabel_const];
}

///为提示label赋值
- (void)setUP_constStr {
    self.planAmountLabel_const.text = @"计划金额";
    self.joinConditionLabel_const.text = @"加入条件";
    self.joinedOnTheLineLabel_const.text = @"加入上线";
    self.startByDateLabel_const.text = @"开始加入日期";
    self.exitDateLabel_const.text = @"退出日期";
    self.theTermLabel_const.text = @"期限";
    self.expiredExitMethodLabel_const.text = @"到期退出方式";
//    self.securityLabel_const.text = @"安全保障";
    self.revenueApproachLabel_const.text = @"收益处理方式";
    self.serviceChargeLabel_const.text = @"服务费";
}

///布局const
- (void)layoutLable_const {
    kWeakSelf
    [self.planAmountLabel_const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.top.equalTo(@64);
        make.height.equalTo(@20);
    }];
    [self.joinConditionLabel_const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.planAmountLabel_const.mas_bottom);
        make.height.equalTo(@20);
    }];
    [self.joinedOnTheLineLabel_const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.joinConditionLabel_const.mas_bottom);
        make.height.equalTo(@20);
    }];
    [self.startByDateLabel_const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.joinedOnTheLineLabel_const.mas_bottom);
        make.height.equalTo(@20);
    }];
    [self.exitDateLabel_const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.startByDateLabel_const.mas_bottom);
        make.height.equalTo(@20);
    }];
    [self.theTermLabel_const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.exitDateLabel_const.mas_bottom);
        make.height.equalTo(@20);
    }];
    [self.expiredExitMethodLabel_const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.theTermLabel_const.mas_bottom);
        make.height.equalTo(@(kScrAdaptationH(20)));
    }];
//    [self.securityLabel_const mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.view);
//        make.top.equalTo(weakSelf.expiredExitMethodLabel_const.mas_bottom);
//        make.height.equalTo(@20);
//    }];
    [self.revenueApproachLabel_const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.expiredExitMethodLabel_const.mas_bottom);
        make.height.equalTo(@20);
    }];
    [self.serviceChargeLabel_const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.revenueApproachLabel_const.mas_bottom);
        make.height.equalTo(@20);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

kDealloc
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
