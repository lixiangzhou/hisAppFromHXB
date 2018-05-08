//
//  HXBActivationResultViewController.m
//  hoomxb
//
//  Created by caihongji on 2018/5/4.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBActivationResultViewController.h"

@interface HXBActivationResultViewController ()

@end

@implementation HXBActivationResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)leftBackBtnClick {
    if(self.presentingViewController) {
        [self dismissViewControllerAnimated:NO completion:nil];
        return;
    }
    [super leftBackBtnClick];
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
