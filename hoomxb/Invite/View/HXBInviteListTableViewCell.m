//
//  HXBInviteListTableViewCell.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2017/11/9.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBInviteListTableViewCell.h"

NSString *const HXBInviteListTableViewCellIdentifier = @"HXBInviteListTableViewCellIdentifier";
//const CGFloat HXBInviteListTableViewCellHeight = kScrAdaptationH(60);

@interface HXBInviteListTableViewCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *mobileLabel;
@property (nonatomic, strong) UILabel *inviteTimeLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *separatorLineView;

@end

@implementation HXBInviteListTableViewCell

#pragma mark - Life Cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setUI];
    }
    return self;
}

#pragma mark - UI

- (void)setUI {
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.mobileLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.inviteTimeLabel];
    [self.contentView addSubview:self.separatorLineView];

    
    [self setupFrame];
}

- (void)setupFrame {
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW(20));
        make.top.equalTo(self).offset(kScrAdaptationH(10));
        make.height.offset(kScrAdaptationH(15));
    }];
    
    [_mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW(20));
        make.top.equalTo(_nameLabel.mas_bottom).offset(kScrAdaptationH(10));
        make.height.offset(kScrAdaptationH(14));
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-kScrAdaptationW(20));
        make.top.equalTo(self).offset(kScrAdaptationH(10));
        make.height.offset(kScrAdaptationH(15));
    }];
    
    [_inviteTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-kScrAdaptationW(20));
        make.top.equalTo(_contentLabel.mas_bottom).offset(kScrAdaptationH(10));
        make.height.offset(kScrAdaptationH(15));
    }];
    
    [_separatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW(20));
        make.right.equalTo(self).offset(-kScrAdaptationW(20));
        make.top.equalTo(self).offset(kScrAdaptationH(59.5));
        make.height.offset(kHXBDivisionLineHeight);
    }];
}

#pragma mark - Action

- (void)setModel:(HXBInviteModel *)model {
    
    _nameLabel.text =  model.invitedRealName;
    _mobileLabel.text = model.invitedUserPhoneNo;
    _contentLabel.text = model.rewardDesc;
    _inviteTimeLabel.text = [NSString stringWithFormat:@"%@注册", model.registTime_new];
    
}

#pragma mark - Setter / Getter / Lazy
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = COR6;
        _nameLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
    }
    return _nameLabel;
}

- (UILabel *)mobileLabel {
    if (!_mobileLabel) {
        _mobileLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _mobileLabel.textColor = COR10;
        _mobileLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    }
    return _mobileLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.textColor = COR6;
        _contentLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
    }
    return _contentLabel;
}

- (UILabel *)inviteTimeLabel {
    if (!_inviteTimeLabel) {
        _inviteTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _inviteTimeLabel.textColor = COR10;
        _inviteTimeLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    }
    return _inviteTimeLabel;
}

- (UIView *)separatorLineView {
    if (!_separatorLineView) {
        _separatorLineView = [[UIView alloc] initWithFrame:CGRectZero];
        _separatorLineView.backgroundColor = COR12;
    }
    return _separatorLineView;
}

- (void)setIsHiddenLine:(BOOL)isHiddenLine {
    _isHiddenLine = isHiddenLine;
    _separatorLineView.hidden = isHiddenLine;
}

@end
