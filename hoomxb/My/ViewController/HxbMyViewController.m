//
//  HxbMyViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbMyViewController.h"
#import "AppDelegate.h"
#import "HxbMyView.h"
@interface HxbMyViewController ()
@property (nonatomic,copy) NSString *imageName;
@end

@implementation HxbMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageName = @"1";
    //登出按钮
//    [self.view addSubview:self.signOutButton];
    //对controllerView进行布局
    
    [self setupSubView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

//MARK: 对controllerView进行布局
- (void)setupSubView {
    //对navigationItem进行更改
    [self setupNavigation];
    [self setupMyView];
    
}

- (void)setupMyView{
    HxbMyView *myView = [[HxbMyView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:myView];
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
