//
//  HXBBannerCollectionViewCell.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/11.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBannerCollectionViewCell.h"
#import "SCAdViewRenderDelegate.h"
#import "BannerModel.h"
#import <UIImageView+WebCache.h>
@interface HXBBannerCollectionViewCell ()<SCAdViewRenderDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;

@end


@implementation HXBBannerCollectionViewCell

- (void)setModel:(id)model
{
    if ([model isKindOfClass:[BannerModel class]]) {
        BannerModel *bannerModel = model;
        [self.bannerImageView sd_setImageWithURL:[NSURL URLWithString:bannerModel.image] placeholderImage:[UIImage imageNamed:@"bannerplaceholder"]];
    }else{
        NSString *imageName = model;
        self.bannerImageView.image = [UIImage imageNamed:imageName];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.bannerImageView.layer.cornerRadius = 3;
    self.bannerImageView.layer.masksToBounds = YES;
//    [self.bannerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left);
//        make.right.equalTo(self.mas_right);
//        make.top.equalTo(self.mas_top);
//        make.bottom.equalTo(self.mas_bottom);
//    }];
}

@end
