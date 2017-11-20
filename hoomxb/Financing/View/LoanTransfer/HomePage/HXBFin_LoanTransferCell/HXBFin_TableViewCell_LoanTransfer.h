//
//  HXBFin_TableViewCell_LoanTransfer.h
//  hoomxb
//
//  Created by HXB on 2017/7/1.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBFinHomePageViewModel_LoanTruansferViewModel;
@class HXBFin_TableViewCell_LoanTransferManager;
@interface HXBFin_TableViewCell_LoanTransfer : HXBBaseTableViewCell
/**
 债转模型
 */
@property (nonatomic,strong) HXBFinHomePageViewModel_LoanTruansferViewModel *LoanTruansferViewModel;
//@property (nonatomic,copy) void(^clickStutasButtonBlock)(id model);

@property (nonatomic,strong) HXBFin_TableViewCell_LoanTransferManager*manager;
@end
@interface HXBFin_TableViewCell_LoanTransferManager : NSObject
/**
  @"剩余期限(月)"
 */
@property (nonatomic,copy) NSString * remainMonthStr;
/**
 @"年利率"
 */
@property (nonatomic,copy) NSString * interest;

/**
 待转金额
 */
@property (nonatomic,copy) NSString *amountTransferStr;

/**
 消费借款
 */
@property (nonatomic,copy) NSString *loanTitle;

/// 加入按钮的颜色
@property (nonatomic,strong) UIColor *addButtonBackgroundColor;
///加入按钮的字体颜色
@property (nonatomic,strong) UIColor *addButtonTitleColor;
///addbutton 边缘的颜色
@property (nonatomic,strong) UIColor *addButtonBorderColor;
//addButton可否被点击
@property (nonatomic,assign) BOOL isUserInteractionEnabled;
@end
