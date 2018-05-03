//
//  HXBUserMigrationViewController.m
//  hoomxb
//
//  Created by hxb on 2018/5/2.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBUserMigrationViewController.h"

@interface HXBUserMigrationViewController ()
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *messageLab;
@property (nonatomic, strong) UITextView *subTitleTextView;
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
 右按钮名字
 */
@property (nonatomic, copy)NSString *rightBtnName;

/**
 点击背景是否diss页面
 */
@property (nonatomic, assign)BOOL isClickedBackgroundDiss;
@end

@implementation HXBUserMigrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.modalPresentationStyle = UIModalPresentationCustom;
    _messageTitle =  @"用户迁移";
    _subTitle = @"为保障您的账户安全，请先激活您的账户再进行下一步操作";
    _subTitleHeight = [[HXB_XYTools shareHandle] heightWithString:_subTitle labelFont:kHXBFont_PINGFANGSC_REGULAR_750(28) Width:kScrAdaptationW750(480)];
    if (_subTitleHeight > kScrAdaptationH750(80)) {
        self.isScrolled = YES;
    } else {
        self.isScrolled = NO;
    }
    _subTitleHeight = _subTitleHeight > kScrAdaptationH750(80) ? kScrAdaptationH750(80) : _subTitleHeight;
    _rightBtnName = @"账户激活";
    _isClickedBackgroundDiss = NO;
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.messageLab];
    [self.contentView addSubview:self.subTitleTextView];
    [self.contentView addSubview:self.rightBtn];
    [self setContent];
    [self setupSubViewFrame];
}

- (void)setContent{
    self.subTitleTextView.text = _subTitle;
    self.messageLab.text = _messageTitle;
    [self.rightBtn setTitle:_rightBtnName forState:UIControlStateNormal];
    self.backBtn.userInteractionEnabled = _isClickedBackgroundDiss;
    if (_isScrolled == NO) {
        [self.subTitleTextView setUserInteractionEnabled:NO];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = kScrAdaptationH750(20);// 字体的行间距
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
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView.mas_bottom);
        make.right.equalTo(weakSelf.contentView.mas_right);
        make.width.mas_equalTo(weakSelf.contentView);
        make.height.offset(kScrAdaptationH750(80));
    }];
    
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
                make.bottom.equalTo(weakSelf.rightBtn.mas_top).offset(kScrAdaptationH750(-30));
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
                make.bottom.equalTo(weakSelf.rightBtn.mas_top).offset(kScrAdaptationH750(-60));
            }];
        } else {
            [self.messageLab removeFromSuperview];
            [self.subTitleTextView removeFromSuperview];
        }
        
    }
   
    if (self.isCenterShow) {
        self.subTitleTextView.textAlignment = NSTextAlignmentCenter;
    } else {
        self.subTitleTextView.textAlignment = NSTextAlignmentLeft;
    }
}

- (void)cancelBtnClick
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)rightBtnClick{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
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

- (UITextView *)subTitleTextView
{
    if (!_subTitleTextView) {
        _subTitleTextView = [[UITextView alloc] init];
        _subTitleTextView.textColor = RGB(102, 102, 102);
        _subTitleTextView.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
        _subTitleTextView.textAlignment = NSTextAlignmentCenter;
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
