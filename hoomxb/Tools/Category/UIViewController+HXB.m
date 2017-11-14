//
//  UIViewController+HXB.m
//  hoomxb
//
//  Created by lxz on 2017/11/14.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "UIViewController+HXB.h"
#import "HXBNoDataView.h"

@implementation UIViewController (HXB)
- (void)showNoDataViewWithImgName:(NSString *)imgName noDataMassage:(NSString *)noDataMassage downPullMassage:(NSString *)downPullMassage inView:(UIView *)view remakeConstraints:(void(^)(MASConstraintMaker *))remakeConstraints
{
    HXBNoDataView *nodataView = [[HXBNoDataView alloc]initWithFrame:CGRectZero];
    nodataView.imageName = imgName;
    nodataView.noDataMassage = noDataMassage;
    nodataView.downPULLMassage = downPullMassage;
    nodataView.userInteractionEnabled = NO;
    [view addSubview:nodataView];
    [nodataView mas_makeConstraints:remakeConstraints];
}
@end
