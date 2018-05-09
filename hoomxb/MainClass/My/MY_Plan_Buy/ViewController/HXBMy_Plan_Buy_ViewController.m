//
//  HXBMy_Plan_Buy_ViewController.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/3/9.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBMy_Plan_Buy_ViewController.h"
#import "HXBJoinImmediateView.h"
#import "HXBFinModel_Buy_Plan.h"
#import "HXBFinDetailViewModel_PlanDetail.h"
#import "HXBFinDetailModel_PlanDetail.h"
#import "HXBMiddlekey.h"
#import "HxbMyTopUpViewController.h"
#import "HxbWithdrawCardViewController.h"
#import "HXBMyPlanBuyViewModel.h"

@interface HXBMy_Plan_Buy_ViewController ()

@property (nonatomic,strong) HXBJoinImmediateView *joinimmediateView;
@property (nonatomic,copy) void (^clickLookMYInfoButtonBlock)();
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,copy) void(^trackingScrollViewBlock)(UIScrollView *scrollView);
@property (nonatomic,copy) NSString *assetsTotal; ///个人总资产
@property (nonatomic, strong) HXBMyPlanBuyViewModel *viewModel;

@end

@implementation HXBMy_Plan_Buy_ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    kWeakSelf
    self.viewModel = [[HXBMyPlanBuyViewModel alloc] initWithBlock:^UIView *{
        return weakSelf.view;
    }];
    
    [self.tableView hxb_headerWithRefreshBlock:^{
        [weakSelf.tableView endRefresh];
    }];
    self.tableView.backgroundColor = kHXBColor_BackGround;
    self.isColourGradientNavigationBar = YES;
    
    ///UI的搭建
    [self setUPViews];
    
    //传递值
    [self setValue];
    
    //事件的传递
    [self registerEvent];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //请求 个人数据
    kWeakSelf
    [_viewModel downLoadUserInfo:YES resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.availablePoint = weakSelf.viewModel.userInfoModel.userInfoModel.userAssets.availablePoint;
            weakSelf.assetsTotal = weakSelf.viewModel.userInfoModel.userInfoModel.userAssets.assetsTotal;
        }
    }];
}

- (void)dealloc {
    [self.tableView.panGestureRecognizer removeObserver: self forKeyPath:@"state"];
    NSLog(@"✅被销毁 %@",self);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"state"]) {
        NSNumber *tracking = change[NSKeyValueChangeNewKey];
        if (tracking.integerValue == UIGestureRecognizerStateBegan && self.trackingScrollViewBlock) {
            self.trackingScrollViewBlock(self.tableView);
        }
        return;
    }
    
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:nil];
}


#pragma mark - UI

- (void)setUPViews {
    kWeakSelf
    self.joinimmediateView = [[HXBJoinImmediateView alloc] init];
    [self.tableView addSubview:self.joinimmediateView];
    
    self.trackingScrollViewBlock = ^(UIScrollView *scrollView) {
        weakSelf.joinimmediateView.isEndEditing = YES;
    };
    
    self.joinimmediateView.frame = CGRectMake(0, HXBStatusBarAndNavigationBarHeight, kScreenWidth, kScreenHeight - HXBStatusBarAndNavigationBarHeight);
}

#pragma mark - Network


#pragma mark - Action
- (void) registerEvent {
    [self regisgerTopUP];//充值
    [self registerBuy];//一键购买
    [self registerAdd];//加入
    [self registerNegotiate];//点击了 服务协议
}

- (void) pushTopUPViewControllerWithAmount:(NSString *)amount {
    kWeakSelf
    [_viewModel downLoadUserInfo:YES resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            if ([weakSelf.viewModel.userInfoModel.userInfoModel.userInfo.isCashPasswordPassed isEqualToString:@"1"] && [weakSelf.viewModel.userInfoModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"0"])
            {
                if (weakSelf.viewModel.userInfoModel.userInfoModel.userInfo.isUnbundling) {
                    [HXBAlertManager callupWithphoneNumber:kServiceMobile andWithTitle:@"温馨提示" Message:[NSString stringWithFormat:@"您的身份信息不完善，请联系客服 %@", kServiceMobile]];
                    return;
                }
                //进入绑卡界面
                HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc]init];
                withdrawCardViewController.title = @"绑卡";
                withdrawCardViewController.type = HXBRechargeAndWithdrawalsLogicalJudgment_Recharge;
                [weakSelf.navigationController pushViewController:withdrawCardViewController animated:YES];
            }else
            {
                HxbMyTopUpViewController *hxbMyTopUpViewController = [[HxbMyTopUpViewController alloc]init];
                hxbMyTopUpViewController.amount = amount;
                [weakSelf.navigationController pushViewController:hxbMyTopUpViewController animated:YES];
            }
        }
    }];
}


- (void) regisgerTopUP {
    kWeakSelf
    ///点击了充值
    [self.joinimmediateView clickRechargeFunc:^{
        [self pushTopUPViewControllerWithAmount: [NSString stringWithFormat:@"%@.00",weakSelf.joinimmediateView.rechargeViewTextField.text]];
    }];
}
- (void) registerBuy {
    kWeakSelf
    [self.joinimmediateView clickBuyButtonFunc:^(NSString *capitall, UITextField *textField) {
        NSString *str = nil;
        if (weakSelf.planViewModel.planDetailModel.userRemainAmount.floatValue < weakSelf.planViewModel.planDetailModel.remainAmount.floatValue) {
            str = weakSelf.planViewModel.planDetailModel.userRemainAmount;
        }else {
            str = weakSelf.planViewModel.planDetailModel.remainAmount;
        }
        if (str.integerValue == 0) {
            [HxbHUDProgress showTextWithMessage:@"本期加入已达上限"];
        } else {
            textField.text = [NSString stringWithFormat:@"%ld",str.integerValue];
            
        }
    }];
}
- (void)registerAdd {
    kWeakSelf
    ///点击了加入
    [self.joinimmediateView clickAddButtonFunc:^(UITextField *textField,NSString *capital) {
        // 先判断是否>=1000，再判断是否为1000的整数倍（追加时只需判断是否为1000的整数倍），错误，toast提示“起投金额1000元”或“投资金额应为1000的整数倍
        NSInteger minRegisterAmount = weakSelf.planViewModel.minRegisterAmount.integerValue;
        if (capital.length == 0) {
            [HxbHUDProgress showMessageCenter:@"请输入出借金额" inView:self.view];
            return ;
        }
        if ((capital.floatValue < minRegisterAmount)) {
            NSLog(@"请输入大于等于1000");
            [HxbHUDProgress showMessageCenter:[NSString stringWithFormat:@"起投金额%ld元",minRegisterAmount] inView:self.view];
            return;
        }
        
        NSInteger minRegisterAmountInteger = minRegisterAmount;
        if ((capital.integerValue % minRegisterAmountInteger) != 0) {
            NSLog(@"1000的整数倍");
            NSString *message = [NSString stringWithFormat:@"出借金额应为%ld的整数倍",(long)minRegisterAmountInteger];
            [HxbHUDProgress showMessageCenter:message inView:self.view];
            return;
        }
        ///查看是否大于上线
        NSString *str = nil;
        if (weakSelf.planViewModel.planDetailModel.userRemainAmount.floatValue < weakSelf.planViewModel.planDetailModel.remainAmount.floatValue) {
            str = weakSelf.planViewModel.planDetailModel.userRemainAmount;
            
        }else {
            str = weakSelf.planViewModel.planDetailModel.remainAmount;
        }
        /// 加入上线  为0
        if (capital.doubleValue > str.doubleValue) {
            [HxbHUDProgress showTextWithMessage:@"加入金额超过上限"];
            textField.text = [NSString stringWithFormat:@"%ld",str.integerValue];
            return;
        }
        
        //是否大于用户剩余金额
        if (capital.integerValue > weakSelf.viewModel.userInfoModel.userInfoModel.userAssets.availablePoint.floatValue) {
            NSLog(@"%@",@"输入金额大于了剩余可投金额");
            [HxbHUDProgress showMessageCenter:@"余额不足，请先充值" inView:self.view andBlock:^{
                
                [self pushTopUPViewControllerWithAmount: [NSString stringWithFormat:@"%@.00",capital]];
            }];
            
            return;
        }
        //是否大于计划剩余金额
        if (capital.integerValue > weakSelf.planViewModel.planDetailModel.remainAmount.floatValue) {
            //            NSString *amount = [NSString stringWithFormat:@"%.2lf",(capital.integerValue - self.assetsTotal.floatValue)];
            [HxbHUDProgress showMessageCenter:@"输入金额大于了剩余可投金额" inView:self.view];
            textField.text = [NSString stringWithFormat:@"%ld",weakSelf.planViewModel.planDetailModel.remainAmount.integerValue];
            return;
        }
        //判断是否安全认证
        kWeakSelf
        NSDictionary *dic_post = @{@"amount" : capital, @"cashType" : self.planViewModel.profitType};
        [_viewModel myPlanBuyReslutWithPlanID:weakSelf.planViewModel.ID parameter:dic_post resultBlock:^(BOOL isSuccess) {
            if (isSuccess) {
                HXBFBase_BuyResult_VC *planBuySuccessVC = [[HXBFBase_BuyResult_VC alloc] init];
                planBuySuccessVC.imageName = @"successful";
                planBuySuccessVC.buy_title = @"加入成功";
                planBuySuccessVC.isShowInviteBtn = NO;
                planBuySuccessVC.buy_description = weakSelf.viewModel.resultModel.lockStart;
                planBuySuccessVC.buy_ButtonTitle = @"查看我的出借";
                planBuySuccessVC.title = @"加入成功";
                [planBuySuccessVC clickButtonWithBlock:^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowMYVC_PlanList object:nil];
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                }];
                [weakSelf.navigationController pushViewController:planBuySuccessVC animated:YES];
            } else {
                HXBFBase_BuyResult_VC *failViewController = [[HXBFBase_BuyResult_VC alloc]init];
                failViewController.title = @"出借结果";
                switch (weakSelf.viewModel.errorCode) {
                    case kBuy_Result:
                        failViewController.imageName = @"failure";
                        failViewController.buy_title = weakSelf.viewModel.errorMessage;
                        failViewController.buy_ButtonTitle = @"重新出借";
                        break;
                        
                    case kBuy_Processing:
                        failViewController.imageName = @"outOffTime";
                        failViewController.buy_title = weakSelf.viewModel.errorMessage;
                        failViewController.buy_ButtonTitle = @"重新出借";
                        break;
                        
                    default:
                        return ;
                }
                [failViewController clickButtonWithBlock:^{
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];  //跳回理财页面
                }];
                [weakSelf.navigationController pushViewController:failViewController animated:YES];
            }
        }];
        
    }];
}
//点击了 服务协议
- (void)registerNegotiate {
    kWeakSelf
    [self.joinimmediateView clickNegotiateButtonFunc:^{
        [HXBBaseWKWebViewController pushWithPageUrl:[NSString splicingH5hostWithURL:kHXB_Negotiate_ServePlanURL] fromController:weakSelf];
    }];
}

- (void)clickLookMYInfoButtonWithBlock: (void(^)())clickLoockMYInfoButton {
    self.clickLookMYInfoButtonBlock = clickLoockMYInfoButton;
}

#pragma mark - Setter / Getter / Lazy

- (void)setIsPlan:(BOOL)isPlan {
    _isPlan = isPlan;
    self.joinimmediateView.isPlan = isPlan;
}

- (void)setValue {
    [self setUPModel];
    
    kWeakSelf
    [self.viewModel downLoadUserInfo:YES resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf setUPModel];
        }
    }];
}
///赋值
- (void) setUPModel {
    kWeakSelf
    [self.joinimmediateView setUPValueWithModelBlock:^HXBJoinImmediateView_Model *(HXBJoinImmediateView_Model *model) {
        ///预计收益Const
        model.profitLabel_consttStr = @"预期收益";
        ///服务协议
        model.negotiateLabelStr = @"红利智投服务协议";
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
        ///余额 title
        model.balanceLabelStr = [NSString hxb_getPerMilWithDouble:weakSelf.viewModel.userInfoModel.userInfoModel.userAssets.availablePoint.floatValue];
        ///收益方法
        model.profitTypeLabelStr = weakSelf.planViewModel.profitType_UI;
        /// ￥1000起投，1000递增 placeholder
        model.rechargeViewTextField_placeholderStr = weakSelf.planViewModel.addCondition;
        
        ///服务协议 button str
        model.negotiateButtonStr = weakSelf.planViewModel.contractName;
        model.totalInterest = weakSelf.planViewModel.totalInterest;
        
        ///加入上线 (min (用户可投， 本期剩余))
        if (weakSelf.planViewModel.planDetailModel.userRemainAmount.floatValue < weakSelf.planViewModel.planDetailModel.remainAmount.floatValue) {
            model.upperLimitLabelStr = weakSelf.planViewModel.planDetailModel.userRemainAmount;
        }else {
            model.upperLimitLabelStr = weakSelf.planViewModel.planDetailModel.remainAmount;
        }
        
        ///确认加入的Buttonstr
        model.addButtonStr = @"确认加入";
        return model;
    }];
}

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        
        [self.view insertSubview:_tableView atIndex:0];
        [_tableView.panGestureRecognizer addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor = kHXBColor_BackGround;
        [HXBMiddlekey AdaptationiOS11WithTableView:_tableView];
    }
    return _tableView;
}


@end
