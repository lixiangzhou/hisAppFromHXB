//
//  HXBHomePageHeadView.m
//  HongXiaoBao
//
//  Created by 牛严 on 16/7/8.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import "HXBHomePageHeadView.h"
#import "HXBHomePageBulletinView.h"
#import "HXBHomePageModuleView.h"
#import "HXBHomePageLoginIndicationView.h"
#import "HXBHomePageAfterLoginView.h"

@interface HXBHomePageHeadView () <HXBHomePageBulletinViewDelegate>

@property (nonatomic, strong) HXBHomePageBulletinView *bulletinView;

@property (nonatomic, strong) HXBHomePageModuleView *moduleView;

@property (nonatomic, strong) HXBHomePageLoginIndicationView *indicationView;

@property (nonatomic, strong) HXBHomePageAfterLoginView * afterLoginView;

@end

@implementation HXBHomePageHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.indicationView];
        [self addSubview:self.afterLoginView];
        [self addSubview:self.moduleView];
        [self addSubview:self.bannerView];
        [self addSubview:self.bulletinView];

//        [self.moduleView setTopLine];
    }
    return self;
}

#pragma mark HXBHomePageBulletinViewDelegate Methods
- (void)closeButtonView
{
    if (self.bulletinView.hidden == YES) {
        return;
    }
    self.bulletinView.hidden = YES;
//    self.indicationView.y = self.bannerView.height;
//    self.afterLoginView.y = self.bannerView.height;
//
//    self.moduleView.y = self.bannerView.height + self.indicationView.height;
//
    self.height = self.height - self.bulletinView.height;
    [self.bulletinView removeFromSuperview];
    
    [self resetView];
}

-(void)setNetwork:(BOOL)network{
    _network = network;
    self.moduleView.network = _network ;

}

#pragma mark Private Methods
- (void)hideBulletinView
{
    [self closeButtonView];
}

- (void)showBulletinView
{
    if (!self.bulletinView || self.bulletinView.hidden == YES) {
        [self addSubview:self.bulletinView];
        self.bulletinView.hidden = NO;
        // set frame
        if ([KeyChain isLogin]) {
            self.afterLoginView.y = self.afterLoginView.y + self.bulletinView.height;
            self.moduleView.y = self.moduleView.y + self.bulletinView.height;
            self.height = self.height + self.bulletinView.height;
        }else
        {
            self.indicationView.y = self.indicationView.y + self.bulletinView.height;
            self.moduleView.y = self.moduleView.y + self.bulletinView.height;
            self.height = self.height + self.bulletinView.height;
        }
   
        
        [self resetView];
    }
}

- (void)hideLoginIndicationView
{    self.afterLoginView.hidden = NO;
    if (self.indicationView.hidden) {
        return;
    }
//    self.height = self.height - self.indicationView.height;
    if (!self.bulletinView.hidden) {
//        self.moduleView.y = self.bannerView.height + self.bulletinView.height +  self.afterLoginView.height;
    }
    self.indicationView.hidden = YES;
    [self resetView];
}

- (void)showLoginIndicationView
{
    self.afterLoginView.hidden = YES;
    if (self.indicationView.hidden == NO) {
        return;
    }
    if (self.bulletinView.hidden == YES) {
        self.moduleView.y = CGRectGetMaxY(self.indicationView.frame);
    }else{
        self.moduleView.y = self.bannerView.height + self.bulletinView.height +  self.indicationView .height;
        self.indicationView.y = self.bannerView.height + self.bulletinView.height;
    }
//    self.height = self.height + self.indicationView.height;
  
    self.indicationView.hidden = NO;
    [self resetView];
}

- (void)showSecurityCertificationOrInvest{
    if ( [KeyChain isLogin] && [KeyChain isVerify]) {
       self.afterLoginView.tipString = @"已安全认证，立即投资啦！";
    }else{
       self.afterLoginView.tipString = @"还没有，安全认证";
    }
    if ([KeyChain isVerify] && [KeyChain isInvest]) {
        
    }
}
- (void)resetView
{
    if ([self.delegate respondsToSelector:@selector(resetHeadView)]) {
        [self.delegate resetHeadView];
    }
}

//-(void)setProfitModel:(AssetOverviewModel *)profitModel
//{
//    _profitModel = profitModel;
//    self.afterLoginView.profitModel = profitModel;
//     NSLog(@"%@",profitModel.currentProfit);
//}


#pragma mark Set Methods
- (void)setBulletinsModel:(NSArray *)bulletinsModel
{
    if (!bulletinsModel || bulletinsModel.count == 0) {
        [self hideBulletinView];
    }
    _bulletinsModel = bulletinsModel;
    self.bulletinView.bulletinsModel = bulletinsModel;
}

#pragma mark Get Methods


- (HXBHomePageLoginIndicationView *)indicationView
{
    if (!_indicationView) {
        _indicationView = [[HXBHomePageLoginIndicationView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 105)];
    }
    return _indicationView;
}

-(HXBHomePageAfterLoginView *)afterLoginView
{
    if (!_afterLoginView) {
        _afterLoginView = [[HXBHomePageAfterLoginView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 105)];
        //       _afterLoginView.hidden  = YES;
    }
    return _afterLoginView;
}

- (HXBHomePageModuleView *)moduleView
{
    if (!_moduleView) {
        _moduleView = [[HXBHomePageModuleView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_indicationView.frame), SCREEN_WIDTH, 85)];
        _moduleView.backgroundColor = COR1;
    }
    return _moduleView;
}

- (HXBBannerView *)bannerView
{
    if (!_bannerView) {
        _bannerView = [[HXBBannerView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_moduleView.frame), SCREEN_WIDTH, SCREEN_WIDTH * 9/16)];
    }
    return _bannerView;
}

- (HXBHomePageBulletinView *)bulletinView
{
    if (!_bulletinView) {
        _bulletinView = [[HXBHomePageBulletinView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_bannerView.frame), SCREEN_WIDTH, 40)];
        _bulletinView.delegete = self;
    }
    return _bulletinView;
}




@end
