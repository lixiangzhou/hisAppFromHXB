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
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.textLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
        self.textLabel.textColor = COR8;
        self.detailTextLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        self.detailTextLabel.textColor = COR10;
        self.detailTextLabel.textAlignment = NSTextAlignmentRight;
//        if (@available(iOS 11.0, *)) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, kScrAdaptationH(44.5), kScreenWidth - 30, kScrAdaptationH(0.5))];
            lineView.backgroundColor = COR12;
            [self.contentView addSubview:lineView];
//        }
    }
    return self;
}
- (void)layoutSubviews {
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(kScrAdaptationW(15));
        make.top.equalTo(self.contentView).offset(kScrAdaptationH(15));
        make.width.offset(kScrAdaptationW(263));
        make.height.offset(kScrAdaptationH(15));
        
    }];
    [self.detailTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(kScrAdaptationW(-15));
        make.width.offset(kScrAdaptationW(70));
        make.top.equalTo(self.contentView).offset(kScrAdaptationH(16));
        make.height.offset(kScrAdaptationH(14));
    }];
}

@end
