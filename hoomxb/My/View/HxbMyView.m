 //
//  HxbMyView.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbMyView.h"
#import "HxbMyViewHeaderView.h"
#import "AppDelegate.h"
#import "HxbMyViewController.h"
#import "HxbMyPlanViewController.h"
@interface HxbMyView ()
<
UITableViewDelegate,
UITableViewDataSource,
MyViewHeaderDelegate
>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) HxbMyViewHeaderView *headerView;
@property (nonatomic, strong) UIButton *signOutButton;
@end

@implementation HxbMyView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.mainTableView];
        [self.mainTableView addSubview:self.signOutButton];

    }
    return self;
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
//登出按钮事件
- (void)signOutButtonButtonClick:(UIButton *)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"%@",action.title);
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [KeyChain removeAllInfo];
        [((AppDelegate*)[UIApplication sharedApplication].delegate).mainTabbarVC setSelectedIndex:0];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
     HxbMyViewController *vc = (HxbMyViewController *)[UIResponder findNextResponderForClass:[HxbMyViewController class] ByFirstResponder:self];
    [vc presentViewController:alertController animated:YES completion:nil];
    
    //    UIViewController *VC =[[UIViewController alloc]init];
    //    VC.view.backgroundColor = [UIColor redColor];
    //    [self.navigationController pushViewController:VC animated:true];
}

#pragma TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HxbMyViewController *vc = (HxbMyViewController *)[UIResponder findNextResponderForClass:[HxbMyViewController class] ByFirstResponder:self];
        HxbMyPlanViewController *myPlanViewController = [[HxbMyPlanViewController alloc]init];
        [vc.navigationController pushViewController:myPlanViewController animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 20;
    }else{
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}

#pragma TableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *celledStr = @"celled";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celledStr ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:celledStr];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.textLabel.text = @"红利计划";
    }else if (indexPath.section == 1){
        cell.textLabel.text = @"散标";
    }else{
        cell.textLabel.text = @"交易记录";
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.tableHeaderView = self.headerView;
        _mainTableView.tableHeaderView.userInteractionEnabled = YES;
    }
    return _mainTableView;
}

- (HxbMyViewHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[HxbMyViewHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/3 + 100)];
        _headerView.delegate = self;
        _headerView.userInteractionEnabled = YES;
    }
    return _headerView;
}

//登出按钮
- (UIButton *)signOutButton{
    if (!_signOutButton) {
        _signOutButton = [UIButton btnwithTitle:@"Sign Out" andTarget:self andAction:@selector(signOutButtonButtonClick:) andFrameByCategory:CGRectMake(20, SCREEN_HEIGHT - 100, SCREEN_WIDTH - 40, 44)];
    }
    return _signOutButton;
}

@end
