//
//  HXBAccountActivationViewController.m
//  hoomxb
//
//  Created by caihongji on 2018/5/2.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBAccountActivationViewController.h"

@interface HXBAccountActivationViewController ()

@property (nonatomic, strong) Animatr *animatr;

@property (nonatomic, strong) UIView* contentView;
@property (nonatomic, strong) UIButton* imgButton;

@end

@implementation HXBAccountActivationViewController

- (instancetype) init {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self.animatr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUPAnimater];
    [self setupUI];
    [self addConstraints];
}

- (Animatr *)animatr {
    if (!_animatr) {
        _animatr = [Animatr animatrWithModalPresentationStyle:UIModalPresentationCustom];
    }
    return _animatr;
}

- (void)setUPAnimater{
    __weak typeof (self)weakSelf = self;
    [self.animatr presentAnimaWithBlock:^(UIViewController *toVC, UIViewController *fromeVC, UIView *toView, UIView *fromeView) {
        toView.center = [UIApplication sharedApplication].keyWindow.center;
        toView.bounds = CGRectMake(0, 0, kScrAdaptationW(295), kScrAdaptationH(445));
        weakSelf.animatr.isAccomplishAnima = YES;
    }];
    [self.animatr dismissAnimaWithBlock:^(UIViewController *toVC, UIViewController *fromeVC, UIView *toView, UIView *fromeView) {
        [UIView animateWithDuration:0 animations:^{
            
        } completion:^(BOOL finished) {
            weakSelf.animatr.isAccomplishAnima = YES;
        }];
    }];
    [self.animatr setupContainerViewWithBlock:^(UIView *containerView) {
        containerView.backgroundColor = [UIColor colorWithWhite:0 alpha:.6];
        UIButton *button = [[UIButton alloc]init];
        [containerView insertSubview:button atIndex:0];
        button.frame = containerView.bounds;
//        [button addTarget:self action:@selector(clickContainerView:) forControlEvents:UIControlEventTouchUpInside];
    }];
}

- (void)clickContainerView:(UIButton *)clickContainerView {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (UIButton *)imgButton {
    if(!_imgButton) {
        _imgButton = [[UIButton alloc] init];
        _imgButton.backgroundColor = [UIColor greenColor];
        [_imgButton addTarget:self action:@selector(clickContainerView:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return  _imgButton;
}

- (void)setupUI {
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.contentView];
    
    [self.contentView addSubview:self.imgButton];
}

- (void)addConstraints {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.imgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
