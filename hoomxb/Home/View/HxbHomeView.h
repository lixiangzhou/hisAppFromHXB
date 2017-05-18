//
//  HxbHomeView.h
//  hoomxb
//
//  Created by HXB-C on 2017/5/11.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXBBannerView.h"
#import "HxbHomePageViewModel.h"
#import "HxbHomePageViewModel_dataList.h"
@interface HxbHomeView : UIView
@property (nonatomic,strong)HXBBannerView *bannerView;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray<HxbHomePageViewModel_dataList *> *homeDataListViewModelArray;


- (void)changeIndicationView;
- (void)hideBulletinView;
- (void)showBulletinView;
- (void)showSecurityCertificationOrInvest;
- (void)setDataModel:(HxbHomePageViewModel *)dataModel;

@end
