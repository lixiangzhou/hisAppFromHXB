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

@interface HxbMyView ()
<
UITableViewDelegate,
UITableViewDataSource
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
    
    id next = [self nextResponder];
    while (![next isKindOfClass:[HxbMyViewController class]]) {
        next = [next nextResponder];
    }
    if ([next isKindOfClass:[HxbMyViewController class]]) {
        HxbMyViewController *vc = (HxbMyViewController *)next;
       [vc presentViewController:alertController animated:YES completion:nil];
    }
    
    //    UIViewController *VC =[[UIViewController alloc]init];
    //    VC.view.backgroundColor = [UIColor redColor];
    //    [self.navigationController pushViewController:VC animated:true];
    
}

#pragma TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

#pragma TableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *celledStr = @"celled";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celledStr ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:celledStr];
        
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
        _mainTableView = [[UITableView alloc]initWithFrame:self.frame style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.tableHeaderView = self.headerView;
    }
    return _mainTableView;
}

- (HxbMyViewHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[HxbMyViewHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/3)];
    }
    return _headerView;
}

//登出按钮
- (UIButton *)signOutButton{
    if (!_signOutButton) {
        _signOutButton = [UIButton btnwithTitle:@"Sign Out" andTarget:self andAction:@selector(signOutButtonButtonClick:) andFrameByCategory:CGRectMake(20, SCREEN_HEIGHT/2 + 100, SCREEN_WIDTH - 40, 44)];
    }
    return _signOutButton;
}

@end