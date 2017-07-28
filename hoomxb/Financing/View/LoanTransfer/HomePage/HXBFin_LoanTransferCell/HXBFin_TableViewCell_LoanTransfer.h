//
//  HXBFin_TableViewCell_LoanTransfer.h
//  hoomxb
//
//  Created by HXB on 2017/7/1.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBFinHomePageViewModel_LoanTruansferViewModel;
@interface HXBFin_TableViewCell_LoanTransfer : HXBBaseTableViewCell
/**
 债转模型
 */
@property (nonatomic,strong) HXBFinHomePageViewModel_LoanTruansferViewModel *LoanTruansferViewModel;
@property (nonatomic,copy) void(^clickStutasButtonBlock)(id model);
@end
