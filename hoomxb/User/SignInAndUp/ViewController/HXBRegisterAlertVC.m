//
//  HXBRegisterAlertVC.m
//  hoomxb
//
//  Created by hxb on 2017/11/16.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRegisterAlertVC.h"

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
    [self.contentView addSubview:self.cancelBtn];
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
-(void)setType:(NSString *)type{
    _type = type;
    kWeakSelf
    if ([_type isEqualToString:@"解绑未设置交易密码"]) {
        [self.sendSMSCodeBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.answeringVoiceCodeBtn setTitle:@"确定" forState:UIControlStateNormal];
        if (self.cancelBtn) {
            self.cancelBtn.hidden = YES;
        }
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.view).offset(kScrAdaptationH750(410));
            make.height.offset(kScrAdaptationH750(300));
        }];
        [self.subTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView.mas_top).offset(kScrAdaptationH750(60));
            make.left.equalTo(weakSelf.contentView.mas_left).offset(kScrAdaptationH750(40));
            make.right.equalTo(weakSelf.contentView.mas_right).offset(kScrAdaptationH750(-40));
            make.height.equalTo(@kScrAdaptationH(42));
        }];
    } else if([_type isEqualToString:@"注册验证码"]){
        [self.sendSMSCodeBtn setTitle:@"获取短信" forState:UIControlStateNormal];
         [self.answeringVoiceCodeBtn setTitle:@"接听电话" forState:UIControlStateNormal];
    }
}

- (void)setupSubViewFrame
{
    kWeakSelf
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.bottom.equalTo(weakSelf.view.mas_bottom);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(kScrAdaptationH750(400));
        make.height.offset(kScrAdaptationH750(324));
        make.width.offset(kScrAdaptationW750(560));
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView.mas_top).offset(kScrAdaptationH750(15));
        make.right.equalTo(weakSelf.contentView.mas_right).offset(kScrAdaptationW750(-15));
        make.width.offset(kScrAdaptationW750(46));
        make.height.offset(kScrAdaptationH750(46));
    }];
    [self.messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView.mas_top).offset(kScrAdaptationH750(60));
        make.centerX.equalTo(weakSelf.contentView);
        make.height.offset(kScrAdaptationH750(34));
    }];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.messageLab.mas_bottom).offset(kScrAdaptationH750(20));
        make.left.equalTo(weakSelf.contentView.mas_left).offset(kScrAdaptationH750(40));
        make.right.equalTo(weakSelf.contentView.mas_right).offset(kScrAdaptationH750(-40));
        make.height.equalTo(@kScrAdaptationH(42));
    }];
    [self.sendSMSCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView.mas_bottom);
        make.left.equalTo(weakSelf.contentView.mas_left);
        make.width.mas_equalTo(kScrAdaptationW750(280));
        make.height.offset(kScrAdaptationH750(80));
    }];
    [self.answeringVoiceCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView.mas_bottom);
        make.right.equalTo(weakSelf.contentView.mas_right);
        make.width.mas_equalTo(kScrAdaptationW750(280));
        make.height.offset(kScrAdaptationH750(80));
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
        [_answeringVoiceCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_answeringVoiceCodeBtn addTarget:self action:@selector(answeringVoiceCodeClick) forControlEvents:UIControlEventTouchUpInside];
        [_answeringVoiceCodeBtn setBackgroundColor:RGB(245, 81, 81)];
        _answeringVoiceCodeBtn.userInteractionEnabled = YES;
        _answeringVoiceCodeBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
    }
    return _answeringVoiceCodeBtn;
}
- (UIButton *)sendSMSCodeBtn
{
    if (!_sendSMSCodeBtn) {
        _sendSMSCodeBtn = [[UIButton alloc] init];
        [_sendSMSCodeBtn setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
        [_sendSMSCodeBtn addTarget:self action:@selector(sendSMSCodeClick) forControlEvents:UIControlEventTouchUpInside];
        [_sendSMSCodeBtn setBackgroundColor:RGB(232, 232, 238)];
        _sendSMSCodeBtn.userInteractionEnabled = YES;
        _sendSMSCodeBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
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
        [_cancelBtn setImage:[UIImage imageNamed:@"register_close"] forState:UIControlStateNormal];
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
        _contentView.layer.cornerRadius = kScrAdaptationW750(7);
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
