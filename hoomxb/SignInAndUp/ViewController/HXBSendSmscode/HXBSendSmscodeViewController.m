//
//  HXBSendSmscodeViewController.m
//  hoomxb
//
//  Created by HXB on 2017/6/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBSendSmscodeViewController.h"
#import "HXBSendSmscodeView.h"///发送短信的view

///短信验证 VC
@interface HXBSendSmscodeViewController ()
@property (nonatomic,strong) HXBSendSmscodeView *smscodeView;
@end

@implementation HXBSendSmscodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUP];
}

- (void)setUP {
    self.smscodeView = [[HXBSendSmscodeView alloc] initWithFrame:self.view.frame];
    self.smscodeView.phonNumber = self.phonNumber;
    [self.view addSubview: self.smscodeView];
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
