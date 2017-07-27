//
//  HXBNoticeCell.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/26.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBNoticeCell.h"

@implementation HXBNoticeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.textLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
        self.textLabel.textColor = COR8;
        self.textLabel.numberOfLines = 2;
        self.detailTextLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        self.detailTextLabel.textColor = COR10;
        [self setupSubViewFrame];
    }
    return self;
}
- (void)setupSubViewFrame
{

    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(kScrAdaptationW(18));
        make.right.equalTo(self.contentView.mas_right).offset(kScrAdaptationW(-18));
        make.top.equalTo(self.contentView).offset(kScrAdaptationH(17));
    }];
    [self.detailTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textLabel.mas_left);
        make.top.equalTo(self.textLabel.mas_bottom).offset(kScrAdaptationH(10));
        make.height.offset(kScrAdaptationH(12));
    }];
}

@end
