//
//  HXBMYCapitalRecord_TableViewHeaderView.m
//  hoomxb
//
//  Created by HXB on 2017/8/9.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMYCapitalRecord_TableViewHeaderView.h"
@interface HXBMYCapitalRecord_TableViewHeaderView ()
@property (nonatomic,strong) UILabel *label;
@end
@implementation HXBMYCapitalRecord_TableViewHeaderView
- (void)setTitle:(NSString *)title {
    _title = title;
    self.label.text = title;
}
- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc]init];
        [self addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(kScrAdaptationW750(30));
        }];
        _label.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
        _label.textColor = kHXBColor_HeightGrey_Font0_4;
    }
    return _label;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
