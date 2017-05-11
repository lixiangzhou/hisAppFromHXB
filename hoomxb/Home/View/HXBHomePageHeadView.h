//
//  HXBHomePageHeadView.h
//  HongXiaoBao
//
//  Created by 牛严 on 16/7/8.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXBBannerView.h"

@protocol HXBHomePageHeadViewDelegate <NSObject>

@optional

- (void)resetHeadView;

@end

@interface HXBHomePageHeadView : UIView

@property (nonatomic, strong) HXBBannerView *bannerView;

@property (nonatomic, strong) NSArray *bulletinsModel;

@property (nonatomic, strong) id <HXBHomePageHeadViewDelegate> delegate;

@property (nonatomic, assign) BOOL network;

- (void)hideLoginIndicationView;

- (void)showLoginIndicationView;


- (void)hideBulletinView;
- (void)showBulletinView;

@end
