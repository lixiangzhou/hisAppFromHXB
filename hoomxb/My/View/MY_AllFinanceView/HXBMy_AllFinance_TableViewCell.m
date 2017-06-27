//
//  HXBMy_AllFinance_TableViewCell.m
//  hoomxb
//
//  Created by HXB on 2017/6/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMy_AllFinance_TableViewCell.h"
@interface HXBMy_AllFinance_TableViewCell ()
@property (nonatomic,strong) UILabel *leftLabel;
@property (nonatomic,strong) UILabel *rightLabel;
@property (nonatomic,strong) UILabel *typeLabel;

@property (nonatomic, copy) NSString *leftStr;
@property (nonatomic, copy) NSString *rightStr;
@property (nonatomic, copy) NSAttributedString *typeStr;
@end
@implementation HXBMy_AllFinance_TableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUP];
    }
    return self;
}
- (void)setUP {
    [self creatViews];
    [self setUPFrame];
}
- (void)creatViews {
    self.leftLabel = [[UILabel alloc]init];
    self.rightLabel = [[UILabel alloc]init];
    self.typeLabel = [[UILabel alloc]init];
}
- (void)setUPFrame {
    [self.contentView addSubview: self.leftLabel];
    [self.contentView addSubview:self.rightLabel];
    [self.contentView addSubview: self.typeLabel];

    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(self.contentView);
    }];
    [self.leftLabel sizeToFit];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self.contentView);
        make.left.equalTo(self.leftLabel.mas_right);
    }];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.leftLabel);
        make.left.equalTo(self.leftLabel);
        make.height.width.equalTo(@(kScrAdaptationH(10)));
    }];
}
- (void)setLeftStr:(NSString *)leftStr {
    _leftStr = leftStr;
    self.leftLabel.text = leftStr;
}
- (void)setUPValueWithLeftStr: (NSString *)leftStr andRightStr: (NSString *)rightStr andTypeStr: (NSAttributedString *)typeStr {
    self.leftLabel.text = leftStr;
    self.rightLabel.text = rightStr;
    self.typeLabel.attributedText = typeStr;
}
@end
