//
//  HXBLoanInstructionView.h
//  hoomxb
//
//  Created by HXB-C on 2017/6/30.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBFinDetailViewModel_LoanDetail;
///借款说明
@interface HXBLoanInstructionView : UIView
///用户信息
@property (nonatomic,strong) HXBFinDetailViewModel_LoanDetail *loanDetailViewModel;
///借款说明
@property (nonatomic,copy) NSString *loanInstruction;
@end
