//
//  ViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/11.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "ViewController.h"
#import "HXBBaseCollectionView.h"
@interface ViewController ()

@end

@implementation ViewController
NSString *const a = @"tong";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    HXBBaseTextField *textField  = [[HXBBaseTextField alloc]initWithFrame:self.view.frame andBottomLienSpace:0 andBottomLienHeight:2 andRightButtonW:2];
    [self.view addSubview:textField];
    textField.isSecureTextEntry = true;
} 


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
