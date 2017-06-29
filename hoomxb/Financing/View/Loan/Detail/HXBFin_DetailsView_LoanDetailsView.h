//
//  HXBFin_DetailsView_LoanDetailsView.h
//  hoomxb
//
//  Created by HXB on 2017/5/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_DetailsViewBase.h"

@interface HXBFin_DetailsView_LoanDetailsView : HXBFin_DetailsViewBase
///期限
@property (nonatomic,copy) NSString *timeStr;
///倒计时label
@property (nonatomic,copy) NSString *countDownStr;
@end
