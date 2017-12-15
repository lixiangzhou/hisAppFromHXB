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
@interface HXBHomePageHeadView () 


// 登录之后的页面
@property (nonatomic, strong) HXBHomePageLoginIndicationView *indicationView;
// 登录之前的页面
@property (nonatomic, strong) HXBHomePageAfterLoginView *afterLoginView;

@property (nonatomic, strong) UIButton *noticeBtn;

@end

@implementation HXBHomePageHeadView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.afterLoginView];
        [self addSubview:self.indicationView];
        [self addSubview:self.bannerView];
        [self addSubview:self.noticeBtn];
        [self setupUI];
    }
    return self;
}

#pragma mark - setupUI

- (void)setupUI {
    [self.noticeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(kScrAdaptationW(-20));
        make.top.offset(kScrAdaptationH(40));
        make.height.offset(kScrAdaptationH(17));
        make.width.offset(kScrAdaptationW(20));
    }];
}

#pragma mark HXBHomePageBulletinViewDelegate Methods
-(void)setNetwork:(BOOL)network{
    _network = network;
}

#pragma mark Private Methods
// 显示未投资页
- (void)showNotValidatedView
{
    self.afterLoginView.hidden = NO;
    if (self.indicationView.hidden) return;
//    self.height = self.height - self.indicationView.height;
    self.indicationView.hidden = YES;
    [self resetView];
}

// 显示投资页
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

- (void)showSecurityCertificationOrInvest:(HXBRequestUserInfoViewModel *)viewModel{
    kWeakSelf
    NSLog(@"________%d", [KeyChain isLogin]);
    if (![KeyChain isLogin]) {
        self.afterLoginView.headTipString = @"红小宝全新起航，新起点，新梦想";
        self.afterLoginView.tipString = @"注册／登录";
    } else {
        
        if (!viewModel.userInfoModel.userInfo.isCreateEscrowAcc) {
            //没有开户
            weakSelf.afterLoginView.headTipString = @"红小宝携手恒丰银行资金存管已上线";
            weakSelf.afterLoginView.tipString = @"立即开通存管账户";
        } else if (!([viewModel.userInfoModel.userInfo.isCashPasswordPassed isEqualToString:@"1"] && [viewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"])) {
            // 没有实名
            weakSelf.afterLoginView.headTipString = @"多重安全措施，保护用户资金安全";
            weakSelf.afterLoginView.tipString = @"完善存管信息";
        } else if (![viewModel.userInfoModel.userInfo.hasEverInvest isEqualToString:@"1"]) {
            //已经投资显示的界面
            weakSelf.afterLoginView.headTipString = @"多重安全措施，保护用户资金安全";
            weakSelf.afterLoginView.tipString = @"立即投资";
        }
        
    }
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
    
    if (homeBaseModel.bannerList.count) {
        self.bannerView.bannersModel = homeBaseModel.bannerList;
    }else{
        BannerModel *bannerModel = [[BannerModel alloc] init];
        self.bannerView.bannersModel = @[bannerModel];
    }
}

- (void)noticeBtnClick
{
    if (self.noticeBlock) {
        self.noticeBlock();
    }
}

#pragma mark Set Methods

#pragma mark Get Methods
- (HXBHomePageLoginIndicationView *)indicationView
{
    if (!_indicationView) {
        _indicationView = [[HXBHomePageLoginIndicationView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kScrAdaptationH(140))];
    }
    return _indicationView;
}

-(HXBHomePageAfterLoginView *)afterLoginView
{
    kWeakSelf
    if (!_afterLoginView) {
        _afterLoginView = [[HXBHomePageAfterLoginView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kScrAdaptationH(140))];
        _afterLoginView.tipButtonClickBlock_homePageAfterLoginView = ^(){
            if (weakSelf.tipButtonClickBlock_homePageHeadView) {
                weakSelf.tipButtonClickBlock_homePageHeadView();
            }
            
        };
    }
    return _afterLoginView;
}


- (HXBBannerView *)bannerView
{
    kWeakSelf
    if (!_bannerView) {
        _bannerView = [[HXBBannerView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.afterLoginView.frame), SCREEN_WIDTH, kScrAdaptationH(110))];
//        _bannerView.backgroundColor = [UIColor greenColor];
        BannerModel *bannerModel = [[BannerModel alloc] init];
//        bannerModel.title = @"banner";
//        bannerModel.image = @"http://img.zcool.cn/community/01320457c129440000012e7e7b7e99.gif";
//        bannerModel.url = @"http://blog.csdn.net/lkxasdfg/article/details/8660827";
        _bannerView.bannersModel = @[bannerModel];
        _bannerView.clickBannerImageBlock = ^(BannerModel *model){
            NSLog(@"%@%@",model.image,model.title);
            if (weakSelf.clickBannerImageBlock) {
                weakSelf.clickBannerImageBlock(model);
            }
        };
    }
    return _bannerView;
}


- (UIButton *)noticeBtn
{
    if (!_noticeBtn) {
        _noticeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_noticeBtn setImage:[UIImage imageNamed:@"Home_notice"] forState:UIControlStateNormal];
        [_noticeBtn addTarget:self action:@selector(noticeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _noticeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _noticeBtn;
}


@end
