//
//  HXBHomePageModuleView.m
//  HongXiaoBao
//
//  Created by 牛严 on 16/7/8.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import "HXBHomePageModuleView.h"
#import "HxbHomeViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HXBHomePageModuleView ()

@property (nonatomic, strong) HXBHomePageModuleButton *introductionButton;

@property (nonatomic, strong) HXBHomePageModuleButton *safetyButton;

@property (nonatomic, strong) HXBHomePageModuleButton *inviteButton;

@property (nonatomic, strong) UIImageView * introductionImageView;

@property (nonatomic, strong) UIImageView * safetyImageView;

@property (nonatomic, strong) UIImageView * inviteImageView;


@end

@implementation HXBHomePageModuleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.introductionButton];
        [self addSubview:self.safetyButton];
        [self addSubview:self.inviteButton];
        [self.introductionButton addSubview:self.introductionImageView];
        [self.safetyButton addSubview:self.safetyImageView];
        [self.inviteButton addSubview:self.inviteImageView];

    }
    return self;
}

-(void)setNetwork:(BOOL)network{
    _network = network;
    if (!_network) {
    [self.introductionImageView setImage:[UIImage imageNamed:@"introductionplaceholder.png"]];
    [self.safetyImageView setImage:[UIImage imageNamed:@"introductionplaceholder.png"]];
    [self.inviteImageView setImage:[UIImage imageNamed:@"introductionplaceholder.png"]];
    }else
    {
      _introductionImageView.image = [UIImage imageNamed:@"hoom_introduce"];
      _safetyImageView.image = [UIImage imageNamed:@"hoom_safety"];
      _inviteImageView.image = [UIImage imageNamed:@"hoom_invite"];
    }
}

#pragma mark Action
- (void)intoduceButtonClicked
{
    id next = [self nextResponder];
    while (![next isKindOfClass:[HxbHomeViewController class]]) {
        next = [next nextResponder];
    }
    if ([next isKindOfClass:[HxbHomeViewController class]]) {
        HxbHomeViewController *vc = (HxbHomeViewController *)next;
//        [vc showIntroduceView];
    }
}

- (void)safetyButtonClicked
{
    id next = [self nextResponder];
    while (![next isKindOfClass:[HxbHomeViewController class]]) {
        next = [next nextResponder];
    }
    if ([next isKindOfClass:[HxbHomeViewController class]]) {
        HxbHomeViewController *vc = (HxbHomeViewController *)next;
//        [vc showSafetyGuaranteeView];
    }
}

- (void)inviteButtonClicked
{
    id next = [self nextResponder];
    while (![next isKindOfClass:[HxbHomeViewController class]]) {
        next = [next nextResponder];
    }
    if ([next isKindOfClass:[HxbHomeViewController class]]) {
        HxbHomeViewController *vc = (HxbHomeViewController *)next;
//        [vc showInviteFriendsView];
    }
}

#pragma Get Methods

- (HXBHomePageModuleButton *)introductionButton
{
    if (!_introductionButton) {
        _introductionButton = [[HXBHomePageModuleButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/3, 85)];
        [_introductionButton addTarget:self action:@selector(intoduceButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/6 - 26, 56, self.width/3-10, 13)];
        titleLabel.text = @"品牌介绍";
        titleLabel.font = HXB_Text_Font(13);
        titleLabel.textColor = COR7;
        [self addSubview:titleLabel];
    }
    return _introductionButton;
}

-(UIImageView *)introductionImageView{
    if (!_introductionImageView) {
        _introductionImageView = [[UIImageView alloc]initWithFrame:CGRectMake(46.5, 16, 32, 32)];
        _introductionImageView.center = CGPointMake(SCREEN_WIDTH/6, 32);
        _introductionImageView.image = [UIImage imageNamed:@"hoom_introduce"];
    }

    return _introductionImageView;

}

- (HXBHomePageModuleButton *)safetyButton
{
    if (!_safetyButton) {
        _safetyButton = [[HXBHomePageModuleButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3,0,SCREEN_WIDTH/3,85)];
        [_safetyButton addTarget:self action:@selector(safetyButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 26, 56, self.width/3-10, 13)];
        titleLabel.text = @"安全保障";
        titleLabel.font = HXB_Text_Font(13);
        titleLabel.textColor = COR7;
        [self addSubview:titleLabel];
    }
    return _safetyButton;
}

-(UIImageView *)safetyImageView
{
    if (!_safetyImageView) {
        _safetyImageView = [[UIImageView alloc]initWithFrame:CGRectMake(46.5, 16, 32, 32)];
        _safetyImageView.center = CGPointMake(SCREEN_WIDTH/6, 32);
        _safetyImageView.image = [UIImage imageNamed:@"hoom_safety"];
    }
    return _safetyImageView;
}

- (HXBHomePageModuleButton *)inviteButton
{
    if (!_inviteButton) {
        _inviteButton = [[HXBHomePageModuleButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3 * 2,0,SCREEN_WIDTH/3,85)];
        [_inviteButton addTarget:self action:@selector(inviteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/6*5 - 26, 56, self.width/3-10, 13)];
        titleLabel.text = @"邀请好友";
        titleLabel.font = HXB_Text_Font(13);
        titleLabel.textColor = COR7;
        [self addSubview:titleLabel];
    }
    return _inviteButton;
}
-(UIImageView *)inviteImageView
{
    if (!_inviteImageView) {
        _inviteImageView = [[UIImageView alloc]initWithFrame:CGRectMake(46.5, 16, 32, 32)];
        _inviteImageView.center = CGPointMake(SCREEN_WIDTH/6, 32);
        _inviteImageView.image = [UIImage imageNamed:@"hoom_invite"];
    }
      return _inviteImageView;
}

@end




@implementation HXBHomePageModuleButton

//重写点击区域大小
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect bounds = self.bounds;
    CGFloat widthDelta = 100.0 - bounds.size.width;
    CGFloat heightDelta = 80.0 - bounds.size.height;
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

@end
