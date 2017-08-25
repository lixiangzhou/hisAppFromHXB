//
//  AXHNewFeatureCell.m
//  爱心汇
//
//  Created by kys-4 on 15/12/3.
//  Copyright © 2015年 kys-4. All rights reserved.
//

#import "AXHNewFeatureCell.h"
#import "HXBGesturePasswordViewController.h"
#import "HXBBaseTabBarController.h"


static NSString *const home = @"首页";
static NSString *const financing = @"理财";
static NSString *const my = @"我的";

@interface AXHNewFeatureCell ()

@property (nonatomic, weak) UIImageView *imageView;

//@property (nonatomic, weak) UIButton *shareButton;

@property (nonatomic, weak) UIButton *startButton;

@property (nonatomic, strong) HXBBaseTabBarController *mainTabbarVC;
@end

@implementation AXHNewFeatureCell

//- (UIButton *)shareButton
//{
//    if (_shareButton == nil) {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setTitle:@"分享给大家" forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [btn sizeToFit];
//        
//        [self.contentView addSubview:btn];
//        
//        _shareButton = btn;
//       
//    }
//     return _shareButton;
//}
- (UIButton *)startButton
{
    if (_startButton == nil) {
        UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [startBtn setTitle:@"立即体验" forState:(UIControlStateNormal)];
        [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        startBtn.hidden = YES;
        [self addSubview:startBtn];
        _startButton = startBtn;
    }
    return _startButton;
}
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        UIImageView *imageV = [[UIImageView alloc] init];
        _imageView = imageV;
        //注意：要加载到contentView上
        [self.contentView addSubview:imageV];
    }
    return _imageView;
}
//布局子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    
    // 分享按钮
//    self.shareButton.center = CGPointMake(self.width * 0.5, self.height * 0.8);
    
    
    // 开始按钮
    self.startButton.frame = CGRectMake(100, 100, 200, 200);
    self.startButton.backgroundColor = [UIColor redColor];
    
}
- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;
}
// 判断当前cell是否是最后一页
- (void)setIndexPath:(int)indexPath count:(int)count
{
    if (indexPath == count - 1) { // 最后一页,显示分享和开始按钮
//        self.shareButton.hidden = NO;
        self.startButton.hidden = NO;
    }else{ // 非最后一页，隐藏分享和开始按钮
//        self.shareButton.hidden = YES;
        self.startButton.hidden = YES;
    }
    NSLog(@"%d",indexPath);
}

// 点击开始微博的时候调用
- (void)start
{
//    // 进入tabBarVc
//    SignInViewController *signInVC = [[SignInViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:signInVC];
//    self.window.rootViewController = nav;
    // 切换根控制器:可以直接把之前的根控制器清空
//    AXHKeyWindow.rootViewController = signInVC;
    if ((KeyChain.gesturePwd.length >= 4) && [KeyChain isLogin] && [kUserDefaults boolForKey:kHXBGesturePWD]) {
        HXBGesturePasswordViewController *gesturePasswordVC = [[HXBGesturePasswordViewController alloc] init];
        gesturePasswordVC.type = GestureViewControllerTypeLogin;
        self.window.rootViewController = gesturePasswordVC;
        
    }else
    {
        self.window.rootViewController = self.mainTabbarVC;
    }
    
}
///懒加载主界面Tabbar
- (HXBBaseTabBarController *)mainTabbarVC
{
    if (!_mainTabbarVC) {
        _mainTabbarVC = [[HXBBaseTabBarController alloc]init];
        _mainTabbarVC.selectColor = [UIColor redColor];///选中的颜色
        _mainTabbarVC.normalColor = [UIColor grayColor];///平常状态的颜色
        
        NSArray *controllerNameArray = @[
                                         @"HxbHomeViewController",//首页
                                         @"HxbFinanctingViewController",//理财
                                         @"HxbMyViewController"];//我的
        //title 集合
        NSArray *controllerTitleArray = @[home,financing,my];
        NSArray *imageArray = @[@"home_Unselected.svg",@"investment_Unselected.svg",@"my_Unselected.svg"];
        //选中下的图片前缀
        NSArray *commonName = @[@"home_Selected.svg",@"investment_Selected.svg",@"my_Selected.svg"];
        
        
        [_mainTabbarVC subViewControllerNames:controllerNameArray andNavigationControllerTitleArray:controllerTitleArray andImageNameArray:imageArray andSelectImageCommonName:commonName];
        
    }
    return _mainTabbarVC;
}
@end
