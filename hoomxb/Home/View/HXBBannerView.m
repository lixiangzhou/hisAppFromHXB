
//
//  NYBannerView.m
//  NYBannerView
//
//  Created by 牛严 on 16/7/4.
//
//

#import "HXBBannerView.h"
#import "HxbHomeViewController.h"

#import "BannerModel.h"
#import <UIImageView+WebCache.h>

#define kImageViewTitleLabelH 25

@interface HXBBannerView ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *bannerScrollView;

@end

@implementation HXBBannerView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self addSubview:self.bannerScrollView];
        
    }
    return self;
}


#pragma mark Get Method
- (SDCycleScrollView *)bannerScrollView
{
    if (!_bannerScrollView) {
        _bannerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _bannerScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        /** 自定义分页控件小圆标颜色 */
//        _bannerScrollView.currentPageDotColor = [UIColor whiteColor];
        /** 在只有一张图时隐藏pagecontrol */
        _bannerScrollView.hidesForSinglePage = YES;
        /** 当前分页控件小圆标图片 */
        _bannerScrollView.currentPageDotImage = [UIImage imageNamed:@"pageControl_select"];
        /**  其他分页控件小圆标图片 */
        _bannerScrollView.pageDotImage = [UIImage imageNamed:@"pageControl"];
        /**  pagecontrol的动画样式 */
        _bannerScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        /** 轮播文字label背景颜色 */
        _bannerScrollView.titleLabelBackgroundColor = [UIColor clearColor];
        /** 轮播文字label字体颜色 */
        _bannerScrollView.titleLabelTextColor = [UIColor redColor];
    }
    return _bannerScrollView;
}
#pragma mark Set Method
- (void)setBannersModel:(NSArray<BannerModel *> *)bannersModel
{
    _bannersModel = bannersModel;
    NSMutableArray *titlesGroup = [NSMutableArray array];
    NSMutableArray *imageURLStringsGroup = [NSMutableArray array];
    for (BannerModel *bannerModel in bannersModel) {
        [titlesGroup addObject:bannerModel.title];
        [imageURLStringsGroup addObject:bannerModel.picUrl];
    }
    self.bannerScrollView.titlesGroup = titlesGroup;
    self.bannerScrollView.imageURLStringsGroup = imageURLStringsGroup;
}
#pragma mark SDCycleScrollViewDelegate Method
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"%ld",(long)index);
    if (self.clickBannerImageBlock) {
        self.clickBannerImageBlock(self.bannersModel[index]);
    }
}

@end
