//
//  HXBBaseView_HaveLable_LeftRight_View.m
//  hoomxb
//
//  Created by HXB on 2017/6/22.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseView_TwoLable_View.h"



@interface HXBBaseView_TwoLable_View ()
@property (nonatomic,strong) UILabel *leftLabel;
@property (nonatomic,strong) UILabel *rightLabel;
@property (nonatomic,assign) CGFloat proportion;
@end
@implementation HXBBaseView_TwoLable_View
- (CGFloat) proportion {
    if (!_proportion) {
        _proportion = 0.5;
    }
    return _proportion;
}
- (void) setUP_TwoViewVMFunc: (HXBBaseView_TwoLable_View_ViewModel *(^)(HXBBaseView_TwoLable_View_ViewModel *viewModelVM))setUP_ToViewViewVMBlock {
    self.ViewVM = setUP_ToViewViewVMBlock(self.ViewVM);
    if (self.ViewVM.isLeftRight) {
        [self setUP];
    }
    [self setUPViewValue];
}

- (void)setViewModelVM:(HXBBaseView_TwoLable_View_ViewModel *)ViewVM {
    _ViewVM = ViewVM;
}


- (instancetype) initWithFrame:(CGRect)frame andLeftProportion:(CGFloat)proportion {
    self = [super initWithFrame:frame];
    if (self) {
        _ViewVM = [[HXBBaseView_TwoLable_View_ViewModel alloc]init];
        self.proportion = proportion;
        [self setUP];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _ViewVM = [[HXBBaseView_TwoLable_View_ViewModel alloc]init];
        [self setUP];
    }
    return self;
}

- (void) setUP {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    self.leftLabel = [[UILabel alloc]init];
    self.rightLabel = [[UILabel alloc]init];
    [self addSubview:self.leftLabel];
    [self addSubview:self.rightLabel];
    [self setUPViewFrame];
}

- (void)setUPViewFrame {
    if (self.ViewVM.isLeftRight) {///左右结构
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self);
            make.width.equalTo(self).multipliedBy(self.proportion);
        }];
        
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self);
        }];
        
    } else { //上下结构
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.top.equalTo(self);
            make.bottom.equalTo(self.mas_centerY);
            
        }];
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.bottom.equalTo(self);
            make.top.equalTo(self.mas_centerY);
        }];
    }
    [self.leftLabel sizeToFit];
    [self.leftLabel sizeToFit];
}
- (void)setUPViewValue {
    self.leftLabel.text             =   _ViewVM.leftLabelStr;
    self.rightLabel.text            = _ViewVM.rightLabelStr;
    
    self.leftLabel.textAlignment    = _ViewVM.leftLabelAlignment;
    self.rightLabel.textAlignment   = _ViewVM.rightLabelAlignment;
    
    self.leftLabelStr               = self.ViewVM.leftLabelStr;
    self.rightLabelStr              = self.ViewVM.rightLabelStr;
    
    self.rightLabel.textColor       = self.ViewVM.rightViewColor;
    self.leftLabel.textColor        = self.ViewVM.leftViewColor;
    
    self.rightLabel.font            = self.ViewVM.rightFont;
    self.leftLabel.font             = self.ViewVM.leftFont;

}
@end

@implementation HXBBaseView_TwoLable_View_ViewModel
@end
