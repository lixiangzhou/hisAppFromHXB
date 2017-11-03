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
        [self setupSubViewFrame];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageView.mas_right).offset(kScrAdaptationW(10));
            make.centerY.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setupSubViewFrame
{
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.offset(kHXBDivisionLineHeight);
    }];
}


- (void)setIsShowLine:(BOOL)isShowLine
{
    _isShowLine = isShowLine;
    self.lineView.hidden = !isShowLine;
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
