//
//  HXBBankCardListViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/28.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBankCardListViewController.h"
#import "HXBWithdrawalsRequest.h"
#import "HXBBankListCell.h"
#import "SVGKImage.h"
#import "HXBBankList.h"
@interface HXBBankCardListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;


@property (nonatomic, strong) NSMutableArray *bankListModels;

@end

@implementation HXBBankCardListViewController


- (NSMutableArray *)bankListModels
{
    if (!_bankListModels) {
        _bankListModels = [NSMutableArray array];
    }
    return _bankListModels;
}

- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.title = @"选择银行卡";
    [self.view addSubview:self.mainTableView];
    [self settupNav];
    [self setupNavLeftBtn];
    [self loadData];
}

- (void)settupNav
{
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:kHXBFont_PINGFANGSC_REGULAR(18)};
    self.navigationController.navigationBar.barTintColor = COR19;
}

- (void)setupNavLeftBtn {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
    [button setImage:[SVGKImage imageNamed:@"back"].UIImage forState:UIControlStateNormal];
    // 让按钮内部的所有内容左对齐
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    // 修改导航栏左边的item
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadData
{
    kWeakSelf
    HXBWithdrawalsRequest *bankCardList = [[HXBWithdrawalsRequest alloc] init];
    
    [bankCardList bankCardListRequestWithSuccessBlock:^(id responseObject) {
        NSArray *bankArr = responseObject[@"data"][@"dataList"];
        [bankArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [weakSelf.bankListModels addObject:[HXBBankList yy_modelWithJSON:obj]];
        }];
        
        [weakSelf.mainTableView reloadData];
    } andFailureBlock:^(NSError *error) {
        
    }];
}

#pragma mark - UITableViewDelegate和UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.bankListModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"bankCardList";
    HXBBankListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HXBBankListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    HXBBankList *bankModel  = self.bankListModels[indexPath.row];
    cell.textLabel.text = bankModel.name;
    cell.detailTextLabel.text = bankModel.quota;
    NSLog(@"==name:%@ %@--",bankModel.name,bankModel.quota);
    cell.imageView.svgImageString = [NSString stringWithFormat:@"%@.svg",bankModel.bankCode];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.bankCardListBlock) {
        HXBBankList *bankModel  = self.bankListModels[indexPath.row];
        self.bankCardListBlock(bankModel.bankCode,bankModel.name);
    }
    [self back];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScrAdaptationH(70);
}
- (void)dealloc
{
    NSLog(@"被释放");
}
@end
