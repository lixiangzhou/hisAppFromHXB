//
//  HXBFinancing_PlanViewController.m
//  hoomxb
//
//  Created by HXB on 2017/5/4.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinancing_PlanDetailsViewController.h"
#import "HXBFin_PlanDetailsView.h"



@interface HXBFinancing_PlanDetailsViewController ()
@property(nonatomic,strong) HXBFin_PlanDetailsView *planDetailsView;
@end

@implementation HXBFinancing_PlanDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

//MARK: ------ setup -------
- (void)setup {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.planDetailsView = [[HXBFin_PlanDetailsView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.planDetailsView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
