//
//  HxbWelcomView.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbWelcomView.h"
@interface HxbWelcomView ()<UIScrollViewDelegate>
{
    UIView * _view;
}
@property (nonatomic, strong) NSArray *allImagePhotos;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

@end
@implementation HxbWelcomView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _view = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
        [_view addSubview:self.scrollView];
        [self setTheButton];
        [self addSubview:_view];
        [self addSubview:self.pageControl];
        
    }
    return self;
}

-(void)setTheButton{
    UIButton *btnEnter = [[UIButton alloc]init];
    btnEnter.backgroundColor = [UIColor clearColor];
    btnEnter.frame = CGRectMake((self.allImagePhotos.count -1)*_scrollView.frame.size.width,SCREEN_HEIGHT/2, SCREEN_WIDTH,SCREEN_HEIGHT/2);
    [btnEnter addTarget:self action:@selector(enterApp:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btnEnter];
}

-(void)enterApp:(UIButton*)btn{
    
    [UIView animateWithDuration:0.8f delay:0.0f options:UIViewAnimationOptionCurveLinear
                     animations:^
     {
         _view.alpha = 0.0f;
         _view.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 1);
         
     }
                     completion:^(BOOL finished)
     {
         // 完成后执行code
         [self removeFromSuperview];
     }
     ];
    
}

#pragma mark - UIScorllViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint point = scrollView.contentOffset;
    NSInteger index = round(point.x/scrollView.frame.size.width);
    
    NSLog(@">>>>>>>>>>>>>>>>>>>>%@",NSStringFromCGPoint(point));
    self.pageControl.currentPage = index;
    
    //     view=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //    view.backgroundColor = [UIColor clearColor];
    
    if (index ==2) {
        //        self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
        //        [self.leftSwipeGestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
        //
        //        [self.imageView addGestureRecognizer:self.leftSwipeGestureRecognizer];
        //        [self.view addSubview:view];
        //
        //    }else{
        //        [view setHidden:YES];
        //        [self.leftSwipeGestureRecognizer removeTarget:self action:nil];
        
    }
    
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.delegate = self;
        _scrollView.frame = [UIScreen mainScreen].bounds;
        _scrollView.contentSize = CGSizeMake(self.allImagePhotos.count*_scrollView.frame.size.width, _scrollView.frame.size.height);
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        for (NSInteger i = 0; i < self.allImagePhotos.count; i ++) {
            UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:self.allImagePhotos[i]]];
            imageView.userInteractionEnabled=YES;
            self.imageView = imageView;
            CGRect frame = CGRectZero;
            frame.size = _scrollView.frame.size;
            frame.origin = CGPointMake(_scrollView.frame.size.width*i, 0);
            imageView.frame = frame;
            NSLog(@"图片数量  ：%ld",(long)i);
            [_scrollView addSubview:imageView];
        }
    }
    return _scrollView;
}
-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.frame = CGRectMake(0, self.frame.size.height-30, self.frame.size.width, 30);
        _pageControl.numberOfPages = self.allImagePhotos.count;
        _pageControl.pageIndicatorTintColor = COR13;
        _pageControl.currentPageIndicatorTintColor = COR1;
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}
- (NSArray*) allImagePhotos {
    if (!_allImagePhotos) {
        _allImagePhotos = @[@"welcome1.png",@"welcome2.png",@"welcome3.png",@"welcome4.png"];
    }
    return _allImagePhotos;
}



@end
