//
//  HXBMY_AllFinanceViewController.m
//  hoomxb
//
//  Created by HXB on 2017/6/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_AllFinanceViewController.h"
#import "HXBMY_AllFinanceView.h"
@interface HXBMY_AllFinanceViewController ()
@property (nonatomic,strong) HXBMY_AllFinanceView *allFinanceView;
@end

@implementation HXBMY_AllFinanceViewController
- (HXBMY_AllFinanceView *)allFinanceView {
    if (!_allFinanceView) {
        _allFinanceView = [[HXBMY_AllFinanceView alloc]init];
    }
    return _allFinanceView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.hxbBaseVCScrollView addSubview:self.allFinanceView];
    self.hxb_automaticallyAdjustsScrollViewInsets = true;
    self.allFinanceView.frame = self.view.frame;
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
