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
#import "HXBAgreementView.h"
#import "HXBBottomLineTableViewCell.h"
@interface HxbMyAboutMeViewController ()
<
UITableViewDelegate,UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@end

@implementation HxbMyAboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    [self.view addSubview:self.tableView];
    [self setupSubViewFrame];
}

- (void)setupSubViewFrame
{
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.headerView);
    }];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView).offset(kScrAdaptationH750(220));
        make.centerX.equalTo(self.headerView);
        make.width.offset(kScrAdaptationW750(260));
        make.height.offset(kScrAdaptationW750(260));
    }];
}

#pragma TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    switch (indexPath.row) {
        case 0:
        {
//            NSString *version = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
//            HXBVersionUpdateRequest *versionUpdateRequest = [[HXBVersionUpdateRequest alloc] init];
//            [versionUpdateRequest versionUpdateRequestWitversionCode:version andSuccessBlock:^(id responseObject) {
//                HXBVersionUpdateViewModel *versionUpdateVM = [[HXBVersionUpdateViewModel alloc] init];
//                versionUpdateVM.versionUpdateModel = [HXBVersionUpdateModel yy_modelWithDictionary:responseObject[@"data"]];
//                
//            } andFailureBlock:^(NSError *error) {
//                
//            }];
            [HXBAlertManager callupWithphoneNumber:kServiceMobile andWithTitle:@"红小宝客服电话" Message:kServiceMobile];
        }
            break;
        case 1:
        {
//            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"4001551888"];
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            //意见反馈
            HXBFeedbackViewController *feedbackVC = [[HXBFeedbackViewController alloc]init];
            [self.navigationController pushViewController:feedbackVC animated:YES];
        }
            break;
        default:
            break;
    }
    
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScrAdaptationH750(90);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kScrAdaptationH750(20);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}

#pragma TableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *celledStr = @"celled";
    HXBBottomLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celledStr ];
    if (cell == nil) {
        cell = [[HXBBottomLineTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:celledStr];
        cell.textLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
        cell.textLabel.textColor = COR6;
        cell.detailTextLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
        cell.detailTextLabel.textColor = COR8;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if (indexPath.row == 0) {
            cell.textLabel.attributedText = [self call];
            cell.detailTextLabel.text = kServiceMobile;
           
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"版本";
            NSString *version = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"v%@",version];
            cell.hiddenLine = YES;
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"常见问题";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            cell.textLabel.text = @"意见反馈";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
  
    return cell;
}

- (NSMutableAttributedString *)call
{
    NSString *str = @"客服热线（周一至周五9:00-19:00）";
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    [attributedStr addAttribute:NSFontAttributeName
     
                          value:kHXBFont_PINGFANGSC_REGULAR_750(24)
     
                          range:NSMakeRange(4, str.length - 4)];
    
    [attributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:COR10
     
                          range:NSMakeRange(4, str.length - 4)];

    return attributedStr;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView  alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth , kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH , kScrAdaptationH750(600))];
       
        [_headerView addSubview:self.backgroundImageView];
        [_headerView addSubview:self.logoImageView];
    }
    return _headerView;
}
- (UIImageView *)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScrAdaptationW750(260), kScrAdaptationW750(260))];
        _logoImageView.svgImageString = @"logo";
    }
    return _logoImageView;
}

- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _backgroundImageView.svgImageString = @"bj";
    }
    return _backgroundImageView;
}
@end
