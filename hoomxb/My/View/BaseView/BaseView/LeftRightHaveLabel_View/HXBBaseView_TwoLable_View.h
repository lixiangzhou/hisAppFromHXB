//
//  HXBBaseView_HaveLable_LeftRight_View.h
//  hoomxb
//
//  Created by HXB on 2017/6/22.
//  Copyright © 2017年 李鹏跃. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBBaseView_TwoLable_View_ViewModel;
@interface HXBBaseView_TwoLable_View : UIView
@property (nonatomic,copy) NSString *           leftLabelStr;
@property (nonatomic,copy) NSString *           rightLabelStr;
@property (nonatomic,strong) HXBBaseView_TwoLable_View_ViewModel *ViewVM;
@property (nonatomic,strong) UILabel *leftLabel;
@property (nonatomic,strong) UILabel *rightLabel;
- (instancetype)initWithFrame:(CGRect)frame andSpacing: (CGFloat)spacing;

///赋值的viewModel
- (void) setUP_TwoViewVMFunc: (HXBBaseView_TwoLable_View_ViewModel *(^)(HXBBaseView_TwoLable_View_ViewModel *viewModelVM))setUP_ToViewViewVMBlock;

@end

@interface HXBBaseView_TwoLable_View_ViewModel : NSObject
@property (nonatomic,assign) BOOL               isLeftRight;
@property (nonatomic,copy) NSString *           leftLabelStr;
@property (nonatomic,copy) NSString *           rightLabelStr;
@property (nonatomic,assign) NSTextAlignment    leftLabelAlignment;
@property (nonatomic,assign) NSTextAlignment    rightLabelAlignment;
@property (nonatomic,strong) UIColor *          leftViewColor;
@property (nonatomic,strong) UIColor *          rightViewColor;
@property (nonatomic,strong) UIFont  *          leftFont;
@property (nonatomic,strong) UIFont  *          rightFont;
@property (nonatomic,strong) NSAttributedString * leftAttributedString;
@property (nonatomic,strong) NSAttributedString * rightAttributedString;
@end
