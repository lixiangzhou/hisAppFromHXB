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
@property (nonatomic,strong) HXBBaseView_TwoLable_View_ViewModel *ViewVM;
@end
@implementation HXBBaseView_TwoLable_View

- (void) setUP_TwoViewVMFunc: (HXBBaseView_TwoLable_View_ViewModel *(^)(HXBBaseView_TwoLable_View_ViewModel *viewModelVM))setUP_ToViewViewVMBlock {
    self.ViewVM = setUP_ToViewViewVMBlock(self.ViewVM);
    [self setUPViewValue];
}

- (void)setViewModelVM:(HXBBaseView_TwoLable_View_ViewModel *)ViewVM {
    _ViewVM = ViewVM;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _ViewVM = [[HXBBaseView_TwoLable_View_ViewModel alloc]init];
        [self setUP];
        [self setUPViewFrame];
    }
    return self;
}

- (void) setUP {
    self.leftLabel = [[UILabel alloc]init];
    self.rightLabel = [[UILabel alloc]init];
    [self addSubview:self.leftLabel];
    [self addSubview:self.rightLabel];
}

- (void)setUPViewFrame {
    if (self.ViewVM.isLeftRight) {///左右结构
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self);
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
    self.leftLabel.text =   _ViewVM.leftLabelStr;
    self.rightLabel.text = _ViewVM.rightLabelStr;
    self.leftLabel.textAlignment = _ViewVM.leftLabelAlignment;
    self.rightLabel.textAlignment = _ViewVM.rightLabelAlignment;
}
@end

@implementation HXBBaseView_TwoLable_View_ViewModel
@end
