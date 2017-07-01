//
//  HXBFeedbackViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/28.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFeedbackViewController.h"
#import "UITextView+YLTextView.h"
@interface HXBFeedbackViewController ()

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UIButton *submitBtn;
@end

@implementation HXBFeedbackViewController

- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc] init];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.backgroundColor = [UIColor blueColor];
        [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 32, 200)];
        //    textView.text = @"请写在自定义属性前面，如果长度大于limitLength设置长度会被自动截断。";
        _textView.placeholder = @"您的声音，我们用心聆听~";
        _textView.limitLength = @240;
        _textView.layer.borderWidth = 0.5;
        _textView.layer.borderColor = COR12.CGColor;
    }
    return _textView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.submitBtn];
    self.title = @"意见反馈";
    [self setupSubViewFrame];
}

- (void)setupSubViewFrame
{
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.top.equalTo(@84);
        make.height.equalTo(@200);
    }];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.top.equalTo(self.textView.mas_bottom).offset(50);
    }];
}

- (void)submitBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
