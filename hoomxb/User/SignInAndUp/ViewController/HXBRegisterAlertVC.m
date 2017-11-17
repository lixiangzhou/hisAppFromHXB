//
//  HXBRegisterAlertVC.m
//  hoomxb
//
//  Created by hxb on 2017/11/16.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRegisterAlertVC.h"
#import "SVGKit/SVGKImage.h"

@interface HXBRegisterAlertVC ()
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *messageLab;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIButton *sendSMSCodeBtn;
@property (nonatomic, strong) UIButton *answeringVoiceCodeBtn;
/**
 取消按钮
 */
@property (nonatomic, copy) void(^cancelBtnClickBlock)();
/**
 短信验证码getVerificationCodeBlock
 */
@property (nonatomic, copy) void(^getVerificationCodeBlock)();
/**
 语音验证吗getSpeechVerificationCodeBlock
 */
@property (nonatomic, copy) void(^getSpeechVerificationCodeBlock)();
@end

@implementation HXBRegisterAlertVC

- (instancetype)init
{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.cancelBtn];
    [self.contentView addSubview:self.messageLab];
    [self.contentView addSubview:self.subTitleLabel];
    [self.contentView addSubview:self.sendSMSCodeBtn];
    [self.contentView addSubview:self.answeringVoiceCodeBtn];
    [self setupSubViewFrame];
}
- (void)setSubTitle:(NSString *)subTitle
{
    _subTitle = subTitle;
    self.subTitleLabel.text = subTitle;
}
- (void)setMessageTitle:(NSString *)messageTitle {
    _messageTitle = messageTitle;
    self.messageLab.text = messageTitle;
}
- (void)setupSubViewFrame
{
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(kScrAdaptationH750(385));
        make.height.offset(kScrAdaptationH750(400));
        make.width.offset(kScrAdaptationW750(590));
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.width.offset(kScrAdaptationW750(50));
        make.height.offset(kScrAdaptationH750(95));
    }];
    [self.messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kScrAdaptationH750(60));
        make.centerX.equalTo(self.contentView);
        make.height.offset(kScrAdaptationH750(34));
    }];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageLab.mas_bottom).offset(kScrAdaptationH750(20));
        make.left.equalTo(self.contentView.mas_left).offset(kScrAdaptationH750(40));
        make.right.equalTo(self.contentView.mas_right).offset(kScrAdaptationH750(-40));
        make.height.equalTo(@kScrAdaptationH(42));
    }];
    [self.sendSMSCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(kScrAdaptationH750(-60));
        make.left.equalTo(self.contentView.mas_left).offset(kScrAdaptationW750(40));
        make.width.equalTo(@kScrAdaptationW(117.5));
        make.height.offset(kScrAdaptationH750(70));
    }];
    [self.answeringVoiceCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(kScrAdaptationH750(-60));
//        make.left.equalTo(self.sendSMSCodeBtn.mas_right).offset(kScrAdaptationW750(40));
        make.width.equalTo(@kScrAdaptationW(117.5));
        make.right.equalTo(self.contentView.mas_right).offset(-kScrAdaptationW750(40));
        make.height.offset(kScrAdaptationH750(70));
    }];
}
- (void)verificationCodeBtnWithBlock:(void (^)())getVerificationCodeBlock{
    self.getVerificationCodeBlock = getVerificationCodeBlock;
}
- (void)speechVerificationCodeBtnWithBlock:(void (^)())getSpeechVerificationCodeBlock{
    self.getSpeechVerificationCodeBlock = getSpeechVerificationCodeBlock;
}
- (void)cancelBtnWithBlock:(void (^)())cancelBtnClickBlock{
    self.cancelBtnClickBlock = cancelBtnClickBlock;
}
- (void)cancelBtnClick
{
    kWeakSelf
    if (self.cancelBtnClickBlock) {
        self.cancelBtnClickBlock();
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    }
   
}
- (void)sendSMSCodeClick{
    kWeakSelf
    if (self.getVerificationCodeBlock) {
        self.getVerificationCodeBlock();
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    }
}
- (void)answeringVoiceCodeClick{
    kWeakSelf
    if (self.getSpeechVerificationCodeBlock) {
        self.getSpeechVerificationCodeBlock();
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    }
}
- (UIButton *)answeringVoiceCodeBtn
{
    if (!_answeringVoiceCodeBtn) {
        _answeringVoiceCodeBtn = [[UIButton alloc] init];
        [_answeringVoiceCodeBtn setTitle:@"接听语音验证码" forState:UIControlStateNormal];
        [_answeringVoiceCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_answeringVoiceCodeBtn addTarget:self action:@selector(answeringVoiceCodeClick) forControlEvents:UIControlEventTouchUpInside];
        [_answeringVoiceCodeBtn setBackgroundColor:RGB(245, 81, 81)];
        _answeringVoiceCodeBtn.userInteractionEnabled = YES;
        _answeringVoiceCodeBtn.layer.borderWidth = kScrAdaptationW750(1);
        _answeringVoiceCodeBtn.layer.borderColor = RGB(245, 81, 81).CGColor;
        _answeringVoiceCodeBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
        _answeringVoiceCodeBtn.layer.cornerRadius = kScrAdaptationW750(10);
        _answeringVoiceCodeBtn.layer.masksToBounds = YES;
    }
    return _answeringVoiceCodeBtn;
}
- (UIButton *)sendSMSCodeBtn
{
    if (!_sendSMSCodeBtn) {
        _sendSMSCodeBtn = [[UIButton alloc] init];
        [_sendSMSCodeBtn setTitle:@"发送短信验证码" forState:UIControlStateNormal];
        [_sendSMSCodeBtn setTitleColor:RGB(245, 81, 81) forState:UIControlStateNormal];
        [_sendSMSCodeBtn addTarget:self action:@selector(sendSMSCodeClick) forControlEvents:UIControlEventTouchUpInside];
        [_sendSMSCodeBtn setBackgroundColor:[UIColor whiteColor]];
        _sendSMSCodeBtn.userInteractionEnabled = YES;
        _sendSMSCodeBtn.layer.borderWidth = kScrAdaptationW750(1);
        _sendSMSCodeBtn.layer.borderColor = RGB(245, 81, 81).CGColor;
        _sendSMSCodeBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
        _sendSMSCodeBtn.layer.cornerRadius = kScrAdaptationW750(10);
        _sendSMSCodeBtn.layer.masksToBounds = YES;
    }
    return _sendSMSCodeBtn;
}
- (UILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.textColor = RGB(102, 102, 102);
        _subTitleLabel.numberOfLines = 0;
        _subTitleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _subTitleLabel;
}
- (UILabel *)messageLab
{
    if (!_messageLab) {
        _messageLab = [[UILabel alloc] init];
        _messageLab.font = kHXBFont_PINGFANGSC_REGULAR_750(34);
        _messageLab.textColor = RGB(51, 51, 51);
        _messageLab.textAlignment = NSTextAlignmentCenter;
    }
    return _messageLab;
}
- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setImage:[SVGKImage imageNamed:@"close.svg"].UIImage forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancelBtn.backgroundColor = [UIColor clearColor];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = kScrAdaptationW750(10);
        _contentView.layer.masksToBounds = YES;
        
    }
    return _contentView;
}
- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] init];
        _backBtn.backgroundColor = [UIColor clearColor];
        //        [_backBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

@end
