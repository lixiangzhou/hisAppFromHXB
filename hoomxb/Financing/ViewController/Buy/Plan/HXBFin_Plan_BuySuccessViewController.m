//
//  HXBFin_Plan_BuySuccessViewController.m
//  hoomxb
//
//  Created by HXB on 2017/6/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_Plan_BuySuccessViewController.h"
#import "HXBFin_Plan_BuyViewModel.h"
@interface HXBFin_Plan_BuySuccessViewController ()
@property (nonatomic,strong) HXBBaseView_TwoLable_View *twoLableView;
@property (nonatomic,strong) UIButton *button;
@end

@implementation HXBFin_Plan_BuySuccessViewController
- (void)setPlanModel:(HXBFin_Plan_BuyViewModel *)planModel {
    _planModel = planModel;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUPView];
}

- (void)setUPView {
    
    kWeakSelf
    self.twoLableView = [[HXBBaseView_TwoLable_View alloc]init];
    self.hxb_automaticallyAdjustsScrollViewInsets = true;
    [self.hxbBaseVCScrollView addSubview:self.twoLableView];
    [self.twoLableView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        viewModelVM.leftLabelStr = @"加入成功";
        viewModelVM.rightLabelStr = weakSelf.planModel.lockStart;
        viewModelVM.rightLabelAlignment = NSTextAlignmentCenter;
        viewModelVM.leftLabelAlignment = NSTextAlignmentCenter;
        return viewModelVM;
    }];
    [self.twoLableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(kScrAdaptationH(70));
        make.height.equalTo(@(kScrAdaptationH(80)));
    }];
    self.button = [[UIButton alloc]init];
    [self.hxbBaseVCScrollView addSubview: self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twoLableView.mas_bottom).offset(kScrAdaptationH(20));
        make.left.right.equalTo(@(kScrAdaptationW(100)));
        make.height.equalTo(@(kScrAdaptationH(50)));
    }];
    [self.button setTitle:@"查看我的资料" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    self.button.backgroundColor = [UIColor hxb_randomColor];
}

- (void) massage: (NSString *)massage andSuccessStr: (NSString *)successStr andButtonStr: (NSString *)buttonStr {
    [self.twoLableView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        viewModelVM.leftLabelStr = successStr;
        viewModelVM.rightLabelStr = massage;
        viewModelVM.rightLabelAlignment = NSTextAlignmentCenter;
        viewModelVM.leftLabelAlignment = NSTextAlignmentCenter;
        return viewModelVM;
    }];
    [self.button setTitle:buttonStr forState:UIControlStateNormal];
}

- (void) clickButton:(UIButton *)button {
    [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_LoginSuccess_PushMYVC object:nil];
    [self.navigationController popToRootViewControllerAnimated:true];
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
