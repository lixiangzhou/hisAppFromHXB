//
//  HXBBannerCollectionViewCell.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/11.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBannerCollectionViewCell.h"
#import "BannerModel.h"
#import <UIImageView+WebCache.h>
@interface HXBBannerCollectionViewCell ()

@property (strong, nonatomic) UIImageView *bannerImageView;

@end


@implementation HXBBannerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.bannerImageView];
        [self.bannerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
    }
    return self;
}

- (void)setBannerModel:(BannerModel *)bannerModel {
    _bannerModel = bannerModel;
    [self.bannerImageView sd_setImageWithURL:[NSURL URLWithString:bannerModel.image] placeholderImage:[UIImage imageNamed:@"bannerplaceholder"]];
}


- (UIImageView *)bannerImageView {
    if (!_bannerImageView) {
        _bannerImageView = [[UIImageView alloc] init];
    }
    return _bannerImageView;
}

@end
