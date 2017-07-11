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
#import "HXBFinDetail_TableView.h"
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
    self.detailView.frame = self.hxbBaseVCScrollView.bounds;
//    self.hxb_automaticallyAdjustsScrollViewInsets = true;
    [self.hxbBaseVCScrollView addSubview:self.detailView];
    [self.hxbBaseVCScrollView hxb_HeaderWithHeaderRefreshCallBack:^{
        
    } andSetUpGifHeaderBlock:^(MJRefreshNormalHeader *header) {
        
    }];
    [self.detailView clickAddButtonBlock:^(UIButton *button) {
       
    }];
    [self setData];
}


#pragma mark - downLoadData 
- (void) downLoadData {
    
}
- (void) setData {
    kWeakSelf
    [self.detailView setUPValueWithManager:^HXBFin_LoanTruansferDetailViewManger *(HXBFin_LoanTruansferDetailViewManger *manager) {
        ///顶部的品字形

        /**
         下个还款日 05-31
         品字形 上右
         */
        manager.topViewManager.nextOneLabel = @"下个还款日";
        /**
         年利率 label
         品字形 上
         */
        manager.topViewManager.interestLabelManager.leftLabelStr = @"年利率";
        manager.topViewManager.interestLabelManager.rightLabelStr = @"0.0%";
        manager.topViewManager.interestLabelManager.leftLabelAlignment = NSTextAlignmentCenter;
        manager.topViewManager.interestLabelManager.rightLabelAlignment = NSTextAlignmentCenter;
        manager.topViewManager.interestLabelManager.leftViewColor = [UIColor grayColor];
        manager.topViewManager.interestLabelManager.rightViewColor = [UIColor grayColor];
//        manager.topViewManager.interestLabelManager.leftFont = ;
//        manager.topViewManager.interestLabelManager.rightFont;;
        /**
         剩余期限
         品字形 左
         */
        manager.topViewManager.remainTimeLabelManager.leftLabelStr = @"剩余期限";
        manager.topViewManager.remainTimeLabelManager.rightLabelStr = @"0.0个月";
        manager.topViewManager.remainTimeLabelManager.leftLabelAlignment = NSTextAlignmentCenter;
        manager.topViewManager.remainTimeLabelManager.rightLabelAlignment = NSTextAlignmentCenter;
        manager.topViewManager.remainTimeLabelManager.leftViewColor = [UIColor grayColor];
        manager.topViewManager.remainTimeLabelManager.rightViewColor = [UIColor grayColor];
        /**
         待转让金额
         品字形 右
         */
        manager.topViewManager.truansferAmountLabelManager.leftLabelStr = @"待转让金额";
        manager.topViewManager.truansferAmountLabelManager.rightLabelStr = @"0.0元";
        manager.topViewManager.truansferAmountLabelManager.leftLabelAlignment = NSTextAlignmentCenter;
        manager.topViewManager.truansferAmountLabelManager.rightLabelAlignment = NSTextAlignmentCenter;
        manager.topViewManager.truansferAmountLabelManager.leftViewColor = [UIColor grayColor];
        manager.topViewManager.truansferAmountLabelManager.rightViewColor = [UIColor grayColor];
        /**
         曾信
         */
//        manager.addTrustworthinessManager;
        
         ///还款方式 提前还款费率
        manager.loanType_InterestLabelManager.leftLabelAlignment = NSTextAlignmentCenter;
        manager.loanType_InterestLabelManager.rightLabelAlignment = NSTextAlignmentCenter;
        /**
         左侧的stringArray
         */
        manager.loanType_InterestLabelManager.leftStrArray = @[@"还款方式",@"提前还款费率"];
        /**
         右侧的stringArray
         */
        manager.loanType_InterestLabelManager.rightStrArray = @[@"按月等额本息",@"0.00%"];
//        /**
//         左侧的viewArray
//         */
//        manager.loanType_InterestLabelManager.leftViewArray;
//        /**
//         右侧的viewArray
//         */
//        manager.loanType_InterestLabelManager.rightViewArray;
//        /**
//         全部的viewArray
//         */
//        manager.loanType_InterestLabelManager.allViewArray;
        
        
        /**
         颜色
         */
        manager.loanType_InterestLabelManager.textColor = [UIColor grayColor];
        manager.loanType_InterestLabelManager.viewColor = [UIColor blueColor];
        
        
        /**
         图片- 文字- 图片 的tableView
         */
        manager.detailTableViewArray = [weakSelf modelArray];
        /**
         * 预期收益不代表实际收益，投资需谨慎
         */
        manager.promptLabelStr = @"* 预期收益不代表实际收益，投资需谨慎";
        /**
         加入按钮
         */
        manager.addButtonStr = @"立即加入";
        return manager;
    }];
}
- (NSArray <HXBFinDetail_TableViewCellModel *> *)modelArray {
    HXBFinDetail_TableViewCellModel *model1 = [[HXBFinDetail_TableViewCellModel alloc]initWithImageName:@"1" andOptionIitle:@"借款信息"];
    HXBFinDetail_TableViewCellModel *model2 = [[HXBFinDetail_TableViewCellModel alloc]initWithImageName:@"1" andOptionIitle:@"转让记录"];
    HXBFinDetail_TableViewCellModel *model3 = [[HXBFinDetail_TableViewCellModel alloc]initWithImageName:@"1" andOptionIitle:@"《债权转让及受让协议》及《反洗钱及出借风险提示书》"];
    return @[model1,model2,model3];
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
