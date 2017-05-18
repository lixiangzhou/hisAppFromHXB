//
//  HXBHomePageProductCell.h
//  HongXiaoBao
//
//  Created by 牛严 on 16/7/12.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HxbHomePageViewModel_dataList.h"

@interface HXBHomePageProductCell : UITableViewCell
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) NSString *expectAnnualizedRatesTitleString;
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) HxbHomePageViewModel_dataList *homeDataListViewModel;
@end

@interface CategoryLabel : UILabel

@end
