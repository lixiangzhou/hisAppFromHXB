//
//  HXBMyHomeViewCell.m
//  hoomxb
//
//  Created by HXB-C on 2017/8/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyHomeViewCell.h"

@interface HXBMyHomeViewCell()

@property (nonatomic, strong) UIView *lineView;

@end


@implementation HXBMyHomeViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.descLab];
        [self setupSubViewFrame];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.imageView.mas_right).offset(kScrAdaptationW(10));
            make.left.equalTo(@kScrAdaptationW750(30));
            make.centerY.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setupSubViewFrame
{
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.offset(0.5);
    }];
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.textLabel);
        make.height.equalTo(@kScrAdaptationH750(24));
        make.left.equalTo(@kScrAdaptationW750(750-66-300));
        make.width.equalTo(@kScrAdaptationW750(300));
    }];
}

- (void)setDesc:(id)desc{
    if ([desc isKindOfClass:[NSString class]]) {
        self.descLab.text = desc;
    }else if ([desc isKindOfClass:[NSAttributedString class]]){
        self.descLab.attributedText = desc;
    }
}

- (void)setIsShowLine:(BOOL)isShowLine
{
    _isShowLine = isShowLine;
    self.lineView.hidden = !isShowLine;
}

- (UILabel *)descLab{
    if (!_descLab) {
        _descLab = [[UILabel alloc]initWithFrame:CGRectMake(kScrAdaptationW750(750-66-300), kScrAdaptationH750(38), kScrAdaptationW750(300), kScrAdaptationH750(24))];
        _descLab.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        _descLab.textColor = RGBA(153, 153, 153, 1);
        _descLab.textAlignment = NSTextAlignmentRight;
    }
    return _descLab;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = COR12;
        _lineView.hidden = YES;
    }
    return _lineView;
}


@end
