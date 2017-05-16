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

    //登录的测试
    //对controllerView进行布局
//    [self setupSubView];
    
    //散标列表 红利计划的Button
    [self setupBUTTON];
}


//MARK: 对controllerView进行布局
- (void)setupSubView {
    [self setupMyView];
}

- (void)setupMyView{
    HxbMyView *myView = [[HxbMyView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:myView];
}



- (void) setupBUTTON {
    [self setupButton_MYPlan];
    [self setupButton_MYLoan];
}
- (void) setupButton_MYPlan {
    UIButton *myPlanBut = [UIButton hxb_textButton:@"plan" fontSize:20 normalColor:[UIColor blueColor] selectedColor:[UIColor redColor]];
    myPlanBut.frame = CGRectMake(100, 100, 100, 100);
    
    [self.view addSubview:myPlanBut];
    [myPlanBut addTarget:self action:@selector(clickMyPlanButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupButton_MYLoan {
    UIButton *myLoanBut = [UIButton hxb_textButton:@"loan" fontSize:20 normalColor:[UIColor blueColor] selectedColor:[UIColor redColor]];
    myLoanBut.frame = CGRectMake(100, 300, 100, 100);
    [self.view addSubview:myLoanBut];
    [myLoanBut addTarget:self action:@selector(clickMyLoanButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickMyPlanButton: (UIButton *)button {
    NSLog(@"%@ - 红利计划点击",self.class);
    
}

- (void)clickMyLoanButton: (UIButton *)button {
    NSLog(@"%@ - 散标被点击");
}
@end
