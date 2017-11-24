 //
//  HxbMyView.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbMyView.h"
#import "HxbMyViewHeaderView.h"
#import "AppDelegate.h"
#import "HxbMyViewController.h"
#import "HXBMyCouponViewController.h"   // 优惠券
#import "HXBMY_PlanListViewController.h"///plan 列表的VC
#import "HXBMY_LoanListViewController.h"///散标 列表的VC
#import "HXBMY_CapitalRecordViewController.h"//资产记录
#import "HXBMyHomeViewCell.h"
#import "HXBMyRequestAccountModel.h"
#import "HXBBannerWebViewController.h"

@interface HxbMyView ()
<
UITableViewDelegate,
UITableViewDataSource,
MyViewHeaderDelegate
>
@property (nonatomic, strong) HXBBaseTableView *mainTableView;
@property (nonatomic, strong) HxbMyViewHeaderView *headerView;
//@property (nonatomic, strong) UIButton *signOutButton;
@property (nonatomic, copy) void(^clickAllFinanceButtonWithBlock)(UILabel *button);
@end

@implementation HxbMyView
///点击了 总资产
- (void)clickAllFinanceButtonWithBlock: (void(^)(UILabel * button))clickAllFinanceButtonBlock{
    self.clickAllFinanceButtonWithBlock = clickAllFinanceButtonBlock;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.mainTableView];
    }
    return self;
}


/**
 数据模型的set方法
 */
- (void)setUserInfoViewModel:(HXBRequestUserInfoViewModel *)userInfoViewModel
{
    _userInfoViewModel = userInfoViewModel;
    self.headerView.userInfoViewModel = userInfoViewModel;
}

- (void)setAccountModel:(HXBMyRequestAccountModel *)accountModel{
    _accountModel = accountModel;
    self.headerView.accountInfoViewModel = accountModel;
    [self.mainTableView reloadData];
}

- (void)didClickLeftHeadBtn:(UIButton *)sender{
    [self.delegate didLeftHeadBtnClick:sender];
   
}
-(void)didClickTopUpBtn:(UIButton *)sender{
    [self.delegate didClickTopUpBtn:sender];
}

- (void)didClickWithdrawBtn:(UIButton *)sender{
    [self.delegate didClickWithdrawBtn:sender];
}
- (void)didClickRightHeadBtn{
    
}
////登出按钮事件
//- (void)signOutButtonButtonClick:(UIButton *)sender{
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//        NSLog(@"%@",action.title);
//    }];
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        [KeyChain signOut];
//        [(HXBBaseTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController setSelectedIndex:0];
//    }];
//    [alertController addAction:cancelAction];
//    [alertController addAction:okAction];
//     HxbMyViewController *vc = (HxbMyViewController *)[UIResponder findNextResponderForClass:[HxbMyViewController class] ByFirstResponder:self];
//    [vc presentViewController:alertController animated:YES completion:nil];
//    
//    //    UIViewController *VC =[[UIViewController alloc]init];
//    //    VC.view.backgroundColor = [UIColor redColor];
//    //    [self.navigationController pushViewController:VC animated:true];
//}

- (void)setIsStopRefresh_Home:(BOOL)isStopRefresh_Home{
    _isStopRefresh_Home = isStopRefresh_Home;
    if (isStopRefresh_Home) {
        [self.mainTableView.mj_footer endRefreshing];
        [self.mainTableView.mj_header endRefreshing];
    }
}

#pragma TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            HxbMyViewController *vc = (HxbMyViewController *)[UIResponder findNextResponderForClass:[HxbMyViewController class] ByFirstResponder:self];
            HXBMyCouponViewController *myCouponsViewController = [[HXBMyCouponViewController alloc]init];
            [vc.navigationController pushViewController:myCouponsViewController animated:YES];
        } else {
            HxbMyViewController *VC = (HxbMyViewController *)[UIResponder findNextResponderForClass:[HxbMyViewController class] ByFirstResponder:self];
            HXBBannerWebViewController *webViewVC = [[HXBBannerWebViewController alloc] init];
            webViewVC.pageUrl = kHXBH5_InviteDetailURL;
            [VC.navigationController pushViewController:webViewVC animated:true];
        }
    }
    if (indexPath.section == 1) {//第一组： plan
        if (indexPath.row == 0) {
            HxbMyViewController *vc = (HxbMyViewController *)[UIResponder findNextResponderForClass:[HxbMyViewController class] ByFirstResponder:self];
            HXBMY_PlanListViewController *myPlanViewController = [[HXBMY_PlanListViewController alloc]init];
            [vc.navigationController pushViewController:myPlanViewController animated:YES];
        }else
        {
            HxbMyViewController *VC = (HxbMyViewController *)[UIResponder findNextResponderForClass:[HxbMyViewController class] ByFirstResponder:self];
            HXBMY_LoanListViewController *loanListViewController = [[HXBMY_LoanListViewController alloc]init];
            [VC.navigationController pushViewController:loanListViewController animated:true];
        }
    }
    if (indexPath.section == 2) {
        HxbMyViewController *VC = (HxbMyViewController *)[UIResponder findNextResponderForClass:[HxbMyViewController class] ByFirstResponder:self];
        HXBMY_CapitalRecordViewController *capitalRecordViewController = [[HXBMY_CapitalRecordViewController alloc]init];
        [VC.navigationController pushViewController:capitalRecordViewController animated:true];
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScrAdaptationH(44.5);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return 0.1f;
    }else{
        return kScrAdaptationH750(100);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 0.1f;
    }else{
        return kScrAdaptationH750(20);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *supV = nil;
    if (section !=0&&section !=1) {
        return nil;
    }else{
        supV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH750(100))];
        supV.backgroundColor = [UIColor whiteColor];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(kScrAdaptationW750(30), kScrAdaptationH750(35), kScrAdaptationW750(200), kScrAdaptationH750(30))];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
        lab.textColor = RGBA(51, 51, 51, 1);
        UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, supV.frame.size.height-1, kScreenWidth, 1)];
        lineV.backgroundColor = RGBA(244, 243, 248, 1);
        [supV addSubview:lineV];
        [supV addSubview:lab];
        if (section == 0) {
            lab.text = @"我的福利";
        }else if (section == 1){
            lab.text = @"我的资产";
        }
        return supV;
    }
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    switch (section) {
//        case 0:
//            return @"我的福利";
//        case 1:
//            return @"我的资产";
//        default:
//            return @"";
//    }
//}

#pragma TableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *celledStr = @"celled";
    HXBMyHomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celledStr];
    if (cell == nil) {
        cell = [[HXBMyHomeViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:celledStr];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
        cell.textLabel.textColor = COR6;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"优惠券";
            cell.textLabel.textColor = RGBA(102, 102, 102, 1);
            if (self.accountModel.availableCouponCount) {
                NSString *str = [NSString stringWithFormat:@"您有%lld张优惠券",self.accountModel.availableCouponCount];
                NSRange range = NSMakeRange(2, str.length - 6);
                NSAttributedString *serverViewAttributedStr = [NSAttributedString setupAttributeStringWithString:str WithRange:range andAttributeColor:RGBA(255, 33, 33, 1) andAttributeFont:kHXBFont_PINGFANGSC_REGULAR_750(24)];
                cell.desc = serverViewAttributedStr;
            } else {
                cell.desc = @"";
            }
            cell.isShowLine = YES;
        } else {
            cell.textLabel.text = @"邀请好友";
            cell.textLabel.textColor = RGBA(102, 102, 102, 1);
            cell.isShowLine = NO;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"红利计划资产";
            cell.textLabel.textColor = RGBA(102, 102, 102, 1);
//            cell.imageView.svgImageString = @"hongli.svg";
            cell.desc = [NSString hxb_getPerMilWithDouble:self.accountModel.financePlanAssets];
            cell.isShowLine = YES;
        }else
        {
            cell.textLabel.text = @"散标债权资产";
            cell.textLabel.textColor = RGBA(102, 102, 102, 1);
            cell.desc = [NSString hxb_getPerMilWithDouble:self.accountModel.lenderPrincipal];
//            cell.imageView.svgImageString = @"sanbiao.svg";
            cell.isShowLine = NO;
        }
    }else{
        cell.textLabel.text = @"交易记录";
        cell.isShowLine = NO;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        return 2;
    } else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (HXBBaseTableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[HXBBaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49) style:UITableViewStyleGrouped];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.tableHeaderView = self.headerView;
        _mainTableView.tableHeaderView.userInteractionEnabled = YES;
        _mainTableView.backgroundColor = kHXBColor_BackGround;
        kWeakSelf
        [_mainTableView hxb_GifHeaderWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
            if (weakSelf.homeRefreshHeaderBlock) weakSelf.homeRefreshHeaderBlock();
        } andSetUpGifHeaderBlock:^(MJRefreshGifHeader *gifHeader) {
            
        }];
    }
    return _mainTableView;
}

- (HxbMyViewHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[HxbMyViewHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kScrAdaptationH750(575+43))];//kScrAdaptationH(276)//575
        _headerView.delegate = self;
        _headerView.userInteractionEnabled = YES;
        kWeakSelf
        [_headerView clickAllFinanceButtonWithBlock:^(UILabel * _Nullable button) {
            if (weakSelf.clickAllFinanceButtonWithBlock) {
                weakSelf.clickAllFinanceButtonWithBlock(button);
            }
        }];
    }
    return _headerView;
}

////登出按钮
//- (UIButton *)signOutButton{
//    if (!_signOutButton) {
//        _signOutButton = [UIButton btnwithTitle:@"Sign Out" andTarget:self andAction:@selector(signOutButtonButtonClick:) andFrameByCategory:CGRectMake(20, SCREEN_HEIGHT - 100, SCREEN_WIDTH - 40, 44)];
//    }
//    return _signOutButton;
//}

@end
