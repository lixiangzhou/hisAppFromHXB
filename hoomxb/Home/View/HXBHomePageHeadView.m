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

#import "BannerModel.h"
#import "HXBHomeBaseModel.h"
#import "SVGKImage.h"
@interface HXBHomePageHeadView () 

@property (nonatomic, strong) HXBHomePageBulletinView *bulletinView;

//@property (nonatomic, strong) HXBHomePageModuleView *moduleView;

@property (nonatomic, strong) HXBHomePageLoginIndicationView *indicationView;

@property (nonatomic, strong) HXBHomePageAfterLoginView *afterLoginView;

@property (nonatomic, strong) UIButton *noticeBtn;

@property (nonatomic, strong) UIImageView *backgroundImageView;
@end

@implementation HXBHomePageHeadView


- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Group 15"]];
        _backgroundImageView.frame = CGRectMake(0, 0, kScreenWidth, kScrAdaptationH(257));
    }
    return _backgroundImageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backgroundImageView];
        [self addSubview:self.afterLoginView];
        [self addSubview:self.indicationView];
//        [self addSubview:self.moduleView];
        [self addSubview:self.bannerView];
        [self addSubview:self.bulletinView];
        [self addSubview:self.noticeBtn];
//        [self.moduleView setTopLine];
    }
    return self;
}

#pragma mark HXBHomePageBulletinViewDelegate Methods
//- (void)closeButtonView
//{
//    if (self.bulletinView.hidden == YES) {
//        return;
//    }
//    self.bulletinView.hidden = YES;
////    self.indicationView.y = self.bannerView.height;
////    self.afterLoginView.y = self.bannerView.height;
////
////    self.moduleView.y = self.bannerView.height + self.indicationView.height;
////
//    self.height = self.height - self.bulletinView.height;
//    [self.bulletinView removeFromSuperview];
//    
//    [self resetView];
//}

-(void)setNetwork:(BOOL)network{
    _network = network;
//    self.moduleView.network = _network ;

}

#pragma mark Private Methods
//- (void)hideBulletinView
//{
//    [self closeButtonView];
//}

//- (void)showBulletinView
//{
//    if (!self.bulletinView || self.bulletinView.hidden == YES) {
//        [self addSubview:self.bulletinView];
//        self.bulletinView.hidden = NO;
//        // set frame
//        if ([KeyChain isLogin]) {
//            self.afterLoginView.y = self.afterLoginView.y + self.bulletinView.height;
////            self.moduleView.y = self.moduleView.y + self.bulletinView.height;
//            self.height = self.height + self.bulletinView.height;
//        }else
//        {
//            self.indicationView.y = self.indicationView.y + self.bulletinView.height;
////            self.moduleView.y = self.moduleView.y + self.bulletinView.height;
//            self.height = self.height + self.bulletinView.height;
//        }
//        
//        [self resetView];
//    }
//}

- (void)showNotValidatedView
{
    self.afterLoginView.hidden = NO;
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

- (void)showAlreadyInvestedView
{
    [self.indicationView loadNewDate];
    self.afterLoginView.hidden = YES;
    if (self.indicationView.hidden == NO) {
        return;
    }
    self.indicationView.hidden = NO;
    [self resetView];
}

- (void)showSecurityCertificationOrInvest{
    kWeakSelf
    if (![KeyChain isLogin]) {
        self.afterLoginView.headTipString = @"红小宝全新起航，新起点，新梦想";
        self.afterLoginView.tipString = @"注册／登录";
    }else
    {
        [KeyChain downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
            
            if (!viewModel.userInfoModel.userInfo.isCreateEscrowAcc) {
                //没有开户
                weakSelf.afterLoginView.headTipString = @"红小宝与恒丰银行完成存管对接";
                weakSelf.afterLoginView.tipString = @"用户资金安全隔离";
             } else if (!([viewModel.userInfoModel.userInfo.isCashPasswordPassed isEqualToString:@"1"] && [viewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"])) {
                 // 没有实名
                 weakSelf.afterLoginView.headTipString = @"多重安全措施，保护用户资金安全";
                  weakSelf.afterLoginView.tipString = @"完善存管信息";
             }else if (![viewModel.userInfoModel.userInfo.hasEverInvest isEqualToString:@"1"]) {
                //已经投资显示的界面
                weakSelf.afterLoginView.headTipString = @"多重安全措施，保护用户资金安全";
                weakSelf.afterLoginView.tipString = @"立即投资";
            }
        } andFailure:^(NSError *error) {
            
        }];
    }
    
//    if ( [KeyChain isLogin] && [KeyChain isVerify]) {
//       self.afterLoginView.tipString = @"立即投资啦！";
//    }else{
//       self.afterLoginView.tipString = @"安全认证";
//    }
//    if ([KeyChain isVerify] && [KeyChain isInvest]) {
//        
//    }
}
- (void)resetView
{
    if ([self.delegate respondsToSelector:@selector(resetHeadView)]) {
        [self.delegate resetHeadView];
    }
}

- (void)setHomeBaseModel:(HXBHomeBaseModel *)homeBaseModel
{
    _homeBaseModel = homeBaseModel;
    self.bulletinView.homeTitle = homeBaseModel.homeTitle;
    self.bannerView.bannersModel = homeBaseModel.bannerList;
}

- (void)noticeBtnClick
{
    if (self.noticeBlock) {
        self.noticeBlock();
    }
}

#pragma mark Set Methods
//- (void)setBulletinsModel:(NSArray *)bulletinsModel
//{
//    if (!bulletinsModel || bulletinsModel.count == 0) {
//        [self hideBulletinView];
//    }
//    _bulletinsModel = bulletinsModel;
//    self.bulletinView.bulletinsModel = bulletinsModel;
//}

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
    kWeakSelf
    if (!_afterLoginView) {
        _afterLoginView = [[HXBHomePageAfterLoginView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kScrAdaptationH(137))];
        _afterLoginView.tipButtonClickBlock_homePageAfterLoginView = ^(){
            if (weakSelf.tipButtonClickBlock_homePageHeadView) {
                weakSelf.tipButtonClickBlock_homePageHeadView();
            }
            
        };
        //               _afterLoginView.hidden  = YES;
    }
    return _afterLoginView;
}

//- (HXBHomePageModuleView *)moduleView
//{
//    if (!_moduleView) {
//        _moduleView = [[HXBHomePageModuleView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_indicationView.frame), SCREEN_WIDTH, 85)];
//        _moduleView.backgroundColor = COR1;
//    }
//    return _moduleView;
//}

- (HXBBannerView *)bannerView
{
    kWeakSelf
    if (!_bannerView) {
        _bannerView = [[HXBBannerView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.afterLoginView.frame), SCREEN_WIDTH, kScrAdaptationH(110))];
//        _bannerView.backgroundColor = [UIColor greenColor];
//        BannerModel *bannerModel = [[BannerModel alloc] init];
//        bannerModel.title = @"banner";
//        bannerModel.image = @"http://img.zcool.cn/community/01320457c129440000012e7e7b7e99.gif";
//        bannerModel.url = @"http://blog.csdn.net/lkxasdfg/article/details/8660827";
//        _bannerView.bannersModel = @[bannerModel,bannerModel,bannerModel,bannerModel];
        _bannerView.clickBannerImageBlock = ^(BannerModel *model){
            NSLog(@"%@%@",model.image,model.title);
            if (weakSelf.clickBannerImageBlock) {
                weakSelf.clickBannerImageBlock(model);
            }
        };
    }
    return _bannerView;
}

- (HXBHomePageBulletinView *)bulletinView
{
    if (!_bulletinView) {
        _bulletinView = [[HXBHomePageBulletinView alloc]initWithFrame:CGRectMake(0,self.height - kScrAdaptationH(35), SCREEN_WIDTH, kScrAdaptationH(35))];
//        _bulletinView.delegete = self;
    }
    return _bulletinView;
}

- (UIButton *)noticeBtn
{
    if (!_noticeBtn) {
        _noticeBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScrAdaptationW(5), kScrAdaptationH(34), kScrAdaptationW(40), kScrAdaptationH(20))];
        SVGKImage *svgImage = [SVGKImage imageNamed:@"notice"];
        [_noticeBtn setImage:svgImage.UIImage forState:UIControlStateNormal];
        [_noticeBtn addTarget:self action:@selector(noticeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _noticeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _noticeBtn;
}


@end
