//
//  HxbMyViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbMyViewController.h"

@interface HxbMyViewController ()
@property (nonatomic,strong) UIButton *signOutButton;
@property (nonatomic,copy) NSString *imageName;
@end

@implementation HxbMyViewController
//登出按钮
- (UIButton *)signOutButton{
    if (!_signOutButton) {
        _signOutButton = [UIButton btnwithTitle:@"Sign Out" andTarget:self andAction:@selector(signOutButtonButtonClick:) andFrameByCategory:CGRectMake(20, SCREEN_HEIGHT /2 + 100, SCREEN_WIDTH - 40, 44)];
    }
    return _signOutButton;
}
//登出按钮事件
- (void)signOutButtonButtonClick:(UIButton *)sender{
//    [KeyChain removeAllInfo];
    UIViewController *VC =[[UIViewController alloc]init];
    VC.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:VC animated:true];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageName = @"1";
    //登出按钮
    [self.view addSubview:self.signOutButton];
    //对controllerView进行布局
    [self setupSubView];
}


//MARK: 对controllerView进行布局
- (void)setupSubView {
    //对navigationItem进行更改
    [self setupNavigation];
    
}
//MARK: 对navigationItem进行更改
- (void)setupNavigation {
    UIImage *image = [UIImage imageNamed:@"1"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(clickBarButtonItem)];

    [self.navigationItem setLeftBarButtonItem:leftBarButtonItem];
}
- (void)clickBarButtonItem {
    NSLog(@"点击了返回按钮");
}

@end
