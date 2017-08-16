
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

#import "SCAdView.h"

#define kImageViewTitleLabelH 25

@interface HXBBannerView ()<SCAdViewDelegate>

//@property (nonatomic, strong) SDCycleScrollView *bannerScrollView;
@property (nonatomic, strong) SCAdView *bannerView;

@end

@implementation HXBBannerView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

//        [self addSubview:self.bannerScrollView];
        [self addSubview:self.bannerView];
        
    }
    return self;
}


#pragma mark Get Method

- (SCAdView *)bannerView
{
    
    if (!_bannerView) {
        kWeakSelf
        _bannerView = [[SCAdView alloc] initWithBuilder:^(SCAdViewBuilder *builder) {
            builder.adArray = weakSelf.bannersModel;
            builder.viewFrame = self.bounds;
            builder.minimumInteritemSpacing = 0;
            builder.secondaryItemMinAlpha = 1.0;
            builder.threeDimensionalScale = 1.12;
            builder.adItemSize = (CGSize){kScrAdaptationW(325)/builder.threeDimensionalScale,kScrAdaptationH(110)/builder.threeDimensionalScale};
            builder.minimumLineSpacing = kScrAdaptationW(15) * builder.threeDimensionalScale;
            builder.infiniteCycle = 2.0;
            builder.itemCellNibName = @"HXBBannerCollectionViewCell";
        }];
        _bannerView.backgroundColor = [UIColor clearColor];
        _bannerView.delegate = self;
    }
    return _bannerView;
}
#pragma mark -delegate

-(void)sc_didClickAd:(id)adModel{
    NSLog(@"sc_didClickAd-->%@",adModel);
    if (self.clickBannerImageBlock) {
        self.clickBannerImageBlock(adModel);
    }
}
//-(void)sc_scrollToIndex:(NSInteger)index{
//    NSLog(@"sc_scrollToIndex-->%ld",index);
//}
//- (SDCycleScrollView *)bannerScrollView
//{
//    if (!_bannerScrollView) {
//        _bannerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds delegate:self placeholderImage:[UIImage imageNamed:@"bannerplaceholder"]];
//        _bannerScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
//        /** 自定义分页控件小圆标颜色 */
////        _bannerScrollView.currentPageDotColor = [UIColor whiteColor];
//        /** 在只有一张图时隐藏pagecontrol */
//        _bannerScrollView.hidesForSinglePage = YES;
//        /** 当前分页控件小圆标图片 */
//        _bannerScrollView.currentPageDotImage = [UIImage imageNamed:@"pageControl_select"];
//        /**  其他分页控件小圆标图片 */
//        _bannerScrollView.pageDotImage = [UIImage imageNamed:@"pageControl"];
//        /**  pagecontrol的动画样式 */
//        _bannerScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
//        /** 轮播文字label背景颜色 */
//        _bannerScrollView.titleLabelBackgroundColor = [UIColor clearColor];
//        /** 轮播文字label字体颜色 */
//        _bannerScrollView.titleLabelTextColor = [UIColor redColor];
//    }
//    return _bannerScrollView;
//}
#pragma mark Set Method
- (void)setBannersModel:(NSArray<BannerModel *> *)bannersModel
{
    _bannersModel = bannersModel;
     [self.bannerView reloadWithDataArray:bannersModel];
    //banner是否自动滚动打开下面三行代码
//    if (bannersModel.count) {
//        [self.bannerView play];
//    }
    
    
//    NSMutableArray *titlesGroup = [NSMutableArray array];
//    NSMutableArray *imageURLStringsGroup = [NSMutableArray array];
//    for (BannerModel *bannerModel in bannersModel) {
//        [titlesGroup addObject:bannerModel.title];
//        [imageURLStringsGroup addObject:bannerModel.image];
//    }
//    self.bannerScrollView.titlesGroup = titlesGroup;
//    self.bannerScrollView.imageURLStringsGroup = imageURLStringsGroup;
}
#pragma mark SDCycleScrollViewDelegate Method
///** 点击图片回调 */
//- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
//{
//    NSLog(@"%ld",(long)index);
//    if (self.clickBannerImageBlock) {
//        self.clickBannerImageBlock(self.bannersModel[index]);
//    }
//}

@end
