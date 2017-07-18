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
@interface HXBBankCardListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSMutableArray *keyArr;

@property (nonatomic, strong) NSMutableArray *objArr;

@end

@implementation HXBBankCardListViewController

- (NSMutableArray *)keyArr
{
    if (!_keyArr) {
        _keyArr = [NSMutableArray array];
    }
    return _keyArr;
}

- (NSMutableArray *)objArr
{
    if (!_objArr) {
        _objArr = [NSMutableArray array];
    }
    return _objArr;
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
            [weakSelf.keyArr addObject:obj[@"bankCode"]];
            [weakSelf.objArr addObject:obj[@"bankName"]];
        }];
        
        [weakSelf.mainTableView reloadData];
    } andFailureBlock:^(NSError *error) {
        
    }];
}

#pragma mark - UITableViewDelegate和UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.objArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"bankCardList";
    HXBBankListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HXBBankListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.objArr[indexPath.row];
    cell.detailTextLabel.text = @"单笔10万";
    cell.imageView.image = [UIImage imageNamed:@"zhaoshang"];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.bankCardListBlock) {
        self.bankCardListBlock(self.keyArr[indexPath.row],self.objArr[indexPath.row]);
    }
    [self back];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScrAdaptationH(70);
}
@end
