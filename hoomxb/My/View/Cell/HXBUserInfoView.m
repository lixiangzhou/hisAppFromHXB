//
//  HXBUserInfoView.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBUserInfoView.h"

@interface HXBUserInfoView ()


@property (nonatomic, strong) HXBBaseView_MoreTopBottomView *moreTopBottomView;
@end

@implementation HXBUserInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)setupSubViewFrame
{
    [self.moreTopBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
}

- (void)setLeftStrArr:(NSArray *)leftStrArr
{
    _leftStrArr = leftStrArr;
    [self addSubview:self.moreTopBottomView];
    [self setupSubViewFrame];
    [self.moreTopBottomView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        viewManager.leftStrArray = leftStrArr;
        return viewManager;
    }];
    
}

- (void)setRightArr:(NSArray *)rightArr
{
    _rightArr = rightArr;
    
    [self.moreTopBottomView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        viewManager.rightStrArray = rightArr;
        return viewManager;
    }];
    UILabel *label = (UILabel *)[self.moreTopBottomView.rightViewArray lastObject];
    if ([label.text isEqualToString:@"《恒丰银行股份有限公司杭州分行网络交易资金账户三方协议》"]) {
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(agreementClick)];
        [label addGestureRecognizer:labelTapGestureRecognizer];
        label.userInteractionEnabled = YES;
    }
    
}

- (void)agreementClick
{
    if (self.agreementBlock) {
        self.agreementBlock();
    }
}

#pragma mark - 懒加载
- (HXBBaseView_MoreTopBottomView *)moreTopBottomView
{
    if (!_moreTopBottomView) {
        _moreTopBottomView = [[HXBBaseView_MoreTopBottomView alloc] initWithFrame:self.bounds andTopBottomViewNumber:self.leftStrArr.count andViewClass:[UILabel class] andViewHeight:12 andTopBottomSpace:18 andLeftRightLeftProportion:0 Space:UIEdgeInsetsMake(10, 10, 10, 20)];
        [_moreTopBottomView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
            viewManager.rightLabelAlignment = NSTextAlignmentRight;
            return viewManager;
        }];
    }
    return _moreTopBottomView;
}


@end
