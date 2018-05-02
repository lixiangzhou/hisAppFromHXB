//
//  HXBCommonResultController.m
//  hoomxb
//
//  Created by lxz on 2018/4/26.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBCommonResultController.h"

@implementation HXBCommonResultContentModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.descAlignment = NSTextAlignmentCenter;
        self.descHasMark = NO;
    }
    return self;
}

- (instancetype)initWithImageName:(NSString *)imageName titleString:(NSString *)titleString descString:(NSString *)descString firstBtnTitle:(NSString *)firstBtnTitle
{
    self = [self init];
    
    self.imageName = imageName;
    self.titleString = titleString;
    self.descString = descString;
    self.firstBtnTitle = firstBtnTitle;
    
    return self;
}
@end

@interface HXBCommonResultController ()
/// 图标
@property (nonatomic, weak) UIImageView *iconView;
/// 大号文字
@property (nonatomic, weak) UILabel *titleLabel;
/// 小号描述文字容器
@property (nonatomic, weak) UIView *descView;
/// !
@property (nonatomic, weak) UIImageView *maskView;
/// 小号描述文字
@property (nonatomic, weak) UILabel *descLabel;
/// 第一个按钮
@property (nonatomic, weak) UIButton *firstBtn;
/// 第二个按钮
@property (nonatomic, weak) UIButton *secondBtn;
@end

@implementation HXBCommonResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    [self setConstraints];
    [self setData];
}

#pragma mark - UI

- (void)setUI {
    self.isRedColorWithNavigationBar = YES;
    
    // 图标
    // INPUT:
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:iconView];
    self.iconView = iconView;
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = kHXBFountColor_333333_100;
    titleLabel.font = kHXBFont_38;
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    // 描述
    UIView *descView = [UIView new];
    [self.view addSubview:descView];
    self.descView = descView;
    
    UILabel *descLabel = [UILabel new];
    descLabel.numberOfLines = 0;
    descLabel.font = kHXBFont_30;
    descLabel.textColor = kHXBFountColor_999999_100;
    [descView addSubview:descLabel];
    self.descLabel = descLabel;
    
    // ！
    UIImageView *maskView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tip"]];
    [descView addSubview:maskView];
    self.maskView = maskView;
    
    // 第一个按钮
    UIButton *firstBtn = [UIButton new];
    firstBtn.layer.cornerRadius = 4;
    firstBtn.layer.masksToBounds = YES;
    [firstBtn setTitleColor:kHXBFountColor_White_FFFFFF_100 forState:UIControlStateNormal];
    firstBtn.backgroundColor = kHXBColor_F55151_100;
    [firstBtn addTarget:self action:@selector(firstBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstBtn];
    self.firstBtn = firstBtn;
    
    // 如果有第二个按钮就显示，否则不显示
    if (self.contentModel.secondBtnTitle) {
        UIButton *secondBtn = [UIButton new];
        secondBtn.layer.cornerRadius = 4;
        secondBtn.layer.masksToBounds = YES;
        [secondBtn setTitleColor:kHXBColor_F55151_100 forState:UIControlStateNormal];
        secondBtn.backgroundColor = [UIColor whiteColor];
        secondBtn.layer.borderColor = kHXBColor_F55151_100.CGColor;
        secondBtn.layer.borderWidth = kXYBorderWidth;
        [secondBtn addTarget:self action:@selector(secondBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:secondBtn];
        
        self.secondBtn = secondBtn;
    }
}
- (void)setConstraints {
    kWeakSelf
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(HXBStatusBarAndNavigationBarHeight + kScrAdaptationH750(150)));
        make.centerX.equalTo(weakSelf.view);
        make.width.equalTo(@(kScrAdaptationW750(295)));
        make.height.equalTo(@(kScrAdaptationH750(182)));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_bottom).offset(kScrAdaptationH(30));
        make.centerX.equalTo(weakSelf.view);
    }];
    
    [self.descView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
    }];
    
    // 如果有描述，就显示
    if (self.contentModel.descString) {
        if (self.contentModel.descAlignment == NSTextAlignmentLeft) {   // 左对齐，若有 ！，创建ImageView，因为这种情况下，文本要求一直在 ！ 右边
            [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.descView);
                make.height.equalTo(@14);
                make.width.equalTo(self.contentModel.descHasMark ? @14 : @0);
                make.top.equalTo(self.descView).offset(2);
            }];
            
            [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.right.bottom.equalTo(self.descView);
                make.left.equalTo(self.maskView.mas_right).offset(self.contentModel.descHasMark ? 7 : 0);
            }];
        } else {    // 居中，使用富文本，此时 ！ 和文本一起居中的
            self.maskView.hidden = YES;
            [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.descView);
            }];
        }

    } else {    // 没有描述就隐藏
        [self.descView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(0);
            make.left.greaterThanOrEqualTo(@20);
            make.right.lessThanOrEqualTo(@-20);
            make.centerX.equalTo(self.view);
            make.height.equalTo(@0);
        }];
        self.descView.hidden = YES;
    }
    
    [self.firstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descView.mas_bottom).offset(50);
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.height.equalTo(@41);
    }];
    
    // 如果有第二个按钮就显示，否则不显示
    if (self.contentModel.secondBtnTitle) {
        [self.secondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.firstBtn.mas_bottom).offset(20);
            make.left.equalTo(@20);
            make.right.equalTo(@-20);
            make.height.equalTo(@41);
        }];
    }
}

- (void)setData {
    self.iconView.image = [UIImage imageNamed:self.contentModel.imageName];
    self.titleLabel.text = self.contentModel.titleString;
    
    self.descLabel.textAlignment = self.contentModel.descAlignment;
    self.descLabel.text = self.contentModel.descString;
    
    if (self.contentModel.descString) {
        if (self.contentModel.descAlignment == NSTextAlignmentCenter) {
            // 居中样式使用富文本，居左模式使用ImageView
            NSMutableAttributedString *descAttr = [[NSMutableAttributedString alloc] init];
            if (self.contentModel.descHasMark) {
                NSTextAttachment *mask = [NSTextAttachment new];
                mask.image = [UIImage imageNamed:@"tip"];
                mask.bounds = CGRectMake(0, -2, 14, 14);
                [descAttr appendAttributedString:[NSAttributedString attributedStringWithAttachment:mask]];
            }
            [descAttr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@", self.contentModel.descString]]];
            self.descLabel.attributedText = descAttr;
        }
    }
    
    [self.firstBtn setTitle:self.contentModel.firstBtnTitle forState:UIControlStateNormal];
    if (self.contentModel.secondBtnTitle) {
        [self.secondBtn setTitle:self.contentModel.secondBtnTitle forState:UIControlStateNormal];
    }
}


#pragma mark - Action
- (void)firstBtnClick:(UIButton *)btn {
    if (self.contentModel.firstBtnBlock) {
        self.contentModel.firstBtnBlock(self);
    }
}

- (void)secondBtnClick:(UIButton *)btn {
    if (self.contentModel.secondBtnBlock) {
        self.contentModel.secondBtnBlock(self);
    }
}

- (void)leftBackBtnClick
{
    if (self.contentModel.navBackBlock) {
        self.contentModel.navBackBlock(self);
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
