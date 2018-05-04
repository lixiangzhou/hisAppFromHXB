//
//  HXBBaseNavigationController.m
//  hoomxb
//
//  Created by HXB on 2017/4/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseNavigationController.h"

@interface HXBBaseNavigationController ()<UIGestureRecognizerDelegate> {
    NSInteger _viewControllerCountWhenRightGesture; //右滑时， 控制器的数量
    BOOL _occurRightGestureAction; //是否发生了向右滑动的手势动作
}

@property (nonatomic, strong) UIPanGestureRecognizer *fullScreenGesture;
@end

//观察者上下文
static void *sObserveContext = &sObserveContext;

@implementation HXBBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(-3, -3)];
    
    id target = self.interactivePopGestureRecognizer.delegate;
    SEL handler = NSSelectorFromString(@"handleNavigationTransition:");
    UIView *targetView = self.interactivePopGestureRecognizer.view;
    self.fullScreenGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:handler];
    self.fullScreenGesture.delegate = self;
    [targetView addGestureRecognizer:self.fullScreenGesture];
    self.enableFullScreenGesture = YES;
    // 关闭边缘触发手势 防止和原有边缘手势冲突
    [self.interactivePopGestureRecognizer setEnabled:NO];
    [self addObservers];
}

- (void)dealloc {
    [self.fullScreenGesture removeObserver:self forKeyPath:@"state"];
}

#pragma 增加观察者
- (void)addObservers {
    [self.fullScreenGesture addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:sObserveContext];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == sObserveContext) {
        if ([keyPath isEqualToString:@"state"]) {
            NSNumber* state = [change valueForKey:@"new"];
            if (UIGestureRecognizerStateBegan == state.integerValue) {//右滑手势开始生效
                self.occurRightGestureAction = YES;
            }
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - override push
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count >= 1)
    {
        //第一次push的时候， 强制手滑返回可用
        if(1 == self.viewControllers.count) {
            self.enableFullScreenGesture = YES;
        }
        viewController.hidesBottomBarWhenPushed = YES;
        self.navigationBar.hidden = NO;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
    if (viewControllers.count >= 1)
    {
        //第一次push的时候， 强制手滑返回可用
        if(1 == self.viewControllers.count) {
            self.enableFullScreenGesture = YES;
        }
        viewControllers.lastObject.hidesBottomBarWhenPushed = YES;
        self.navigationBar.hidden = NO;
    }
    
    [super setViewControllers:viewControllers animated:animated];
}

#pragma mark - override pop
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    UIViewController *popViewController = [super popViewControllerAnimated:animated];
    _viewControllerCountWhenRightGesture = self.viewControllers.count;
    
    return popViewController;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    ///这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）3、向左滑
    BOOL panLeft = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:gestureRecognizer.view].x > 0;
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue] && panLeft;
}

#pragma mark - Setter
- (void)setEnableFullScreenGesture:(BOOL)enableFullScreenGesture {
    _enableFullScreenGesture = enableFullScreenGesture;
    if (self.fullScreenGesture) {
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.fullScreenGesture];
    }
    self.fullScreenGesture.enabled = enableFullScreenGesture;
}

#pragma mark - setter pop的自定义
- (void)popViewControllerWithToViewController: (NSString *)toViewControllerStr andAnimated: (BOOL)animated{
    for (UIViewController *toVC in self.childViewControllers) {
        if ([NSStringFromClass(toVC.class) isEqualToString:toViewControllerStr]) {
            [self popToViewController:toVC animated:animated];
        }
    }
}

#pragma mark occurRightGestureAction属性方法
- (void)setOccurRightGestureAction:(BOOL)occurRightGestureAction {
    _occurRightGestureAction = occurRightGestureAction;
    if (!_occurRightGestureAction) {
        _viewControllerCountWhenRightGesture = self.viewControllers.count;
    }
}

- (BOOL)occurRightGestureAction {
    if (_occurRightGestureAction) {
        //这个状态下表明，松手后，确实滑动返回到前一个页面了；因此将occurRightGestureAction重置为NO，相当于正常的点击返回按钮动作一样。
        if (_viewControllerCountWhenRightGesture == self.viewControllers.count) {
            _occurRightGestureAction = NO;
            return NO;
        }
    }
    return _occurRightGestureAction;
}
@end
