//
//  HxbMyAboutMeViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbMyAboutMeViewController.h"
#import "HXBFeedbackViewController.h"
#import "HXBVersionUpdateRequest.h"//版本更新的数据请求
#import "HXBVersionUpdateViewModel.h"
#import "HXBVersionUpdateModel.h"//版本更新的model
@interface HxbMyAboutMeViewController ()
<
UITableViewDelegate,UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@end

@implementation HxbMyAboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    [self.view addSubview:self.tableView];
    self.hxb_automaticallyAdjustsScrollViewInsets = true;
}

#pragma TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    switch (indexPath.row) {
        case 0:
        {
            NSString *version = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
            HXBVersionUpdateRequest *versionUpdateRequest = [[HXBVersionUpdateRequest alloc] init];
            [versionUpdateRequest versionUpdateRequestWitversionCode:version andSuccessBlock:^(id responseObject) {
                HXBVersionUpdateViewModel *versionUpdateVM = [[HXBVersionUpdateViewModel alloc] init];
                versionUpdateVM.versionUpdateModel = [HXBVersionUpdateModel yy_modelWithDictionary:responseObject[@"data"]];
                
            } andFailureBlock:^(NSError *error) {
                
            }];
        }
            break;
        case 1:
        {
//            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"4001551888"];
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            [HXBAlertManager callupWithphoneNumber:@"4001551888" andWithMessage:@"联系客服"];
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            HXBFeedbackViewController *feedbackVC = [[HXBFeedbackViewController alloc]init];
            [self.navigationController pushViewController:feedbackVC animated:YES];
        }
            break;
        default:
            break;
    }
    
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
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
    
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if (indexPath.row == 0) {
            cell.textLabel.text = @"版本";
            NSString *version = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
            cell.detailTextLabel.text = version;
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"客服人热线";
            cell.detailTextLabel.text = @"400-1551-888";
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"常见问题";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            cell.textLabel.text = @"意见反馈";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
  
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView  alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH , SCREEN_HEIGHT/2 - 150)];
        _headerView.backgroundColor = COR1;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        imageView.center = CGPointMake(SCREEN_WIDTH/2, _headerView.height/2);
        imageView.backgroundColor = [UIColor whiteColor];
        [_headerView addSubview:imageView];
    }
    return _headerView;
}
@end
