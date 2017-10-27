//
//  HXBBottomLineTableViewCell.m
//  hoomxb
//
//  Created by HXB-C on 2017/8/29.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBottomLineTableViewCell.h"

@interface HXBBottomLineTableViewCell ()

@property (nonatomic, strong) UIView *line;

@end

@implementation HXBBottomLineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.line = [[UIView alloc] init];
        self.line.backgroundColor = COR12;
        [self addSubview:self.line];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.offset(kHXPartingLineHeight);
        }];
        
    }
    return self;
}

- (void)setHiddenLine:(BOOL)hiddenLine
{
    _hiddenLine = hiddenLine;
    self.line.hidden = hiddenLine;
}


@end
