//
//  HXBMyCouponListViewController.m
//  hoomxb
//
//  Created by hxb on 2017/10/30.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyCouponListViewController.h"
#import "HXBMyCouponListView.h"
#import "HXBRequestAccountInfo.h"
#import "HXBMyCouponListModel.h"

static NSString *const MyCouponList_Request_ParameterFilter = @"available";

@interface HXBMyCouponListViewController (){
    int _page;
    NSString* _filter;
}

@property (nonatomic, strong) HXBMyCouponListView *myView;
@property (nonatomic, strong) NSDictionary *parameterDict;
//@property (nonatomic, strong) HXBMyCouponListModel *myCouponListModel;
//数据数组
@property (nonatomic,strong) NSArray <HXBMyCouponListModel*>* myCouponListModelArray;

@end

@implementation HXBMyCouponListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setParameter];
    
    [self setupSubView];
}

- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
    [self loadData_myCouponListInfo];
}

- (void)setParameter{
    _page = 1;
    _filter = MyCouponList_Request_ParameterFilter;//未使用
}

- (void)setupSubView{
    kWeakSelf
    self.myView = [[HXBMyCouponListView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.myView.userInteractionEnabled = YES;
    self.myView.homeRefreshHeaderBlock = ^(){
        [weakSelf loadData_myCouponListInfo];
    };
    
    [self.view addSubview:self.myView];
}
//主要是给数据源赋值然后刷新UI
- (void)setMyCouponListModelArray:(NSArray<HXBMyCouponListModel *> *)myCouponListModelArray{
    _myCouponListModelArray = myCouponListModelArray;
    self.myView.myCouponListModelArray = myCouponListModelArray;
//    [self.contDwonManager countDownWithModelArray:finPlanListVMArray andModelDateKey:nil  andModelCountDownKey:nil];
}

//- (void)setMyCouponListModel:(HXBMyCouponListModel *)myCouponListModel{
//    _myCouponListModel = myCouponListModel;
////    self.myView.myCouponListModel = self.myCouponListModel;
//    self.myView.myCouponListModelArray =
//}

#pragma mark - 加载数据
- (void)loadData_myCouponListInfo{
    kWeakSelf
    [HXBRequestAccountInfo downLoadMyAccountListInfoNoHUDWithParameterDict:self.parameterDict withSeccessBlock:^(NSArray<HXBMyCouponListModel *> *modelArray) {
        weakSelf.myCouponListModelArray = modelArray;
        weakSelf.myView.isStopRefresh_Home = YES;
    } andFailure:^(NSError *error) {
        weakSelf.myView.isStopRefresh_Home = YES;
    }];
}

- (NSDictionary *)parameterDict{
    if (!_parameterDict) {
        _parameterDict = @{@"page":[NSString stringWithFormat:@"%d",_page],@"filter":_filter};
    }
    return _parameterDict;
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
