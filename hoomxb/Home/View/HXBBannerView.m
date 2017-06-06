
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

@interface HXBBannerView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIImageView *bannerimageView;


@end

@implementation HXBBannerView
{
    CGFloat _imageWidth;
    CGFloat _imageHeight;
    NSInteger _pageIndex;
    NSInteger _imageIndex;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageWidth = frame.size.width;
        _imageHeight = frame.size.height;
        _pageIndex = 0;
        _imageIndex = 0;
        
        [self addSubview:self.scrollView];
        
    }
    return self;
}

//自定义pageControl
- (void)changePageControlImage:(UIPageControl *)pageControl
{
    static UIImage *currentImage = nil;
    static UIImage *otherImage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currentImage = [UIImage imageNamed:@"pageControl_select"];
        otherImage = [UIImage imageNamed:@"pageControl"];
    });
   
    [pageControl setValue:currentImage forKey:@"_currentPageImage"];
    [pageControl setValue:otherImage forKey:@"_pageImage"];
}

#pragma mark Private Method
//设置scrollview大小及contentsize
- (void)configScrollView
{
    if (_imageIndex == 1) {
        self.scrollView.contentSize = CGSizeMake(_imageWidth, 0);
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }else{
        self.scrollView.contentSize = CGSizeMake((_bannersModel.count + 2) * _imageWidth, 0);
        self.scrollView.contentOffset = CGPointMake(_imageWidth, 0);
    }
}

//根据图片数量生成imageview
- (void)setImageViews
{
    if (!_imageIndex) {
        if (self.bannerimageView) {
            [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj removeFromSuperview];
            }];
        }
         [self.timer invalidate];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bannerplaceholder"]];
        imageView.frame = CGRectMake(_imageWidth , 0, _imageWidth, _imageHeight);
        self.scrollView.scrollEnabled = NO;
        [self.scrollView addSubview:imageView];
        return;
    }

    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    
   
    for (NSInteger i = 0; i < _bannersModel.count + 2; i ++)
    {
        self.scrollView.scrollEnabled = YES;
        _bannerimageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"banner.png"]];
        _bannerimageView.userInteractionEnabled = YES;
//        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bannerClick)]];
        [_bannerimageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bannerClickWithModel)]];
        _bannerimageView.frame = CGRectMake(_imageWidth * i, 0, _imageWidth, _imageHeight);
        NSLog(@"%@",_bannersModel);
        NSURL *imgUrl = nil;
        // [aString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
        if (i == 0) {
            imgUrl = [NSURL URLWithString:[_bannersModel[_imageIndex - 1].picUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }else if (i == _imageIndex + 1){
            imgUrl = [NSURL URLWithString:[_bannersModel[0].picUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }else{
            imgUrl = [NSURL URLWithString:[_bannersModel[i - 1].picUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
        [_bannerimageView sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"bannerplaceholder"]];
        
        [self.scrollView addSubview:_bannerimageView];
    }
    [self addSubview:self.pageControl];
    self.pageControl.numberOfPages = _bannersModel.count;
    self.pageControl.currentPage = 0;
    
    [self beginScrollAnimation];

}

//切换图片操作
- (void)changePageIndex
{
    if (_imageIndex == 1) {
        return;
    }
    
    _pageIndex ++;
    if (_pageIndex == _pageControl.currentPage) {
        _pageIndex = 0;
    }
    
    [UIView animateWithDuration:0.8f animations:^{
        _scrollView.contentOffset = CGPointMake(_scrollView.contentOffset.x + _imageWidth, 0);
    } completion:^(BOOL finished) {
        _pageControl.currentPage = _pageIndex;
    }];
    
    [self updateIndexAndLocation];
}

//更新图片index及位置
- (void)updateIndexAndLocation
{
    NSInteger index = _scrollView.contentOffset.x / _imageWidth;
    if (index == 0) {
        _pageIndex = _imageIndex;
        _scrollView.contentOffset = CGPointMake(_imageWidth * _imageIndex, 0);
    }else if (index == _imageIndex + 1){
        _scrollView.contentOffset = CGPointMake(_imageWidth, 0);
        _pageIndex = 0;
    }else{
        _pageIndex = index - 1;
    }
}

//开始进行
- (void)beginScrollAnimation
{
    [self.timer invalidate];
    self.timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(changePageIndex) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

//点击banner图片
- (void)bannerClickWithModel    // model click
{
//    if (_pageIndex > _bannersModel.count-1 || !_bannersModel )
        if ( !_bannersModel )
    {
        return;
    }
    
    NSString *urlStr;
    if (_pageIndex > _bannersModel.count -1)
    {
        urlStr = [_bannersModel[_pageIndex - 1] linkUrl]? :@"" ;
        
        if (!urlStr.length) {
            return;
        }
        id next = [self nextResponder];
        while (![next isKindOfClass:[HxbHomeViewController class]]) {
            next = [next nextResponder];
        }
        if ([next isKindOfClass:[HxbHomeViewController class]]) {
            HxbHomeViewController *vc = (HxbHomeViewController *)next;
            [vc showBannerWebViewWithModel:_bannersModel[_pageIndex -1]];
        }
    }else{
        urlStr = [_bannersModel[_pageIndex] linkUrl]? :@"" ;
        
        if (!urlStr.length) {
            return;
        }
        id next = [self nextResponder];
        while (![next isKindOfClass:[HxbHomeViewController class]]) {
            next = [next nextResponder];
        }
        if ([next isKindOfClass:[HxbHomeViewController class]]) {
            HxbHomeViewController *vc = (HxbHomeViewController *)next;
            [vc showBannerWebViewWithModel:_bannersModel[_pageIndex]];
        }
    }
}

- (void)bannerClick // url click
{
    if (_pageIndex > _bannersModel.count-1 || !_bannersModel ) {
        return;
    }
    
    NSString *urlStr = [_bannersModel[_pageIndex] linkUrl]? :@"" ;
    if (!urlStr.length) {
        return;
    }
    NSString *finalUrlStr = [urlStr stringByAppendingFormat:@"?token=%@",[KeyChain token]];
    id next = [self nextResponder];
    while (![next isKindOfClass:[HxbHomeViewController class]]) {
        next = [next nextResponder];
    }
    if ([next isKindOfClass:[HxbHomeViewController class]]) {
        HxbHomeViewController *vc = (HxbHomeViewController *)next;
        [vc showBannerWebViewWithURL:finalUrlStr];
    }
}

#pragma mark UIScrollView Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updateIndexAndLocation];
    self.pageControl.currentPage = _pageIndex;
    [self beginScrollAnimation];
}

#pragma mark Set/Get Methods
- (void)setBannersModel:(NSArray *)bannersModel
{
    _bannersModel = bannersModel;
    _imageIndex = _bannersModel.count;
    [self configScrollView];
    [self setImageViews];
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _imageWidth, _imageHeight)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.alwaysBounceVertical = NO;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, _imageHeight - 15, _imageWidth, 3)];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:255.f green:255.f blue:255.f alpha:0.5];
        _pageControl.userInteractionEnabled = NO;
        [self changePageControlImage:_pageControl];
    }
    return _pageControl;
}
@end
