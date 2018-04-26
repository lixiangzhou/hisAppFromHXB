//
//  HXBCommonResultController.m
//  hoomxb
//
//  Created by lxz on 2018/4/26.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBCommonResultController.h"

@implementation HXBCommonResultContentModel
- (instancetype)initWithImageName:(NSString *)imageName titleString:(NSString *)titleString descString:(NSString *)descString firstBtnTitle:(NSString *)firstBtnTitle
{
    self = [super init];
    
    self.imageName = imageName;
    self.titleString = titleString;
    self.descString = descString;
    self.firstBtnTitle = firstBtnTitle;
    
    self.descAlignment = NSTextAlignmentCenter;
    self.descHasMark = NO;
    
    return self;
}
@end

@interface HXBCommonResultController ()

@end

@implementation HXBCommonResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     要查找赋值的地方，请搜索：INPUT:
     */
    [self setUI];
}

#pragma mark - UI

- (void)setUI {
    self.isRedColorWithNavigationBar = YES;
    
    // 图标
    // INPUT:
    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.contentModel.imageName]];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:iconView];
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = kHXBFountColor_333333_100;
    titleLabel.font = kHXBFont_38;
    // INPUT:
    titleLabel.text = self.contentModel.titleString;
    [self.view addSubview:titleLabel];
    
    // 描述
    UIView *descView = [UIView new];
    [self.view addSubview:descView];
    
    // 第一个按钮
    UIButton *firstBtn = [UIButton new];
    firstBtn.layer.cornerRadius = 4;
    firstBtn.layer.masksToBounds = YES;
    // INPUT:
    [firstBtn setTitle:self.contentModel.firstBtnTitle forState:UIControlStateNormal];
    [firstBtn setTitleColor:kHXBFountColor_White_FFFFFF_100 forState:UIControlStateNormal];
    firstBtn.backgroundColor = kHXBColor_F55151_100;
    [firstBtn addTarget:self action:@selector(firstBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstBtn];
    
    kWeakSelf
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(HXBStatusBarAndNavigationBarHeight + kScrAdaptationH750(150)));
        make.centerX.equalTo(weakSelf.view);
        make.width.equalTo(@(kScrAdaptationW750(295)));
        make.height.equalTo(@(kScrAdaptationH750(182)));
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconView.mas_bottom).offset(kScrAdaptationH(30));
        make.centerX.equalTo(weakSelf.view);
    }];
    
    [descView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(20);
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
    }];
    
    // 如果有描述，就显示
    if (self.contentModel.descString) {
        UILabel *descLabel = [UILabel new];
        descLabel.numberOfLines = 0;
        descLabel.font = kHXBFont_30;
        descLabel.textColor = kHXBFountColor_999999_100;
        // INPUT:
        descLabel.textAlignment = self.contentModel.descAlignment;
        [descView addSubview:descLabel];
        
        if (self.contentModel.descAlignment == NSTextAlignmentLeft) {   // 左对齐，若有 ！，创建ImageView，因为这种情况下，文本要求一直在 ！ 右边
            UIImageView *maskView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tip"]];
            [descView addSubview:maskView];
            // INPUT:
            descLabel.text = self.contentModel.descString;
            
            [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(descView);
                make.height.equalTo(@14);
                make.width.equalTo(self.contentModel.descHasMark ? @14 : @0);
                make.top.equalTo(descView).offset(2);
            }];
            
            [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.right.bottom.equalTo(descView);
                make.left.equalTo(maskView.mas_right).offset(self.contentModel.descHasMark ? 7 : 0);
            }];
        } else {    // 居中，使用富文本，此时 ！ 和文本一起居中的
            NSMutableAttributedString *descAttr = [[NSMutableAttributedString alloc] init];
            if (self.contentModel.descHasMark) {
                NSTextAttachment *mask = [NSTextAttachment new];
                mask.image = [UIImage imageNamed:@"tip"];
                mask.bounds = CGRectMake(0, -2, 14, 14);
                [descAttr appendAttributedString:[NSAttributedString attributedStringWithAttachment:mask]];
            }
            [descAttr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@", self.contentModel.descString]]];
            // INPUT:
            descLabel.attributedText = descAttr;
            
            [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(descView);
            }];
        }

    } else {    // 没有描述就隐藏
        [descView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(0);
            make.left.greaterThanOrEqualTo(@20);
            make.right.lessThanOrEqualTo(@-20);
            make.centerX.equalTo(self.view);
            make.height.equalTo(@0);
        }];
        descView.hidden = YES;
    }
    
    [firstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(descView.mas_bottom).offset(50);
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.height.equalTo(@41);
    }];
    
    // 如果有第二个按钮就显示，否则不显示
    if (self.contentModel.secondBtnTitle) {
        UIButton *secondBtn = [UIButton new];
        secondBtn.layer.cornerRadius = 4;
        secondBtn.layer.masksToBounds = YES;
        // INPUT:
        [secondBtn setTitle:self.contentModel.secondBtnTitle forState:UIControlStateNormal];
        [secondBtn setTitleColor:kHXBColor_F55151_100 forState:UIControlStateNormal];
        secondBtn.backgroundColor = [UIColor whiteColor];
        secondBtn.layer.borderColor = kHXBColor_F55151_100.CGColor;
        secondBtn.layer.borderWidth = kXYBorderWidth;
        [secondBtn addTarget:self action:@selector(secondBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:secondBtn];
        
        [secondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(firstBtn.mas_bottom).offset(20);
            make.left.equalTo(@20);
            make.right.equalTo(@-20);
            make.height.equalTo(@41);
        }];
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

@end
