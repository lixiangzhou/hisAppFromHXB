//
//  AXHNewFeatureController.m
//  爱心汇
//
//  Created by kys-4 on 15/12/2.
//  Copyright © 2015年 kys-4. All rights reserved.
//

#import "AXHNewFeatureController.h"
#import "AXHNewFeatureCell.h"
#import "TAPageControl.h"
#import "TAExampleDotView.h"
#import "HXBBaseTabBarController.h"
#import "HXBGesturePasswordViewController.h"
#import "HXBDepositoryAlertViewController.h"
#import "HXBOpenDepositAccountViewController.h"

static NSString *const home = @"首页";
static NSString *const financing = @"理财";
static NSString *const my = @"我的";


@interface AXHNewFeatureController ()<TAPageControlDelegate>
@property (strong, nonatomic) TAPageControl *customPageControl2;
@property (nonatomic, strong) NSArray *imageData;
@property (nonatomic, strong) AXHNewFeatureCell *cell;

@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) HXBBaseTabBarController *mainTabbarVC;

@end

@implementation AXHNewFeatureController
static NSString *ID = @"collectionCell";
//流水布局必须设置一种布局
- (instancetype)init
{
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc] init];
    //设置cell的大小
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    //清空行距
    layout.minimumLineSpacing = 0;
    //设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return [super initWithCollectionViewLayout:layout];
}
//self.view != self.collectionView
//注意self.collectionView是self.view 的子控件
//1.使用UICollectionViewController
//初始化的时候设置布局参数
//必须UICollectionView要注册cell
//自定义cell
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageData =  @[@"银行存管", @"红利计划", @"安全保障", @"新版起航"];
    
//    self.collectionView.backgroundColor = [UIColor greenColor];
    //注册一个cell,默认就会创建这个类型的cell
    [self.collectionView registerClass:[AXHNewFeatureCell class] forCellWithReuseIdentifier:ID];
    //分页效果
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    // 添加pageController
    [self setUpPageControl];

}
// 添加pageController
- (void)setUpPageControl
{
    // 添加pageController,只需要设置位置，不需要管理尺寸
    
    self.customPageControl2               = [[TAPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame) - kScrAdaptationH750(120), CGRectGetWidth(self.view.frame), 40)];
    // Example for touch bullet event
    self.customPageControl2.delegate      = self;
    self.customPageControl2.numberOfPages = self.imageData.count;
    // Custom dot view
    self.customPageControl2.dotViewClass  = [TAExampleDotView class];
    self.customPageControl2.dotSize       = CGSizeMake(kScrAdaptationH750(14), kScrAdaptationH750(14));
    [self.view addSubview:self.customPageControl2];
    [self.view addSubview:self.startButton];
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(kScrAdaptationH750(350));
        make.height.offset(kScrAdaptationH750(82));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.customPageControl2.mas_top).offset(-kScrAdaptationH750(100));
    }];
}

// 只要一滚动就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取当前的偏移量，计算当前第几页
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    
    // 设置页数
    self.customPageControl2.currentPage = page;
    if (page == self.imageData.count - 1) { // 最后一页,显示分享和开始按钮
        self.startButton.hidden = NO;
    }else{ // 非最后一页，隐藏分享和开始按钮
        self.startButton.hidden = YES;
    }
}

//返回多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//返回第section组有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageData.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    // dequeueReusableCellWithReuseIdentifier
    //1.首先从缓存池里面取cell
    //2.看当前是否有注册过cell，如果注册了cell，就会帮你创建cell
    //3.没有注册就会报错
    AXHNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    _cell = cell;
     // 拼接图片名称 3.5 320 480
//    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    NSString *imageName = self.imageData[indexPath.row];
 
    cell.image = [UIImage imageNamed:imageName];
    
    return cell;
}

- (UIButton *)startButton
{
    if (_startButton == nil) {
        _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startButton setTitle:@"立即体验" forState:(UIControlStateNormal)];
        [_startButton setTitleColor:COR29 forState:(UIControlStateNormal)];
        [_startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        _startButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(32);
        _startButton.layer.cornerRadius = kScrAdaptationW750(8);
        _startButton.layer.masksToBounds = YES;
        _startButton.layer.borderWidth = kXYBorderWidth;
        _startButton.layer.borderColor = COR29.CGColor;
        _startButton.hidden = YES;
        
    }
    return _startButton;
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
        KeyWindow.rootViewController = gesturePasswordVC;
    }else
    {
        KeyWindow.rootViewController = self.mainTabbarVC;
    }
    [self showNewAlert];
    
}

// 展示开户弹框
- (void)showNewAlert {
    HXBDepositoryAlertViewController *alertVC = [[HXBDepositoryAlertViewController alloc] init];
    alertVC.immediateOpenBlock = ^{
        [HXBUmengManagar HXB_clickEventWithEnevtId:kHXBUmeng_alertBtn];
        HXBOpenDepositAccountViewController *openDepositAccountVC = [[HXBOpenDepositAccountViewController alloc] init];
//        openDepositAccountVC.userModel = viewModel;
        openDepositAccountVC.title = @"开通存管账户";
        openDepositAccountVC.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
//        KeyWindow.rootViewController = self.mainTabbarVC;
        [self.mainTabbarVC.childViewControllers[0] pushViewController:openDepositAccountVC animated:YES];
    };
    [KeyWindow.rootViewController presentViewController:alertVC animated:NO completion:nil];
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
