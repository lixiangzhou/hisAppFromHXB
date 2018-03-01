//
//  HXBFinanctingDetail_imageCell.m
//  hoomxb
//
//  Created by HXB on 2017/8/23.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinanctingDetail_imageCell.h"

@interface HXBFinanctingDetail_imageCell ()



@end


@implementation HXBFinanctingDetail_imageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupAddTrustView];
    }
    return self;
}


//MARK: - 增信
- (void)setupAddTrustView {
    self.trustView = [[UIImageView alloc]init];
    self.trustView.backgroundColor = [UIColor whiteColor];
    self.trustView.userInteractionEnabled = YES;
    [self.contentView addSubview: self.trustView];
    [self.trustView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(0);
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(80)));
    }];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
