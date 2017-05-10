//
//  HxbBindCardViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/9.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbBindCardViewController.h"

@interface HxbBindCardViewController ()
<
UINavigationBarDelegate
//UINavigationControllerDelegate
>

@end

@implementation HxbBindCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item{
    [self.navigationController popToRootViewControllerAnimated:YES];
    return YES;
}

@end
