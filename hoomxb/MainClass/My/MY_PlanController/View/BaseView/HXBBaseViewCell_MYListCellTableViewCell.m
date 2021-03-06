//
//  HXBBaseViewCell_MYListCellTableViewCell.m
//  hoomxb
//
//  Created by HXB on 2017/8/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewCell_MYListCellTableViewCell.h"
@interface HXBBaseViewCell_MYListCellTableViewCell ()
///title 有可能有图片
@property (nonatomic,strong) UIImageView *title_ImageView;
@property (nonatomic,strong) UILabel *title_LeftLabel;
@property (nonatomic,strong) UILabel *title_RightLabel;

@property (nonatomic, weak) UIView *title_RightBGView;
///中间的分割线 rgb：87，87，87，1
@property (nonatomic,strong) UIView *lineview;

@property (nonatomic, strong) UIImageView *planStatusIamgeView;


@property (nonatomic,strong) HXBBaseViewCell_MYListCellTableViewCellManager *myListCellManager;

/**
 设置上下左右边距
 */
@property (nonatomic, assign) UIEdgeInsets insets;
@end
@implementation HXBBaseViewCell_MYListCellTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUP];
        _myListCellManager = [[HXBBaseViewCell_MYListCellTableViewCellManager alloc] init];
    }
    return self;
}
#pragma mark - 值传递
- (void)setUPValueWithListCellManager:(HXBBaseViewCell_MYListCellTableViewCellManager *(^)(HXBBaseViewCell_MYListCellTableViewCellManager *))managerBlock {
    self.myListCellManager = managerBlock(self.myListCellManager);
}

- (void)setMyListCellManager:(HXBBaseViewCell_MYListCellTableViewCellManager *)myListCellManager {
    _myListCellManager = myListCellManager;
    if (myListCellManager.requestType == HXBRequestType_MY_PlanRequestType_HOLD_PLAN) {
        self.insets = UIEdgeInsetsMake(kScrAdaptationH(11), kScrAdaptationW(15), kScrAdaptationH(11), kScrAdaptationW(120));
        self.planStatusIamgeView.image = [UIImage imageNamed:myListCellManager.planStatus];
        [self.planStatusIamgeView sizeToFit];
    }
    else {
        self.insets = UIEdgeInsetsMake(kScrAdaptationH(11), kScrAdaptationW(15), kScrAdaptationH(11), kScrAdaptationW(15));
    }
    
    if (myListCellManager.title_ImageName.length) {
       UIImage *image = [UIImage imageNamed:myListCellManager.title_ImageName];
        if (!image) {
            UIImageView *imageView = [[UIImageView alloc]init];            
            image = imageView.image;
        }
        self.title_ImageView.image = image;
        self.title_ImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.title_ImageView.hidden = NO;
        [self.title_LeftLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(kScrAdaptationW(35));
        }];
    }else {///没有imageView 那么跟新约束
        [self hxb_updateConstraints_imageView];
    }
    self.title_LeftLabel.text = myListCellManager.title_LeftLabelStr;
    self.title_RightLabel.text = myListCellManager.title_RightLabelStr;
    if (self.title_RightLabel.text.length) {
        self.title_RightBGView.hidden = NO;
    } else {
        self.title_RightBGView.hidden = YES;
    }
    
    [self.bottomTopBottomView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager * (HXBBaseView_MoreTopBottomViewManager *viewManager) {
        myListCellManager.bottomViewManager.leftViewArray = viewManager.leftViewArray;
        myListCellManager.bottomViewManager.rightViewArray = viewManager.rightViewArray;
        return myListCellManager.bottomViewManager;
    }];
    UILabel *label = (UILabel *) self.bottomTopBottomView.rightViewArray[1];
    label.textColor = kHXBColor_Red_090303;
    if (myListCellManager.wenHaoImageName.length) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.svgImageString = myListCellManager.wenHaoImageName;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView)];
        [imageView addGestureRecognizer:tapImage];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.bottomTopBottomView.leftViewArray.lastObject.mas_right).offset(kScrAdaptationW(4));
            make.height.width.equalTo(@(kScrAdaptationH(14)));
            make.centerY.equalTo(self.bottomTopBottomView.leftViewArray.lastObject);
        }];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    kWeakSelf
    [self.planStatusIamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.bottomTopBottomView.mas_right).offset(kScrAdaptationW(21));
        make.right.equalTo(weakSelf.contentView).offset(-kScrAdaptationW(15));
        make.bottom.equalTo(weakSelf.contentView);
    }];
    
    [self.contentView insertSubview:self.planStatusIamgeView belowSubview:self.bottomTopBottomView];
}

// 点击图片的方法
- (void)tapImageView {
    HXBXYAlertViewController *alertVC = [[HXBXYAlertViewController alloc] initWithTitle:@"温馨提示" Massage:@"待转出金额为0时，红利智投完成退出，退出期间，正常计息。" force:2 andLeftButtonMassage:@"" andRightButtonMassage:@"确定"];
    [alertVC setClickXYLeftButtonBlock:^{
        [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
    }];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - 赋值 后 更新约束
///title 没有ImageView 的时候更新约束
- (void)hxb_updateConstraints_imageView {
    self.title_ImageView.hidden = !self.myListCellManager.title_ImageName;
    CGFloat title_LeftLabel_LeftW = self.myListCellManager.title_ImageName.length? kScrAdaptationW(25) : kScrAdaptationW(15);
    if (!self.myListCellManager.title_ImageName) {
        [self.title_LeftLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(title_LeftLabel_LeftW);
        }];
    }
}


#pragma mark - UI 搭建
- (void)setUP {
    [self setUPViews];
}

- (void)setUPViews {
    ///title view的搭建
    [self setUPTitleView];
}

///MARK: title view的搭建
- (void)setUPTitleView {
    [self setUPLineView];///划线
    [self setUPTitleView_imageView];//imageView
    [self setUPTitleView_LeftTitleLabel];///title 左边
    [self setUPTitleView_RightTitleLabel];///title 右边
}

/// setUP lineView
- (void)setUPLineView {
    self.lineview = [[UIView alloc]init];
    [self.contentView addSubview:self.lineview];
    [self.lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(0.5));
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(kScrAdaptationH(44));
    }];
    self.lineview.backgroundColor = kHXBColor_Font0_5;
}

/// setUPImageView
- (void)setUPTitleView_imageView {
        self.title_ImageView = [[UIImageView alloc]init];
        [self.contentView addSubview: self.title_ImageView];
        [self.title_ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.with.equalTo(@(kScrAdaptationH(15)));
            make.left.equalTo(self.contentView).offset(kScrAdaptationW(7));
            make.centerY.equalTo(self.contentView.mas_top).offset(kScrAdaptationH(22));
        }];
}

/// setUP TitleLabel
- (UIView *)setUPTitleView_LeftTitleLabel{
    
    self.title_LeftLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.title_LeftLabel];
    self.title_LeftLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
    self.title_LeftLabel.textColor = kHXBColor_Grey_Font0_2;

    CGFloat leftW = kScrAdaptationW(35);
    [self.title_LeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(leftW);
        make.centerY.equalTo(self.title_ImageView);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.lineview.mas_top);
    }];
    return self.title_LeftLabel;
}

///set UP TitleLabel _ right
- (void)setUPTitleView_RightTitleLabel {
    self.title_RightLabel = [[UILabel alloc]init];
    UIView *view = [[UIView alloc]init];
    [self.contentView addSubview:view];
    [view addSubview:self.title_RightLabel];
    self.title_RightLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    self.title_RightLabel.textColor = kHXBColor_Blue040610;
    view.layer.borderColor = kHXBColor_Blue040610.CGColor;
    view.layer.borderWidth = kScrAdaptationH(0.8f);
    view.layer.cornerRadius = kScrAdaptationH(22 / 2.0);
    view.layer.masksToBounds = YES;
    self.title_RightBGView = view;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(kScrAdaptationW(-15));
        make.height.equalTo(@(kScrAdaptationH(22)));
        make.centerY.equalTo(self.title_LeftLabel);
        make.left.equalTo(self.title_RightLabel).offset(kScrAdaptationW(-10));
    }];
    [self.title_RightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.equalTo(view).offset(kScrAdaptationW(-10));
        make.top.bottom.equalTo(view);
        make.left.equalTo(view.mas_left).offset(kScrAdaptationW(10));
    }];
}

- (HXBBaseView_MoreTopBottomView *)bottomTopBottomView {
    if (_bottomTopBottomView == nil) {
        _bottomTopBottomView = [[HXBBaseView_MoreTopBottomView alloc]initWithFrame:CGRectZero andTopBottomViewNumber:3 andViewClass:[UILabel class] andViewHeight:kScrAdaptationH(14) andTopBottomSpace:kScrAdaptationH(16) andLeftRightLeftProportion:0 Space:self.insets andCashType:nil];
        UILabel *label = (UILabel *) _bottomTopBottomView.rightViewArray[1];
        [self.contentView addSubview:_bottomTopBottomView];
        [_bottomTopBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.lineview.mas_bottom);
            make.bottom.equalTo(self.contentView);
        }];
        label.textColor = kHXBColor_Red_090303;
    }
    return _bottomTopBottomView;
}


- (UIImageView *)planStatusIamgeView {
    if (!_planStatusIamgeView) {
        _planStatusIamgeView = [[UIImageView alloc] init];
        [self.contentView addSubview:_planStatusIamgeView];
    }
    return _planStatusIamgeView;
}

@end



@implementation HXBBaseViewCell_MYListCellTableViewCellManager
- (instancetype)init
{
    self = [super init];
    if (self) {//默认配置
        self.bottomViewManager = [[HXBBaseView_MoreTopBottomViewManager alloc]init];
        self.bottomViewManager.leftFont = kHXBFont_PINGFANGSC_REGULAR(12);
        self.bottomViewManager.rightFont = kHXBFont_PINGFANGSC_REGULAR(14);
        self.bottomViewManager.leftTextColor = kHXBColor_Font0_6;
        self.bottomViewManager.rightTextColor = kHXBColor_Grey_Font0_3;
        self.bottomViewManager.rightLabelAlignment = NSTextAlignmentRight;
        self.bottomViewManager.rightViewColor = [UIColor clearColor];
    }
    return self;
}

@end
