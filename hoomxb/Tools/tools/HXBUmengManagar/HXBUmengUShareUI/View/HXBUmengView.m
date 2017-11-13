//
//  HXBUmengView.m
//  hoomxb
//
//  Created by HXB-C on 2017/11/13.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBUmengView.h"
#import "JXLayoutButton.h"
@interface HXBUmengView ()

@end

@implementation HXBUmengView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

#pragma mark - UI

- (void)setUI {
    [self setupSharItem];
}

- (void)setupSharItem {
    NSArray *sharingPlatform = @[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone)];
    NSArray *iconNameArr = @[@"wechat",@"frined",@"QQ",@"qq_space"];
    NSArray *nameArr = @[@"微信",@"朋友圈",@"QQ",@"QQ空间"];
    
    CGFloat itemHeight = kScrAdaptationH(74);
    CGFloat itemWith = kScrAdaptationW(51);
    
    CGFloat leftSpacing = kScrAdaptationW(20);
    CGFloat itemSpacing = (kScreenWidth - 2 * leftSpacing - sharingPlatform.count * itemWith)/ (sharingPlatform.count - 1);
    
    for (int i = 0; i < sharingPlatform.count; i++) {
        JXLayoutButton *shareItemBtn = [JXLayoutButton buttonWithType:UIButtonTypeCustom];
        shareItemBtn.frame = CGRectMake((itemSpacing + itemWith) * i, 0, itemWith,itemHeight);
        shareItemBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        [shareItemBtn setTitleColor:COR10 forState:(UIControlStateNormal)];
        
        shareItemBtn.layoutStyle = JXLayoutButtonStyleUpImageDownTitle;
        shareItemBtn.midSpacing = kScrAdaptationH(15);
        [self addSubview:shareItemBtn];
        [shareItemBtn setTitle:nameArr[i] forState:(UIControlStateNormal)];
        shareItemBtn.contentMode = UIViewContentModeScaleAspectFit;
        shareItemBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        NSString *sharetype = sharingPlatform[i];
        shareItemBtn.tag = sharetype.intValue;
        [shareItemBtn addTarget:self action:@selector(shareWithType:) forControlEvents:(UIControlEventTouchUpInside)];
        if ([[UMSocialManager defaultManager] isInstall:shareItemBtn.tag]) {
            [shareItemBtn setImage:[UIImage imageNamed:iconNameArr[i]] forState:(UIControlStateNormal)];
            [shareItemBtn setImage:[UIImage imageNamed:iconNameArr[i]] forState:(UIControlStateHighlighted)];
        } else {
            [shareItemBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_useless",iconNameArr[i]]] forState:(UIControlStateNormal)];
            [shareItemBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_useless",iconNameArr[i]]] forState:(UIControlStateHighlighted)];
        }
    }
}

#pragma mark - Action
- (void)shareWithType:(UIButton *)btn {
    if (self.shareWebPageToPlatformType) {
        self.shareWebPageToPlatformType(btn.tag);
    }
}

#pragma mark - Setter / Getter / Lazy


#pragma mark - Helper


#pragma mark - Other


#pragma mark - Public

@end
