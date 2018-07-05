//
//  HXBFin_LoanTransferTableView.h
//  hoomxb
//
//  Created by HXB on 2017/7/1.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXBFinHomePageViewModel_LoanTruansferViewModel.h"
@interface HXBFinancting_LoanTransferTableView : HXBBaseTableView
@property (nonatomic,strong) NSArray <HXBFinHomePageViewModel_LoanTruansferViewModel*> *loanTruansferViewModel;
/**
 点击了cell
 */
- (void)clickCellWithBlock:(void (^)(HXBFinHomePageViewModel_LoanTruansferViewModel *loanTruansferViewModel, NSIndexPath *indexPath))clickCellBlock;

@end
