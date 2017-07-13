//
//  HXBNoticeViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBNoticeViewController.h"
#import "HXBVersionUpdateRequest.h"
#import "HXBNoticModel.h"
@interface HXBNoticeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTabelView;

@property (nonatomic, strong) NSArray<HXBNoticModel *> *modelArrs;
@end

@implementation HXBNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公告";
    self.isColourGradientNavigationBar = YES;
    [self.view addSubview:self.mainTabelView];
    
    [self loadData];
 
}

- (void)loadData
{
    kWeakSelf
    HXBVersionUpdateRequest *versionUpdateRequest = [[HXBVersionUpdateRequest alloc] init];
    //公告请求接口
    [versionUpdateRequest noticeRequestWithSuccessBlock:^(id responseObject) {
        weakSelf.modelArrs = [NSArray yy_modelArrayWithClass:[HXBNoticModel class] json:responseObject[@"data"][@"dataList"]];
        [weakSelf.mainTabelView reloadData];
    } andFailureBlock:^(NSError *error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArrs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"HXBNoticeViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    HXBNoticModel *noticModel = self.modelArrs[indexPath.row];
    cell.textLabel.text = noticModel.title;
    cell.detailTextLabel.text = [[HXBBaseHandDate sharedHandleDate] stringFromDate:noticModel.date andDateFormat:@"yyyy-MM-dd"];
    return cell;
}
#pragma mark - 懒加载
- (UITableView *)mainTabelView
{
    if (!_mainTabelView) {
        _mainTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        _mainTabelView.delegate = self;
        _mainTabelView.dataSource = self;
    }
    return _mainTabelView;
}



@end
