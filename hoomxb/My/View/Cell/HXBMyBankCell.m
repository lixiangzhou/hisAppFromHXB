//
//  HXBMyBankCellTableViewCell.m
//  HongXiaoBao
//
//  Created by 牛严 on 16/7/26.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import "HXBMyBankCell.h"


@interface HXBMyBankCell ()

@property (nonatomic, strong) UIImageView *bankImageView;
@property (nonatomic, strong) UIView *bankImageContainer;

@property (nonatomic, strong) UILabel *bankTitleLabel;
@property (nonatomic, strong) UILabel *cardTypeLabel;
@property (nonatomic, strong) UILabel *cardNumLabel;
@property (nonatomic, strong) UIView *cornerView;
@property (nonatomic, strong) UIView *backView;

@end

@implementation HXBMyBankCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifie
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifie];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //        [self.contentView addSubview:self.cornerView];
        [self.contentView addSubview:self.backView];
        
        [self.backView addSubview:self.bankImageContainer];
        [self.bankImageContainer addSubview:self.bankImageView];
        
        [self.backView addSubview:self.bankTitleLabel];
        [self.backView addSubview:self.cardTypeLabel];
        [self.backView addSubview:self.cardNumLabel];
//        [self.cardNumLabel setLabelSpace:2 font:HXB_Text_Font(SIZ11) str:[model bankStrWithHiddenNum]];
    }
    return self;
}

#pragma mark Set
//- (void)setModel:(BankCardsModel *)model
//{

    
    //    self.bankImageView.image = [UIImage imageNamed:@"gongshang"]; // 测试
//}

#pragma mark Get
- (UIView *)cornerView
{
    if (!_cornerView) {
        _cornerView = [[UIView alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 24, 24)];
        _cornerView.layer.cornerRadius = 12.f;
    }
    return _cornerView;
}

- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 24, 139)];
        _backView.layer.cornerRadius = 12.f;
    }
    return _backView;
}

- (UIView *)bankImageContainer
{
    if (!_bankImageContainer) {
        
        _bankImageContainer = [UIView new];
        _bankImageContainer.backgroundColor = [UIColor whiteColor];
        _bankImageContainer.frame = CGRectMake(16, 16, 30, 30);
        _bankImageContainer.layer.cornerRadius = _bankImageContainer.width/2;
        
    }
    return _bankImageContainer;
}

- (UIImageView *)bankImageView
{
    if (!_bankImageView) {
        _bankImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 24, 24)];
        _bankImageView.center = CGPointMake(_bankImageContainer.width/2, _bankImageContainer.height/2);
        
    }
    return _bankImageView;
}

- (UILabel *)bankTitleLabel
{
    if (!_bankTitleLabel) {
        _bankTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_bankImageContainer.frame) + 16, 16, SCREEN_WIDTH - 70, SIZ12)];
        _bankTitleLabel.font = HXB_Text_Font(SIZ12);
        _bankTitleLabel.textColor = [UIColor whiteColor];
    }
    return _bankTitleLabel;
}

- (UILabel *)cardTypeLabel
{
    if (!_cardTypeLabel) {
        _cardTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_bankTitleLabel.x, CGRectGetMaxY(_bankTitleLabel.frame) + 10, 100, SIZ15)];
        _cardTypeLabel.textColor = COR15;
        _cardTypeLabel.font = HXB_Text_Font(SIZ15);
    }
    return _cardTypeLabel;
}

- (UILabel *)cardNumLabel
{
    if (!_cardNumLabel) {
        _cardNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(_bankTitleLabel.x, _backView.height - 40.5, SCREEN_WIDTH - 70, SIZ11)];
        _cardNumLabel.textColor = [UIColor whiteColor];
    }
    return _cardNumLabel;
}

@end
