//
//  HXBMyCouponExchangeViewController.m
//  hoomxb
//
//  Created by hxb on 2017/10/30.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyCouponExchangeViewController.h"
#import "HXBRequestAccountInfo.h"
#import "HXBFBase_BuyResult_VC.h"
#import "HXBMyCouponListViewController.h"
#import "HXBMyCouponListModel.h"
#import "HXBMyCouponViewController.h"

@interface HXBMyCouponExchangeViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)UIView *bgView;
@property (nonatomic, strong)UILabel *redeemCodeLab;
@property (nonatomic, strong)HXBCustomTextField *redeemCodeTextField;
@property (nonatomic, strong)UILabel *promptLab;
@property (nonatomic, strong)UIButton *redeemCodeBtn;
@property (nonatomic, strong)HXBMyCouponListModel *myCouponListModel;
@end

@implementation HXBMyCouponExchangeViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBA(244, 243, 248, 1);
    
    [self buildUI];
    [self setupSubViewFrame];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark - UI

- (void)buildUI{
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.promptLab];
    self.promptLab.hidden = YES;
    [self.view addSubview:self.redeemCodeBtn];
}

- (void)setupSubViewFrame{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kScrAdaptationH750(40));
        make.height.equalTo(@kScrAdaptationH750(120));
        make.left.width.equalTo(self.view);
    }];
    
    [self.redeemCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView);
        make.height.equalTo(@kScrAdaptationH750(32));
        make.left.equalTo(self.view).offset(kScrAdaptationW750(70));
        make.right.equalTo(self.bgView.mas_right);
    }];
    
    [self.redeemCodeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(kScrAdaptationH750(44));
        make.height.equalTo(@kScrAdaptationH750(30));
        make.left.equalTo(self.view).offset(kScrAdaptationW750(44));
        make.width.equalTo(@kScrAdaptationW750(96));
    }];
    
    [self.redeemCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kScrAdaptationH750(326));
        make.height.equalTo(@kScrAdaptationH750(90));
        make.left.equalTo(@kScrAdaptationW750(40));
        make.width.equalTo(@kScrAdaptationW750(670));
    }];
}

#pragma mark - Network

- (void)loadData_myAccountExchangeInfo{
    kWeakSelf
    [HXBRequestAccountInfo downLoadMyCouponExchangeInfoNoHUDWithCode: [weakSelf.redeemCodeTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""] withSeccessBlock:^(HXBMyCouponListModel *Model, NSString *message) {
        if (message.length > 0) {
            self.promptLab.hidden = NO;
            self.promptLab.text = message;
        } else {
            self.myCouponListModel = Model;
            HXBFBase_BuyResult_VC *planBuySuccessVC = [[HXBFBase_BuyResult_VC alloc]init];
            planBuySuccessVC.imageName = @"SuccessfulCoupon";
            planBuySuccessVC.buy_title = @"兑换成功";
            planBuySuccessVC.midStr = [NSString stringWithFormat:@"您已成功兑换\n%@", Model.summaryContent];
            planBuySuccessVC.buy_ButtonTitle = @"查看我的优惠券";
            planBuySuccessVC.title = @"兑换优惠券";
            [planBuySuccessVC clickButtonWithBlock:^{
                __block HXBMyCouponViewController *viewController = nil;
                [self.navigationController.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull VC, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([VC isKindOfClass:[HXBMyCouponViewController class]]) {
                        viewController = VC;
                        * stop = true;
                    }
                }];
                if ((HXBMyCouponViewController * )viewController.childViewControllers[0] && [(HXBMyCouponViewController * )viewController.childViewControllers[0] isKindOfClass:[HXBMyCouponListViewController class]]) {
                    
                    UIButton *btn = viewController.topTabView.tabs[0];
                    [viewController.topTabView tabAnimation:btn];
                    [viewController.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
                    [self.navigationController popToViewController:viewController animated:true];
                }
            }];
            self.redeemCodeTextField.text = @"";
            [self.navigationController pushViewController:planBuySuccessVC animated:true];
        }
    } andFailure:^(NSError *error) {
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    self.promptLab.text = @"";
    self.promptLab.hidden = YES;
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.promptLab.text = @"";
    self.promptLab.hidden = YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.superview == _redeemCodeTextField) {
        if ([string isEqualToString:@" "]) {
            return NO;
        }
        return [UITextField numberFormatTextField:textField shouldChangeCharactersInRange:range replacementString:string textFieldType:kRedeemCodeTextFieldType];
    }
    return YES;
}

#pragma mark - Action

- (void)clickRedeemCodeBtn:(UIButton *)sender{
    [self.view endEditing:YES];
    if ([self.redeemCodeTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""].length > 0) {
        [self loadData_myAccountExchangeInfo];
    }
}

#pragma mark - Setter / Getter / Lazy

-(void)setMyCouponListModel:(HXBMyCouponListModel *)myCouponListModel{
    _myCouponListModel = myCouponListModel;
}

-(UILabel *)promptLab{
    if (!_promptLab) {
        _promptLab = [[UILabel alloc]initWithFrame:CGRectMake(kScrAdaptationW750(30), kScrAdaptationH750(180), kScreenWidth - kScrAdaptationW750(60), kScrAdaptationH750(28))];
        _promptLab.text = @"";
        _promptLab.textAlignment = NSTextAlignmentCenter;
        _promptLab.textColor = RGBA(253, 54, 54, 1);
        _promptLab.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
    }
    return _promptLab;
}

- (UIButton *)redeemCodeBtn{
    if (!_redeemCodeBtn) {
        _redeemCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _redeemCodeBtn.frame = CGRectMake(kScrAdaptationW750(40), kScrAdaptationH750(326), kScrAdaptationW750(670), kScrAdaptationH750(90));
        _redeemCodeBtn.backgroundColor = COR12;
        _redeemCodeBtn.userInteractionEnabled = NO;
        [_redeemCodeBtn setTitle:@"兑换" forState:UIControlStateNormal];
        [_redeemCodeBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        _redeemCodeBtn.layer.cornerRadius = 3;
        _redeemCodeBtn.layer.masksToBounds = YES;
        _redeemCodeBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(32);
        [_redeemCodeBtn addTarget:self action:@selector(clickRedeemCodeBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _redeemCodeBtn;
}

- (HXBCustomTextField *)redeemCodeTextField{
    if (!_redeemCodeTextField) {
        _redeemCodeTextField = [[HXBCustomTextField alloc] initWithFrame:CGRectZero];
        _redeemCodeTextField.placeholder = @"请输入兑换码";
        _redeemCodeTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _redeemCodeTextField.delegate = self;
        _redeemCodeTextField.limitStringLength = 19;
        _redeemCodeTextField.isHidenLine = YES;
        kWeakSelf
        _redeemCodeTextField.block = ^(NSString *text) {
            weakSelf.redeemCodeTextField.text = [text uppercaseString];
            if (text.length) {
                weakSelf.redeemCodeBtn.userInteractionEnabled = YES;
                weakSelf.redeemCodeBtn.backgroundColor = COR29;
            } else {
                weakSelf.redeemCodeBtn.userInteractionEnabled = NO;
                weakSelf.redeemCodeBtn.backgroundColor = COR12;
            }
            if (text.length > 19) {
                weakSelf.redeemCodeTextField.disableEdit = YES;
            }
        };
    }
    return _redeemCodeTextField;
}

- (UILabel *)redeemCodeLab{
    if (!_redeemCodeLab) {
        _redeemCodeLab = [[UILabel alloc]initWithFrame:CGRectMake(kScrAdaptationW750(30), kScrAdaptationH750(44), kScrAdaptationW750(96), kScrAdaptationH750(32))];
        _redeemCodeLab.text = @"兑换码";
        _redeemCodeLab.textAlignment = NSTextAlignmentCenter;
        _redeemCodeLab.textColor = RGBA(51, 51, 51, 1);
        _redeemCodeLab.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
    }
    return _redeemCodeLab;
}


//- (HXBCustomTextField *)redeemCodeTextField{
//    if (!_redeemCodeTextField) {
//        _redeemCodeTextField = [[HXBCustomTextField alloc]initWithFrame:CGRectMake(kScrAdaptationW750(146), kScrAdaptationH750(44), kScrAdaptationW750(750-146), kScrAdaptationH750(32))];
//        _redeemCodeTextField.placeholder = @"请输入兑换码";
//        _redeemCodeTextField.delegate = self;
//        _redeemCodeTextField.textColor = RGBA(51, 51, 51, 1);
//        _redeemCodeTextField.keyboardType = UIKeyboardTypeASCIICapable;
////        _redeemCodeTextField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
//    }
//    return _redeemCodeTextField;
//}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(kScrAdaptationW750(0), kScrAdaptationH750(40), SCREEN_WIDTH, kScrAdaptationH750(120))];
        _bgView.backgroundColor = [UIColor whiteColor];
        [_bgView addSubview:self.redeemCodeTextField];
        [_bgView addSubview:self.redeemCodeLab];
    }
    return _bgView;
}

#pragma mark - Other

//- (BOOL)isPureInt:(NSString *)string{
//    NSScanner* scan = [NSScanner scannerWithString:string];
//    int val;
//    return [scan scanInt:&val] && [scan isAtEnd];
//
//}

/**
 *  Description 0-9 A-Z a-z
 *  @param string 匹配输入的字符串
 */
- (BOOL)judgeTextFieldInputString:(NSString *)string{
    if (!string||[string isEqualToString:@""]) {
        return NO;
    }
    //    for (int i = 0; i < string.length; i++) { //避免修正时不扫描
    //        NSString *subString = [string substringWithRange:NSMakeRange(i, 1)];
    //        if ([subString isEqualToString:@" "]) {
    //            continue;
    //        }
    //        int ascii = [subString characterAtIndex:0];
    //        if (![self judgeTextFieldInputCStringASCII:ascii]) {
    //            return NO;
    //            break;
    //        }
    //    }
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    return YES;
}

- (BOOL)judgeTextFieldInputCStringASCII:(int)ascii{
    
    int ascii_a = [@"a" characterAtIndex:0];//转ASCII码
    int ascii_z = [@"z" characterAtIndex:0];
    
    int ascii_A = [@"A" characterAtIndex:0];
    int ascii_Z = [@"Z" characterAtIndex:0];
    
    int ascii_0 = [@"0" characterAtIndex:0];
    int ascii_9 = [@"9" characterAtIndex:0];
    
    //    int ascii = [string characterAtIndex:0];
    if( ascii >= ascii_A && ascii <= ascii_Z){
        return YES;
    }else if( ascii >= ascii_a && ascii <= ascii_z){
        return YES;
    }else if( ascii >= ascii_0 && ascii <= ascii_9){
        return YES;
    }
    return NO;
}

@end
