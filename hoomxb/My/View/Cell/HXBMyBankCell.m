//
//  HXBMyBankCellTableViewCell.m
//  HongXiaoBao
//
//  Created by 牛严 on 16/7/26.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import "HXBMyBankCell.h"
#import "HXBBankCardModel.h"

@interface HXBMyBankCell ()


@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) HXBBaseView_MoreTopBottomView *moreTopBottomView;

@end

@implementation HXBMyBankCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifie
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifie];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.backView];
        [self.backView addSubview:self.moreTopBottomView];
//        [self.cardNumLabel setLabelSpace:2 font:HXB_Text_Font(SIZ11) str:[model bankStrWithHiddenNum]];
        
    }
    return self;
}

#pragma mark Set
- (void)setBankCardModel:(HXBBankCardModel *)bankCardModel
{
    _bankCardModel = bankCardModel;
    [self.moreTopBottomView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        viewManager.leftStrArray = @[@"安全认证",@"姓名",@"身份证",@"存管开通协议"];
        return viewManager;
    }];
}

- (void)setUserInfoViewModel:(HXBRequestUserInfoViewModel *)userInfoViewModel
{
    _userInfoViewModel = userInfoViewModel;
    [self.moreTopBottomView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        viewManager.leftStrArray = @[@"安全认证",@"姓名",@"身份证",@"存管开通协议"];
        return viewManager;
    }];
}

#pragma mark Get


- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 24, 139)];
        _backView.layer.cornerRadius = 12.f;
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (HXBBaseView_MoreTopBottomView *)moreTopBottomView
{
    if (!_moreTopBottomView) {
        _moreTopBottomView = [[HXBBaseView_MoreTopBottomView alloc] initWithFrame:self.backView.bounds andTopBottomViewNumber:4 andViewClass:[UILabel class] andViewHeight:12 andTopBottomSpace:10 andLeftRightLeftProportion:10 Space:UIEdgeInsetsMake(10, 10, 10, 10) andCashType:nil];
        
    }
    return _moreTopBottomView;
}





@end
