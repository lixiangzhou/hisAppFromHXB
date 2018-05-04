//
//  HXBUserMigrationViewController.m
//  hoomxb
//
//  Created by hxb on 2018/5/2.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBUserMigrationViewController.h"
#import "HXBUserMigrationViewModel.h"
#import "HXBLazyCatAccountWebViewController.h"
#import "AppDelegate.h"
@interface HXBUserMigrationViewController ()

@property (nonatomic, strong) HXBUserMigrationViewModel *viewModel;
@property (nonatomic, strong) UIImageView *imageV;
@end

@implementation HXBUserMigrationViewController

- (instancetype) init {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.view.alpha = 0.6f;
    [self.view addSubview:self.imageV];
    [self setupSubViewFrame];
}

- (void)setupSubViewFrame
{
    kWeakSelf
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).offset(kScrAdaptationH750(70));
        make.left.equalTo(weakSelf.view.mas_left).offset(kScrAdaptationW750(40));
        make.right.equalTo(weakSelf.view.mas_right).offset(kScrAdaptationW750(-40));
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(kScrAdaptationH750(-70));
    }];
}

-(void)tapImageV:(UITapGestureRecognizer *)recognizer {
    kWeakSelf
    [weakSelf.viewModel requestUserMigrationInfoFinishBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            HXBLazyCatAccountWebViewController *lazyCatWebVC = [HXBLazyCatAccountWebViewController new];
            lazyCatWebVC.requestModel = weakSelf.viewModel.lazyCatRequestModel;
           
            if (self.pushBlock) {
                self.pushBlock();
            }
            [weakSelf dismissViewControllerAnimated:true completion:nil];
        }
    }];
}

- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [UIImageView new];
        _imageV.contentMode = UIViewContentModeScaleAspectFit;
        _imageV.userInteractionEnabled = YES;
         UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageV:)];
        [_imageV addGestureRecognizer:tapRecognize];
        _imageV.image = [UIImage imageNamed:@"AppIcon"];
    }
    return _imageV;
}

- (HXBUserMigrationViewModel *)viewModel {
    if (!_viewModel) {
        kWeakSelf
        _viewModel = [[HXBUserMigrationViewModel alloc] initWithBlock:^UIView *{
            return weakSelf.view;
        }];
    }
    return _viewModel;
}

@end
