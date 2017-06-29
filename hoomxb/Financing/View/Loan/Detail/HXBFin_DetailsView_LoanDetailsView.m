//
//  HXBFin_DetailsView_LoanDetailsView.m
//  hoomxb
//
//  Created by HXB on 2017/5/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_DetailsView_LoanDetailsView.h"


@interface HXBFin_DetailsView_LoanDetailsView ()
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *countDownLabel;
@end
@implementation HXBFin_DetailsView_LoanDetailsView

- (void)setData_LoanWithLoanDetailViewModel:(HXBFinDetailViewModel_LoanDetail *)LoanDetailVieModel {
    
}

- (void)setSubView {
    self.timeLabel = [[UILabel alloc]init];
    self.countDownLabel = [[UILabel alloc]init];
    
    
    [self addSubview:self.countDownLabel];
    [self addSubview:self.timeLabel];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self);
        make.height.width.equalTo(@(kScrAdaptationH(80)));
    }];
    [self.countDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
     
    }];
}
- (void)setTimeStr:(NSString *)timeStr {
    _timeStr = timeStr;
    self.timeLabel.text = timeStr;
}
@end
