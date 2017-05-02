//
//  HxbMyViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbMyViewController.h"
#import "AppDelegate.h"

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
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        NSLog(@"%@",action.title);
        
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [KeyChain removeAllInfo];
        [((AppDelegate*)[UIApplication sharedApplication].delegate).mainTabbarVC setSelectedIndex:0];
        
    }];
    
    [alertController addAction:cancelAction];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
//    UIViewController *VC =[[UIViewController alloc]init];
//    VC.view.backgroundColor = [UIColor redColor];
//    [self.navigationController pushViewController:VC animated:true];

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
