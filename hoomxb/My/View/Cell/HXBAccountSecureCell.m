//
//  HXBAccountSecureCell.m
//  hoomxb
//
//  Created by lxz on 2017/12/11.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBAccountSecureCell.h"

@implementation HXBAccountSecureModel
@end

@implementation HXBAccountSecureCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
        self.textLabel.textColor = COR6;
    }
    return self;
}

- (void)setModel:(HXBAccountSecureModel *)model {
    _model = model;
    self.textLabel.text = model.title;
    
    if (model.type == HXBAccountSecureTypeGesturePwdSwitch) {
        self.accessoryType = UITableViewCellAccessoryNone;
        UISwitch *switchView = [UISwitch new];
        NSString *skip = KeyChain.skipGesture;
        BOOL isOn = NO;
        if (skip != nil) {
            isOn = ![skip isEqualToString:kHXBGesturePwdSkipeYES];
        }
        switchView.on = isOn;
        [[switchView rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(__kindof UISwitch * _Nullable x) {
            model.switchBlock(x.isOn);
        }];
        self.accessoryView = switchView;
    } else {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.accessoryView = nil;
    }
    
}

@end
