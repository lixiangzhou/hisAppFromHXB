//
//  HxbHomePageModel_DataList.h
//  hoomxb
//
//  Created by HXB-C on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "BaseModel.h"
//参数名	类型	说明
//name	String	计划名称
//lockPeriod	String	锁定期限
//expectedYearRate	String	预期年化收益率
//status	String	状态 （3：等待开放加入，4：开放加入，5：已满额，6：收益中，8：已退出）
@interface HxbHomePageModel_DataList : BaseModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *lockPeriod;
@property (nonatomic, copy) NSString *expectedYearRate;
@property (nonatomic, copy) NSString *status;
@end
