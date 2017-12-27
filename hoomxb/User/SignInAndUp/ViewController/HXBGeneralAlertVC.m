//
//  HXBGeneralAlertVC.m
//  hoomxb
//
//  Created by hxb on 2017/11/16.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBGeneralAlertVC.h"

@interface HXBGeneralAlertVC ()
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *messageLab;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

/**
 messagetitle
 */
@property (nonatomic, copy)NSString *messageTitle;

/**
 子标题
 */
@property (nonatomic, copy) NSString *subTitle;

/**
 左按钮名字
 */
@property (nonatomic, copy)NSString *leftBtnName;
/**
 右按钮名字
 */
@property (nonatomic, copy)NSString *rightBtnName;
/**
 有无叉号
 */
@property (nonatomic, assign)BOOL isHideCancelBtn;
/**
 点击背景是否diss页面
 */
@property (nonatomic, assign)BOOL isClickedBackgroundDiss;

///**
// 取消按钮
// */
//@property (nonatomic, copy) void(^cancelBtnClickBlock)();
///**
//leftBtnBlock
// */
//@property (nonatomic, copy) void(^leftBtnBlock)();
///**
//rightBtnBlock
// */
//@property (nonatomic, copy) void(^rightBtnBlock)();
@end

@implementation HXBGeneralAlertVC

- (instancetype)initWithMessageTitle:(NSString *)messageTitle andSubTitle:(NSString *)subTitle andLeftBtnName:(NSString *)leftBtnName andRightBtnName:(NSString *)rightBtnName isHideCancelBtn:(BOOL)isHideCancelBtn isClickedBackgroundDiss:(BOOL)isClickedBackgroundDiss{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        _subTitle = subTitle;
        _messageTitle = messageTitle;
        _leftBtnName = leftBtnName;
        _rightBtnName = rightBtnName;
        _isHideCancelBtn = isHideCancelBtn;
        _isClickedBackgroundDiss = isClickedBackgroundDiss;
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
    [self.contentView addSubview:self.leftBtn];
    [self.contentView addSubview:self.rightBtn];
    [self setContent];
    [self setupSubViewFrame];
}

- (void)setContent{
    self.subTitleLabel.text = _subTitle;
    self.messageLab.text = _messageTitle;
    [self.leftBtn setTitle:_leftBtnName forState:UIControlStateNormal];
    [self.rightBtn setTitle:_rightBtnName forState:UIControlStateNormal];
    self.backBtn.userInteractionEnabled = _isClickedBackgroundDiss;
    
    if (_isHideCancelBtn && _cancelBtn) {
        _cancelBtn.hidden = YES;
        kWeakSelf
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
    }
}

- (void)setSubTitle:(NSString *)subTitle
{
    _subTitle = subTitle;
    self.subTitleLabel.text = subTitle;
//    if (self.messageLab.text.length <= 0) {
//        kWeakSelf
//        [self.messageLab mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(weakSelf.contentView.mas_top).offset(kScrAdaptationH750(60));
//            make.centerX.equalTo(weakSelf.contentView);
//            make.height.offset(kScrAdaptationH750(34));
//        }];
//        [self.subTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(weakSelf.messageLab.mas_bottom).offset(kScrAdaptationH750(20));
//            make.left.equalTo(weakSelf.contentView.mas_left).offset(kScrAdaptationH750(40));
//            make.right.equalTo(weakSelf.contentView.mas_right).offset(kScrAdaptationH750(-40));
//            make.height.equalTo(@kScrAdaptationH(42));
//        }];
//    }
}

- (void)setMessageTitle:(NSString *)messageTitle {
    _messageTitle = messageTitle;
    self.messageLab.text = messageTitle;
}

- (void)setLeftBtnName:(NSString *)leftBtnName{
    _leftBtnName = leftBtnName;
    [self.leftBtn setTitle:_leftBtnName forState:UIControlStateNormal];
}

- (void)setRightBtnName:(NSString *)rightBtnName{
    _rightBtnName = rightBtnName;
    [self.rightBtn setTitle:_rightBtnName forState:UIControlStateNormal];
}

- (void)setIsHideCancelBtn:(BOOL)isHideCancelBtn{
    
    _isHideCancelBtn = isHideCancelBtn;
    if (isHideCancelBtn && _cancelBtn) {
        _cancelBtn.hidden = YES;
        kWeakSelf
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
    }
}

- (void)setIsClickedBackgroundDiss:(BOOL)isClickedBackgroundDiss{
    _isClickedBackgroundDiss = isClickedBackgroundDiss;
    _backBtn.userInteractionEnabled = _isClickedBackgroundDiss;
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
        make.center.equalTo(weakSelf.view);
        make.height.offset(kScrAdaptationH750(324));
        make.width.offset(kScrAdaptationW750(560));
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView.mas_top).offset(kScrAdaptationH750(15));
        make.right.equalTo(weakSelf.contentView.mas_right).offset(kScrAdaptationW750(-15));
        make.width.offset(kScrAdaptationW750(46));
        make.height.offset(kScrAdaptationH750(46));
    }];
    if (self.messageLab.text.length > 0) {
        [self.messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView.mas_top).offset(kScrAdaptationH750(60));
            make.centerX.equalTo(weakSelf.contentView);
            make.height.offset(kScrAdaptationH750(34));
        }];
        if (self.subTitleLabel.text.length > 0) {
            [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.messageLab.mas_bottom).offset(kScrAdaptationH750(20));
                make.left.equalTo(weakSelf.contentView.mas_left).offset(kScrAdaptationH750(40));
                make.right.equalTo(weakSelf.contentView.mas_right).offset(kScrAdaptationH750(-40));
                make.height.equalTo(@kScrAdaptationH(42));
            }];
        } else {
            [self.subTitleLabel removeFromSuperview];
        }
    } else {
        if (self.subTitleLabel.text.length > 0) {
            [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.contentView.mas_top).offset(kScrAdaptationH750(60));
                make.left.equalTo(weakSelf.contentView.mas_left).offset(kScrAdaptationH750(40));
                make.right.equalTo(weakSelf.contentView.mas_right).offset(kScrAdaptationH750(-40));
                make.height.equalTo(@kScrAdaptationH(100));
            }];
        } else {
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
        }
        
    }
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView.mas_bottom);
        make.left.equalTo(weakSelf.contentView.mas_left);
        make.width.mas_equalTo(kScrAdaptationW750(280));
        make.height.offset(kScrAdaptationH750(80));
    }];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView.mas_bottom);
        make.right.equalTo(weakSelf.contentView.mas_right);
        make.width.mas_equalTo(kScrAdaptationW750(280));
        make.height.offset(kScrAdaptationH750(80));
    }];
}

//- (void)leftBtnWithBlock:(void (^)())leftBtnBlock{
//    self.leftBtnBlock = leftBtnBlock;
//}
//
//- (void)rightBtnWithBlock:(void (^)())rightBtnBlock{
//    self.rightBtnBlock = rightBtnBlock;
//}
//
//- (void)cancelBtnWithBlock:(void (^)())cancelBtnClickBlock{
//    self.cancelBtnClickBlock = cancelBtnClickBlock;
//}

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
    if (self.leftBtnBlock) {
        self.leftBtnBlock();
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    }
}

- (void)answeringVoiceCodeClick{
    kWeakSelf
    if (self.rightBtnBlock) {
        self.rightBtnBlock();
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    }
}

- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc] init];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(answeringVoiceCodeClick) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn setBackgroundColor:RGB(245, 81, 81)];
        _rightBtn.userInteractionEnabled = YES;
        _rightBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
    }
    return _rightBtn;
}

- (UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] init];
        [_leftBtn setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(sendSMSCodeClick) forControlEvents:UIControlEventTouchUpInside];
        [_leftBtn setBackgroundColor:RGB(232, 232, 238)];
        _leftBtn.userInteractionEnabled = YES;
        _leftBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
    }
    return _leftBtn;
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
        [_backBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _backBtn.userInteractionEnabled = NO;
    }
    return _backBtn;
}

@end
