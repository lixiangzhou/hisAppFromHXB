//
//  HXBMYModel_AssetStatistics_Loan.h
//  hoomxb
//
//  Created by HXB on 2017/5/22.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
///loan 资金统计的Model  没有ViewModel
@interface HXBMYModel_AssetStatistics_Loan : NSObject
@property (nonatomic,copy) NSString *loanlenderEarned;
@property (nonatomic,copy) NSString *loanlenderPrincipal;
@property (nonatomic,copy) NSString *rePayingTotalCount;
@property (nonatomic,copy) NSString *BIDTotalCount;
@property (nonatomic,copy) NSString *finishTotalCount;
@property (nonatomic,copy) NSString *transferingCount;
@end
