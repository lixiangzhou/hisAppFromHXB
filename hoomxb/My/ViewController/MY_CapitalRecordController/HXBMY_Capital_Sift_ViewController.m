//
//  HXBMY_Capital_Sift_ViewController.m
//  hoomxb
//
//  Created by HXB on 2017/6/28.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_Capital_Sift_ViewController.h"

@interface HXBMY_Capital_Sift_ViewController ()
/**
 点击了筛选的类型进行回调
 */
@property (nonatomic,copy) void(^clickCapital_TitleBlock)(NSString *typeStr,kHXBEnum_MY_CapitalRecord_Type type);
@property (nonatomic,copy) NSString *typeStr;
@property (nonatomic,copy) NSString *type;
@end

@implementation HXBMY_Capital_Sift_ViewController
- (void)clickCapital_TitleWithBlock:(void (^)(NSString *, kHXBEnum_MY_CapitalRecord_Type))clickCapital_TitleBlock {
    _clickCapital_TitleBlock = clickCapital_TitleBlock;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    HXBBaseView_MoreTopBottomView *topBottomView = [[HXBBaseView_MoreTopBottomView alloc]initWithFrame:CGRectZero andTopBottomViewNumber:5 andViewClass:[UIButton class] andViewHeight:30 andTopBottomSpace:6 andLeftRightLeftProportion:1];
    //上下的列表页
    [self.hxbBaseVCScrollView addSubview:topBottomView];
    [topBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(@64);
    }];
    
    [topBottomView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        viewManager.leftStrArray = @[
                                     @"全部",
                                     @"充值",
                                     @"提现",
                                     @"散标债权",
                                     @"红利计划",
                                     ];
        viewManager.rightStrArray = @[
                                      @"",
                                      @"",
                                      @"",
                                      @"",
                                      @""
                                      ];
        [viewManager.leftViewArray enumerateObjectsUsingBlock:^(UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
            view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
            if ([view isKindOfClass:[UIButton class]]) {
            
                UIButton *button = (UIButton *)view;
                button.tag = idx;
                [button addTarget:self action:@selector(clickCapitalButton:) forControlEvents:UIControlEventTouchUpInside];
            }
        }];
        viewManager.leftLabelAlignment = NSTextAlignmentCenter;
        viewManager.viewColor = [UIColor colorWithWhite:0.8 alpha:1];
        return viewManager;
    }];
}
- (void)clickCapitalButton: (UIButton *)button {
    if (_clickCapital_TitleBlock) {
        _clickCapital_TitleBlock(button.titleLabel.text,button.tag);
    }
    [self dismissViewControllerAnimated:true completion:nil];
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
