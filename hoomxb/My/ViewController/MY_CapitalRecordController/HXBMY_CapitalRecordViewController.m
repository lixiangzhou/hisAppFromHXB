//
//  HXBMY_CapitalRecordViewController.m
//  hoomxb
//
//  Created by HXB on 2017/5/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_CapitalRecordViewController.h"
#import "HXBMYRequest.h"
@interface HXBMY_CapitalRecordViewController ()

@end

@implementation HXBMY_CapitalRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUP];
}

- (void)setUP {
    [self downDataStartDate:nil andEndDate:nil andIsUPData:true andRequestType:nil];
}

- (void)downDataStartDate:(NSString *)startData andEndDate:(NSString *)endData andIsUPData:(BOOL)isUPData andRequestType:(NSString *)requestTaye {
    [[HXBMYRequest sharedMYRequest] capitalRecord_requestWithStartDate:startData andEndDate:endData andIsUPData:isUPData andRequestType:requestTaye andSuccessBlock:^(NSArray<HXBMYViewModel_MainCapitalRecordViewModel *> *viewModelArray) {
        
    } andFailureBlock:^(NSError *error) {
        
    }];
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
