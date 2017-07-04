//
//  PYScrollToolBarView.m
//  PYToolBarView
//
//  Created by HXB on 2017/4/24.
//  Copyright © 2017年 liPengYue. All rights reserved.
//

#import "HXBBaseScrollToolBarView.h"
#import "HXBBaseToolBarView.h"
#define kToolBarViewOffsetTop CGPointMake(0, self.kTopViewH)
#define kToolBarViewOffsetBottom CGPointMake(0, 0)

@interface HXBBaseScrollToolBarView () <UIScrollViewDelegate>


//MARK: 常用的距离参考字段，在layoutSubView里面进行了赋值
@property (nonatomic,assign) BOOL isConstantChange;//是否进行下面的参考距离的计算
@property (nonatomic,assign) CGFloat kScrollToolBarViewW;//self.Width
@property (nonatomic,assign) CGFloat kScrollToolBarViewH;//self.height
@property (nonatomic,assign) CGFloat kTopViewH;//self.topView.height
@property (nonatomic,assign) CGFloat kMidToolBarViewW;//self.midToolBarView.width
@property (nonatomic,assign) CGFloat kMidToolBarViewH;
@property (nonatomic,assign) CGFloat kBottomScrollViewH;//self.BottomScrollView.height
@property (nonatomic,assign) CGFloat kBottomScrollViewY;//self.bottomScrollView.Y
@property (nonatomic,assign) BOOL isSetupSubView;//是否布局子控件
@property (nonatomic,assign) CGFloat offsetY;//当前的scrollView 与self的偏移量的差值
@property (nonatomic,assign) CGFloat kInsertffsetY;
//MARK: subView
@property (nonatomic,strong) UIView *topView;///顶部的展示view
@property (nonatomic,strong) HXBBaseToolBarView *midToolBarView;///中间的工具栏
//底部的scrollView，里面装了从外面传进来的view的集合
@property (nonatomic,strong) UIScrollView *bottomScrollView;


//MARK: 事件传递的block
@property (nonatomic,copy) void(^switchBottomScrollViewBlock)(NSInteger index, NSString *title,UIButton *option);

@end



@implementation HXBBaseScrollToolBarView

@synthesize bottomViewSet = _bottomViewSet;

#pragma mark - getter
- (UIScrollView *) bottomScrollView {
    if (!_bottomScrollView) {
        _bottomScrollView = [[UIScrollView alloc]init];
    }
    return _bottomScrollView;
}
- (NSArray *)bottomViewSet {
    if (!_bottomViewSet) {
        _bottomViewSet = [[NSArray alloc]init];
    }
    return _bottomViewSet;
}

#pragma mark - setter
- (void)setBottomViewSet:(NSArray<UIView *> *)bottomViewSet {
    _bottomViewSet = bottomViewSet;
    self.isSetupSubView = true;
    self.isConstantChange = true;
}
- (void)setSelectToolBarViewIndex:(NSInteger)selectToolBarViewIndex {
    _selectToolBarViewIndex = selectToolBarViewIndex;
    self.midToolBarView.selectItemIndex = selectToolBarViewIndex;
}

#pragma mark - 回调事件的传递
///对于中间的ToolBarView点击事件的回调
- (void)midToolBarViewClickWithBlock: (void(^)(NSInteger index, NSString *title,UIButton *option))clickMidToolBarViewBlock {
}
- (void)switchBottomScrollViewCallBack:(void (^)(NSInteger, NSString *, UIButton *))switchBottomScrollViewBlock {
    self.switchBottomScrollViewBlock = switchBottomScrollViewBlock;
}
#pragma mark - 构造方法
+ (instancetype) scrollToolBarViewWithFrame:(CGRect)frame
                                 andTopView:(UIView *)topView
                                andTopViewH:(CGFloat)topViewH
                          andMidToolBarView:(HXBBaseToolBarView *)midToolBarView
                    andMidToolBarViewMargin:(CGFloat)midToolBarViewMargin
                         andMidToolBarViewH:(CGFloat)midToolBarViewH
                           andBottomViewSet:(NSArray <UIView *>*)bottomViewSet
{
    return [[self alloc]initWithFrame:frame andTopView:topView andTopViewH: topViewH andMidToolBarView:midToolBarView andMidToolBarViewMargin:midToolBarViewMargin  andMidToolBarViewH:midToolBarViewH andBottomViewSet:bottomViewSet];
}
- (instancetype) initWithFrame:(CGRect)frame
                        andTopView:(UIView *)topView
                       andTopViewH:(CGFloat)topViewH
                 andMidToolBarView:(HXBBaseToolBarView *)midToolBarView
           andMidToolBarViewMargin:(CGFloat)midToolBarViewMargin
                andMidToolBarViewH:(CGFloat)midToolBarViewH
                  andBottomViewSet:(NSArray <UIView *>*)bottomViewSet
{
    if (self = [super initWithFrame:frame]) {
        self.topView = topView;
        self.kTopViewH = topViewH;
        self.midToolBarViewMargin = midToolBarViewMargin;
        self.midToolBarView = midToolBarView;
        self.kMidToolBarViewH = midToolBarViewH;
        self.bottomViewSet = bottomViewSet;
        self.isConstantChange = true;
        self.isSetupSubView = true;
        
    }
    return self;
}


#pragma mark - layoutSubViews 布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    //常用变量的计算
    [self calculateValue];
    //布局子控件
    [self setupSubViewWithISSetupSubView:self.isSetupSubView];
    self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height + self.kTopViewH);
}

//根据self.isConstantChange，判断是否进行常用变量的计算
- (void)calculateValue {
    if (self.isConstantChange) {
        self.isConstantChange = false;
        self.contentOffset = CGPointMake(0, 0);
        self.kScrollToolBarViewH = self.frame.size.height;
        self.kScrollToolBarViewW = self.frame.size.width;
        self.kMidToolBarViewW = self.kScrollToolBarViewW - self.midToolBarViewMargin * 2;
        self.kBottomScrollViewH = self.kScrollToolBarViewH - self.kMidToolBarViewH;
        self.kBottomScrollViewY = self.kTopViewH + self.kMidToolBarViewH;
        self.selectToolBarViewIndex = self.midToolBarView.selectItemIndex;
    }
}

//布局子控件
- (void)setupSubViewWithISSetupSubView: (BOOL)isSetupSubView {
    if (!isSetupSubView) {
        return;
    }
    self.isSetupSubView = NO;
    //布局topView
    [self setupTopView];
    //布局midToolBarView
    [self setupMidToolBarView];
    //布局底部的ScrollView （把外界传入的View集合，添加到scrollView上）
    [self setupBottomScrollView];
}

//布局topView
- (void)setupTopView {
    self.topView.frame = CGRectMake(0, 0, self.kScrollToolBarViewW, self.kTopViewH);
    [self addSubview:self.topView];
}

//布局中间的toolBarView
- (void)setupMidToolBarView {
    self.midToolBarView.frame = CGRectMake(self.midToolBarViewMargin, self.kTopViewH, self.kMidToolBarViewW, self.kMidToolBarViewH);
    [self addSubview: self.midToolBarView];
    
    //MARK: 中间的toolbarView点击事件的回调
    __weak typeof (self)weakSelf = self;
    [self.midToolBarView clickOptionItemBLockFuncWithClickOptionItemBlock:^(UIButton *button, NSString *itemText, NSInteger index) {
        CGFloat contentOffsetX = index * weakSelf.kScrollToolBarViewW;
        weakSelf.bottomScrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        //如果点击事件回调被实现，那么执行外部的回调事件
        if (weakSelf.switchBottomScrollViewBlock) weakSelf.switchBottomScrollViewBlock(index,itemText,button);
    }];
    [self.midToolBarView show];
}

//布局底部的ScrollView （把外界传入的View集合，添加到scrollView上）
- (void)setupBottomScrollView {
    self.bottomScrollView = [[UIScrollView alloc]init];
    
    self.bottomScrollView.frame = CGRectMake(0, self.kBottomScrollViewY, self.kScrollToolBarViewW, self.kBottomScrollViewH);
//    self.bottomScrollView.frame = CGRectMake(0, 0, _kScrollToolBarViewW, _kScrollToolBarViewH);
//      self.bottomScrollView.frame = CGRectMake(0, 0, self.kScrollToolBarViewW, self.kScrollToolBarViewH);
    CGFloat bottomScrollViewContentSizeX = self.bottomViewSet.count * self.kScrollToolBarViewW;
    self.bottomScrollView.contentSize = CGSizeMake(bottomScrollViewContentSizeX, self.kBottomScrollViewH);

    self.bottomScrollView.delegate = self;
    self.bottomScrollView.pagingEnabled = true;
    self.bottomScrollView.showsVerticalScrollIndicator = false;
    self.bottomScrollView.showsHorizontalScrollIndicator = false;
    self.contentOffset = CGPointMake(self.midToolBarView.selectItemIndex * self.kScrollToolBarViewW, 0);
    self.bounces = false;
    [self addSubview: self.bottomScrollView];
    
    //布局bottomScrollView内部的Views
    [self setupScrollContentSubViews];
}

//布局bottomScrollView内部的Views
- (void)setupScrollContentSubViews {
    __weak typeof (self)weakSelf = self;
    [self.bottomViewSet enumerateObjectsUsingBlock:^(UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        view.frame = CGRectMake(idx * weakSelf.kScrollToolBarViewW, 0, weakSelf.kScrollToolBarViewW,weakSelf.kBottomScrollViewH);
        [weakSelf.bottomScrollView addSubview:view];
        //如果是UIScrollView并且topView有高度的话就监听一下他的contentOffset
        if ([view isKindOfClass:NSClassFromString(@"UIScrollView")] && weakSelf.kTopViewH) {
            UIScrollView *scrollView = (UIScrollView *)view;
            //添加观察者
            [scrollView addObserver:weakSelf forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        }
    }];
}


//观察者的回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        UIScrollView *scrollView = (UIScrollView *) object;
        NSNumber *newContentOffsetNum = [change valueForKey:NSKeyValueChangeNewKey];
        CGPoint newContentOffset = newContentOffsetNum.CGPointValue;
        NSNumber *oldContentOffsetNum = [change valueForKey:NSKeyValueChangeOldKey];
        CGPoint oldContentOffset = oldContentOffsetNum.CGPointValue;
        
        BOOL isDown = oldContentOffset.y > newContentOffset.y;
        BOOL isScrollBottom = scrollView.contentSize.height - scrollView.contentOffset.y <= scrollView.frame.size.height;
       
        
        //改变scrollView偏移的位置
//        if (self.contentOffset.y <= 0){
//            if (newContentOffset.y < 0) self.offsetY = 0;
//             //偏移到顶
//            self.contentOffset = kToolBarViewOffsetBottom;
//        }
//        
//        if (self.contentOffset.y >= self.kTopViewH) {
//            if (newContentOffset.y > self.kTopViewH) self.offsetY = 0;
//              //偏移到底
//            self.contentOffset = kToolBarViewOffsetTop;
//        }
        
        
        //偏移量的计算
        //向下拉
//        BOOL isDown = oldContentOffset.y > newContentOffset.y;
//        BOOL isScrollViewNotScroll = scrollView.contentSize.height < scrollView.frame.size.height;
//        BOOL isTracking = scrollView.dragging && scrollView.tracking && !scrollView.decelerating;
//        BOOL isGreater = self.contentOffset.y > newContentOffset.y;
        
        if (isDown && (newContentOffset.y <= 0)) {
            self.offsetY = 0;
        }
        if (!isDown && newContentOffset.y >= self.kTopViewH) {
            self.offsetY = 0;
        }
        
        if (scrollView.contentSize.height < scrollView.frame.size.height) {
            CGPoint point = [scrollView.panGestureRecognizer translationInView:self];
            self.contentOffset = CGPointMake(0, -point.y + self.contentOffset.y);
            self.offsetY = self.contentOffset.y;
        } else {
            self.contentOffset = CGPointMake( 0, self.offsetY + newContentOffset.y);
            if (isScrollBottom) {
                self.contentOffset = kToolBarViewOffsetTop;
                return;
            }
        }
//        NSLog(@"|| self.offsetY ->%lf",self.offsetY);
//        NSLog(@"|| newContentOffset.y ->%lf",newContentOffset.y);
//        self.contentOffset = CGPointMake( 0, self.offsetY + newContentOffset.y);
////        if (self.contentOffset.y <= 0 && newContentOffset.y <= 0) {
////            self.offsetY = 0;
////        }
////        if (self.contentOffset.y >= self.kTopViewH && newContentOffset.y >= self.kTopViewH) {
////            self.offsetY = 0;
////        }
        
////        if (isDown && isScrollViewNotScroll && isTracking) {
////            [self setContentOffset:CGPointMake(0, 0) animated:true];
////        }else if (!isDown && isScrollViewNotScroll && isTracking) {
////            [self setContentOffset:CGPointMake(0, _kTopViewH) animated:true];
////        }else {
//            self.contentOffset = CGPointMake( 0, self.offsetY + newContentOffset.y);
////        }
        //是否滑到了底部
        
        if (self.contentOffset.y <= 0) {
            self.contentOffset = kToolBarViewOffsetBottom;
        }
        if (self.contentOffset.y >= self.kTopViewH) {
            self.contentOffset = kToolBarViewOffsetTop;
        }
    }
}


#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self) {
        //防止self 滑动过大，从而超出范围
        if (self.contentOffset.y >= self.kTopViewH){
            self.contentOffset = CGPointMake(0,self.kTopViewH);
        }
    }
    if (scrollView == self.bottomScrollView) {
        //计算偏移量，并且给midToolBarView的selectIndex赋值
        NSInteger index = round(scrollView.contentOffset.x / self.kScrollToolBarViewW);
        if (index != self.midToolBarView.selectItemIndex) {
            //如果越界了，就直接return
            if (index < 0 || index >= self.bottomViewSet.count) return;
            //直接赋值
            self.midToolBarView.selectItemIndex = index;
            //给self.offsetY赋值
            if ([self.bottomViewSet[index] isKindOfClass:NSClassFromString(@"UIScrollView")]) {
                UIScrollView *scrollView = (UIScrollView *)self.bottomViewSet[index];
                self.offsetY = self.contentOffset.y - scrollView.contentOffset.y;
            }
            //如果点击事件回调被实现，那么执行外部的回调事件
            if (self.switchBottomScrollViewBlock) {
                UIButton *option = self.midToolBarView.optionItemInfo[index];
                NSString *title = self.midToolBarView.optionStrArray[index];
                self.switchBottomScrollViewBlock(index, title, option);
            }
        }
    }
}

- (void)dealloc{
    //销毁观察者：
    [self.bottomViewSet enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass: [UIScrollView class]]) {
            [obj removeObserver:self forKeyPath:@"contentOffset"];
        }
    }];
    NSLog(@"%@ - ✅被销毁",self.class);
}
@end
