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
@property (nonatomic, strong) UITextView *subTitleTextView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, assign) CGFloat subTitleHeight;
@property (nonatomic, assign) BOOL isScrolled;
/**
 title
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

@end

@implementation HXBGeneralAlertVC

- (instancetype)initWithMessageTitle:(NSString *)messageTitle andSubTitle:(NSString *)subTitle andLeftBtnName:(NSString *)leftBtnName andRightBtnName:(NSString *)rightBtnName isHideCancelBtn:(BOOL)isHideCancelBtn isClickedBackgroundDiss:(BOOL)isClickedBackgroundDiss{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.isAutomaticDismiss = YES;//默认为yes
        _messageTitle = messageTitle ? messageTitle : @"";
        _subTitle = subTitle ? subTitle : @"";
        _subTitleHeight = [[HXB_XYTools shareHandle] heightWithString:subTitle labelFont:kHXBFont_PINGFANGSC_REGULAR_750(28) Width:kScrAdaptationW750(480)];
        if (_subTitleHeight > kScrAdaptationH750(80)) {
            self.isScrolled = YES;
        } else {
            self.isScrolled = NO;
        }
        _subTitleHeight = _subTitleHeight > kScrAdaptationH750(80) ? kScrAdaptationH750(80) : _subTitleHeight;
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
    [self.contentView addSubview:self.subTitleTextView];
    [self.contentView addSubview:self.leftBtn];
    [self.contentView addSubview:self.rightBtn];
    [self setContent];
    [self setupSubViewFrame];
}

- (void)setContent{
    self.subTitleTextView.text = _subTitle;
    self.messageLab.text = _messageTitle;
    [self.leftBtn setTitle:_leftBtnName forState:UIControlStateNormal];
    [self.rightBtn setTitle:_rightBtnName forState:UIControlStateNormal];
    self.backBtn.userInteractionEnabled = _isClickedBackgroundDiss;
    if (_isScrolled == NO) {
        [self.subTitleTextView setUserInteractionEnabled:NO];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = kScrAdaptationH750(14);// 字体的行间距
        paragraphStyle.alignment = NSTextAlignmentCenter;
        NSDictionary *attributes = @{
                                     NSForegroundColorAttributeName:RGB(102, 102, 102),
                                     NSFontAttributeName:kHXBFont_PINGFANGSC_REGULAR_750(28),
                                     NSParagraphStyleAttributeName:paragraphStyle
                                     };
        self.subTitleTextView.attributedText = [[NSAttributedString alloc] initWithString:self.subTitleTextView.text attributes:attributes];
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
        make.center.equalTo(weakSelf.view);
        make.height.offset(kScrAdaptationH750(324));
        make.width.offset(kScrAdaptationW750(560));
    }];
    if (_isHideCancelBtn && _cancelBtn) {
        _cancelBtn.hidden = YES;
    } else {
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView.mas_top).offset(kScrAdaptationH750(15));
            make.right.equalTo(weakSelf.contentView.mas_right).offset(kScrAdaptationW750(-15));
            make.width.offset(kScrAdaptationW750(46));
            make.height.offset(kScrAdaptationH750(46));
        }];
    }
    
    if (self.messageLab.text.length > 0) {
        [self.messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView.mas_top).offset(kScrAdaptationH750(50));
            make.centerX.equalTo(weakSelf.contentView);
            make.height.offset(kScrAdaptationH750(34));
        }];
        if (self.subTitleTextView.text.length > 0) {
            [self.subTitleTextView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.messageLab.mas_bottom).offset(kScrAdaptationH750(20));
                make.left.equalTo(weakSelf.contentView.mas_left).offset(kScrAdaptationH750(40));
                make.right.equalTo(weakSelf.contentView.mas_right).offset(kScrAdaptationH750(-40));
                make.bottom.equalTo(weakSelf.leftBtn.mas_top).offset(kScrAdaptationH750(-30));
            }];
        } else {
            [self.subTitleTextView removeFromSuperview];
        }
    } else {
        if (self.subTitleTextView.text.length > 0) {
            [self.subTitleTextView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.contentView.mas_top).offset(kScrAdaptationH750(60));
                make.left.equalTo(weakSelf.contentView.mas_left).offset(kScrAdaptationH750(40));
                make.right.equalTo(weakSelf.contentView.mas_right).offset(kScrAdaptationH750(-40));
                make.bottom.equalTo(weakSelf.leftBtn.mas_top).offset(kScrAdaptationH750(-60));
            }];
        } else {
            [self.messageLab removeFromSuperview];
            [self.subTitleTextView removeFromSuperview];
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

- (void)cancelBtnClick
{
    kWeakSelf
    if (self.cancelBtnClickBlock) {
        self.cancelBtnClickBlock();
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    }
}

- (void)leftBtnClick{
    kWeakSelf
    if (self.isAutomaticDismiss) {
        [self dismissViewControllerAnimated:NO completion:^{
            if (weakSelf.leftBtnBlock) {
                weakSelf.leftBtnBlock();
            }
        }];
    }
    else {
        if (self.leftBtnBlock) {
            self.leftBtnBlock();
        }
    }
}

- (void)rightBtnClick{
    kWeakSelf
    if (self.isAutomaticDismiss) {
        [self dismissViewControllerAnimated:NO completion:^{
            if (weakSelf.rightBtnBlock) {
                weakSelf.rightBtnBlock();
            }
        }];
    }
    else {
        if (self.rightBtnBlock) {
            self.rightBtnBlock();
        }
    }
}

- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc] init];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn setBackgroundColor:RGB(245, 81, 81)];
        _rightBtn.userInteractionEnabled = YES;
        _rightBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
    }
    return _rightBtn;
}

- (UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] init];
        [_leftBtn setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_leftBtn setBackgroundColor:RGB(232, 232, 238)];
        _leftBtn.userInteractionEnabled = YES;
        _leftBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
    }
    return _leftBtn;
}

- (UITextView *)subTitleTextView
{
    if (!_subTitleTextView) {
        _subTitleTextView = [[UITextView alloc] init];
        _subTitleTextView.textColor = RGB(102, 102, 102);
        _subTitleTextView.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
        _subTitleTextView.textAlignment = NSTextAlignmentLeft;
        _subTitleTextView.backgroundColor = [UIColor whiteColor];
//        self.subTitleTextView.contentInset = UIEdgeInsetsZero;
        _subTitleTextView.editable = NO;
        _subTitleTextView.selectable = NO;
    }
    return _subTitleTextView;
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
        _contentView.layer.cornerRadius = kScrAdaptationW750(5);
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
