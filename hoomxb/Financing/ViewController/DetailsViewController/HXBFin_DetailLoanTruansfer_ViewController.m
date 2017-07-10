//
//  HXBFin_DetailLoanTruansfer_ViewController.m
//  hoomxb
//
//  Created by HXB on 2017/7/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_DetailLoanTruansfer_ViewController.h"
///详情的VIEW
#import "HXBFin_LoanTruansferDetailView.h"
@interface HXBFin_DetailLoanTruansfer_ViewController ()
@property (nonatomic,strong) HXBFin_LoanTruansferDetailView *detailView;
@end

@implementation HXBFin_DetailLoanTruansfer_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUP];
}

#pragma mark - setUP
- (void) setUP {
    self.detailView = [[HXBFin_LoanTruansferDetailView alloc]init];
    self.detailView.frame = self.view.bounds;
    [self.view addSubview:self.detailView];
    HXBBaseView_TwoLable_View
}

- (void) setData {
    [self.detailView setUPValueWithManager:^HXBFin_LoanTruansferDetailViewManger *(HXBFin_LoanTruansferDetailViewManger *manager) {
//        ///顶部的品字形
//        /**
//         顶部的后面的遮罩
//         */
//        manager.topViewManager.topMaskView;
//        /**
//         下个还款日 05-31
//         品字形 上右
//         */
//        manager.topViewManager.nextOneLabel;
//        /**
//         年利率 label
//         品字形 上
//         */
//        manager.topViewManager.interestLabelManager;
//        /**
//         剩余期限
//         品字形 左
//         */
//        manager.topViewManager.remainTimeLabelManager;
//        /**
//         待转让金额
//         品字形 右
//         */
//        manager.topViewManager.truansferAmountLabelManager;
//        /**
//         曾信
//         */
//        manager.addTrustworthinessManager;
//        /**
//         还款方式
//         提前还款费率
//         */
//        manager.loanType_InterestLabelManager;
//        /**
//         图片- 文字- 图片 的tableView
//         */
//        manager.detailTableViewArray;
//        /**
//         * 预期收益不代表实际收益，投资需谨慎
//         */
//        manager.promptLabelStr;
//        /**
//         加入按钮
//         */
//        manager.addButtonStr;
        return manager;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
