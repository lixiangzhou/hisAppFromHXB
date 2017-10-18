//
//  HXBFinanctingDetail_progressCell.m
//  hoomxb
//
//  Created by HXB on 2017/8/23.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinanctingDetail_progressCell.h"
#import "HXBFinBase_FlowChartView.h"

@interface HXBFinanctingDetail_progressCell ()



@end


@implementation HXBFinanctingDetail_progressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupFlowChartView];
    }
    return self;
}

//MARK: - 引导视图
- (void)setupFlowChartView {
    self.flowChartView = [[HXBFinBase_FlowChartView alloc]init];
    self.flowChartView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.flowChartView];
    [self.flowChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(0);
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(108)));
    }];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
