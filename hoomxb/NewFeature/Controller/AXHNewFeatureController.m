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
@interface AXHNewFeatureController ()<TAPageControlDelegate>
@property (strong, nonatomic) TAPageControl *customPageControl2;
@property (nonatomic, strong) NSArray *imageData;
@property (nonatomic, strong) AXHNewFeatureCell *cell;
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
    self.imageData =  @[@"wuwangluo", @"wuwangluo", @"wuwangluo", @"wuwangluo"];
    
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
    
    self.customPageControl2               = [[TAPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame) - 40, CGRectGetWidth(self.view.frame), 40)];
    // Example for touch bullet event
    self.customPageControl2.delegate      = self;
    self.customPageControl2.numberOfPages = self.imageData.count;
    // Custom dot view
    self.customPageControl2.dotViewClass  = [TAExampleDotView class];
    self.customPageControl2.dotSize       = CGSizeMake(12, 12);
    
    [self.view addSubview:self.customPageControl2];
}

// 只要一滚动就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取当前的偏移量，计算当前第几页
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    
    // 设置页数
    self.customPageControl2.currentPage = page;
    [_cell setIndexPath:page count:self.imageData.count];
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
 
//    if (screenH > 480) { // 5 , 6 , 6 plus
//        imageName = [NSString stringWithFormat:@"new_feature_%ld-568h",indexPath.row + 1];
//    }
    cell.image = [UIImage imageNamed:imageName];
    
    
    return cell;
}


@end
