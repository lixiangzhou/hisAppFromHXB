//
//  HXBFinBuy_plan_ViewController.m
//  hoomxb
//
//  Created by HXB on 2017/6/16.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinBuy_plan_ViewController.h"
#import "HXBJoinImmediateView.h"
#import "HXBFinDetailViewModel_PlanDetail.h"
@class HXBJoinImmediateView_Model;

@interface HXBFinBuy_plan_ViewController ()
@property (nonatomic,strong) UILabel *successLabel;
@property (nonatomic,strong) UILabel *label;
@end

@implementation HXBFinBuy_plan_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)setUPValueWithJoinImmediateView_Model:(HXBJoinImmediateView_Model *)model {
    kWeakSelf
    ///预计收益Const
    model.profitLabel_consttStr = @"预期收益";
    ///服务协议
    model.negotiateLabelStr = @"我已阅读并同意";
    ///余额 title
    model.balanceLabel_constStr = @"可用余额";
    ///充值的button str
    model.rechargeButtonStr = @"充值";
    ///一键购买的str
    model.buyButtonStr = @"一键购买";
    ///收益方式
    model.profitTypeLable_ConstStr = @"收益处理方式";
    ///加入上限
    model.upperLimitLabel_constStr = @"本期计划加入上限";
    ///收益方法
    model.profitTypeLabelStr = weakSelf.planViewModel.profitType;
    /// ￥1000起投，1000递增 placeholder
    model.rechargeViewTextField_placeholderStr = weakSelf.planViewModel.addCondition;
    
    ///余额展示
    model.balanceLabelStr = weakSelf.planViewModel.userRemainAmount;
    
    ///预计收益 在 加入计划的 view 内部计算
    
    
    ///服务协议 button str
    model.negotiateButtonStr = weakSelf.planViewModel.contractName;
    model.totalInterest = weakSelf.planViewModel.totalInterest;
    ///加入上线
    model.upperLimitLabelStr = weakSelf.planViewModel.singleMaxRegisterAmount;
    ///确认加入的Buttonstr
    model.addButtonStr = @"确认加入";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
