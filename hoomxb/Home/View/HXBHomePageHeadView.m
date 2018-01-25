//
//  HXBHomePageHeadView.m
//  HongXiaoBao
//
//  Created by 牛严 on 16/7/8.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#define kHXBNoticeButtonWithAndHeight kScrAdaptationH(60)

#define kHXBBannerViewHeight kScrAdaptationH(185)

#import "HXBHomePageHeadView.h"
#import "HXBHomePageBulletinView.h"
#import "HXBHomePageModuleView.h"
#import "HXBHomePageLoginIndicationView.h"
#import "HXBHomePageAfterLoginView.h"

#import "BannerModel.h"
#import "HXBHomeBaseModel.h"
#import "HXBHomeNewbieProductModel.h"
#import <UIImageView+WebCache.h>
#import "HxbHomePageModel_DataList.h"
@interface HXBHomePageHeadView () 


// 登录之后的页面
@property (nonatomic, strong) HXBHomePageLoginIndicationView *indicationView;
// 登录之前的页面
@property (nonatomic, strong) HXBHomePageAfterLoginView *afterLoginView;

@property (nonatomic, strong) UIButton *noticeBtn;

@property (nonatomic, strong) UIView *newbieView;

@property (nonatomic, strong) UIImageView *newbieImageView;

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
        [self addSubview:self.newbieView];
        [self.newbieView addSubview:self.newbieImageView];
        [self setupUI];
    }
    return self;
}

#pragma mark - setupUI

- (void)setupUI {
    kWeakSelf
    [self.noticeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf);
        make.top.offset(kScrAdaptationH(18) + HXBStatusBarAdditionHeight);
        make.height.offset(kHXBNoticeButtonWithAndHeight);
        make.width.offset(kHXBNoticeButtonWithAndHeight);
    }];
    [self.newbieView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.height.offset(kScrAdaptationH(90));
        make.top.equalTo(weakSelf.bannerView.mas_bottom).offset(kScrAdaptationH(10));
    }];
    [self.newbieImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.newbieView).offset(kHXBSpacing_30);
        make.right.equalTo(weakSelf.newbieView).offset(-kHXBSpacing_30);
        make.height.offset(kScrAdaptationH(65));
        make.bottom.equalTo(weakSelf.newbieView.mas_bottom);
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
    kWeakSelf
    [self.bannerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.height.offset(kHXBBannerViewHeight);
        make.top.equalTo(weakSelf.afterLoginView.mas_bottom);
    }];
}

// 显示投资页
- (void)showAlreadyInvestedView
{
    self.indicationView.userInfoViewModel = self.userInfoViewModel;
    self.afterLoginView.hidden = YES;
    if (self.indicationView.hidden == NO) {
        return;
    }
    self.indicationView.hidden = NO;
    [self resetView];
    kWeakSelf
    [self.bannerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.height.offset(kHXBBannerViewHeight);
        make.top.equalTo(weakSelf.indicationView.mas_bottom);
    }];
}

- (void)showSecurityCertificationOrInvest:(HXBRequestUserInfoViewModel *)viewModel{
    NSLog(@"________%d", [KeyChain isLogin]);
    if (![KeyChain isLogin]) {
        self.afterLoginView.headTipString = @"红小宝全新起航，新起点，新梦想";
        self.afterLoginView.tipString = @"立即注册";
    } else {
        
        if (!viewModel.userInfoModel.userInfo.isCreateEscrowAcc) {
            //没有开户
            self.afterLoginView.headTipString = @"红小宝携手恒丰银行资金存管已上线";
            self.afterLoginView.tipString = @"立即开通存管账户";
        } else if (!([viewModel.userInfoModel.userInfo.isCashPasswordPassed isEqualToString:@"1"] && [viewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"])) {
            // 没有实名
            self.afterLoginView.headTipString = @"多重安全措施，保护用户资金安全";
            self.afterLoginView.tipString = @"完善存管信息";
        } else if (![viewModel.userInfoModel.userInfo.hasEverInvest isEqualToString:@"1"] && (self.homeBaseModel.newbieProductData.dataList.count > 0)) {
            //已经投资显示的界面
            HxbHomePageModel_DataList *homePageModel = self.homeBaseModel.newbieProductData.dataList.firstObject;
            CGFloat rate = [homePageModel.baseInterestRate doubleValue] + [homePageModel.subsidyInterestRate doubleValue];
            NSString *newbieSubsidyInterestRate = [NSString stringWithFormat:@"新手专享%0.1f年化产品",rate];
            
            self.afterLoginView.headTipString = newbieSubsidyInterestRate;
            self.afterLoginView.tipString = @"立即投资";
        } else if (![viewModel.userInfoModel.userInfo.hasEverInvest isEqualToString:@"1"]) {
            //已经投资显示的界面
            self.afterLoginView.headTipString = @"多重安全措施，保护用户资金安全";
            self.afterLoginView.tipString = @"立即投资";
        }
        
    }
}
- (void)resetView
{
    if ([self.delegate respondsToSelector:@selector(resetHeadView)]) {
        [self.delegate resetHeadView];
    }
}



- (void)noticeBtnClick
{
    if (self.noticeBlock) {
        self.noticeBlock();
    }
}


/**
 新手视图点击方法
 */
- (void)newbieAreaAction {
    if (self.newbieAreaActionBlock) {
        self.newbieAreaActionBlock();
    }
}

#pragma mark Set Methods
- (void)setHomeBaseModel:(HXBHomeBaseModel *)homeBaseModel
{
    _homeBaseModel = homeBaseModel;
    
    if (homeBaseModel.bannerList.count) {
        self.bannerView.bannersModel = homeBaseModel.bannerList;
    }else{
        BannerModel *bannerModel = [[BannerModel alloc] init];
        self.bannerView.bannersModel = @[bannerModel];
    }
    NSURL *imgURL = [NSURL URLWithString:homeBaseModel.newbieProductData.img];
    [self.newbieImageView sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"Home_newbieArea_default"]];
    [self showSecurityCertificationOrInvest:self.userInfoViewModel];
    if (homeBaseModel.newbieProductData.img.length > 0) {
        self.newbieView.hidden = NO;
    } else {
        self.newbieView.hidden = YES;
    }
}
#pragma mark Get Methods
- (HXBHomePageLoginIndicationView *)indicationView
{
    if (!_indicationView) {
        _indicationView = [[HXBHomePageLoginIndicationView alloc]initWithFrame:CGRectMake(0, HXBStatusBarAdditionHeight, SCREEN_WIDTH, kScrAdaptationH(145))];
    }
    return _indicationView;
}

-(HXBHomePageAfterLoginView *)afterLoginView
{
    kWeakSelf
    if (!_afterLoginView) {
        _afterLoginView = [[HXBHomePageAfterLoginView alloc]initWithFrame:CGRectMake(0, HXBStatusBarAdditionHeight, SCREEN_WIDTH, kScrAdaptationH(113))];
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
        _bannerView = [[HXBBannerView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.afterLoginView.frame), SCREEN_WIDTH, kHXBBannerViewHeight)];
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
        CGFloat leftAndRight = (kHXBNoticeButtonWithAndHeight - kScrAdaptationH(20)) * 0.5;
        _noticeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, leftAndRight, 0, leftAndRight);
        _noticeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _noticeBtn;
}

- (UIView *)newbieView {
    if (!_newbieView) {
        _newbieView = [[UIView alloc] init];
        _newbieView.backgroundColor = [UIColor whiteColor];
    }
    return _newbieView;
    
}

- (UIImageView *)newbieImageView {
    if (!_newbieImageView) {
        _newbieImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Home_newbieArea_default"]];
        _newbieImageView.contentMode = UIViewContentModeScaleAspectFit;
        _newbieImageView.userInteractionEnabled = YES;
        //创建手势对象
        UITapGestureRecognizer *newbieGesture =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(newbieAreaAction)];
        //讲手势添加到指定的视图上
        [_newbieImageView addGestureRecognizer:newbieGesture];
    }
    return _newbieImageView;
}

@end
