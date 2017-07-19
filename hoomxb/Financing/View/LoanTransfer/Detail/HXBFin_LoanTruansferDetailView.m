//
//  HXFin_LoanTruansferDetailView.m
//  hoomxb
//
//  Created by HXB on 2017/7/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_LoanTruansferDetailView.h"
#import "HXBFinDetail_TableView.h"
#import "HXBFin_LoanTruansfer_AddTrustworthinessView.h"//曾信
@interface HXBFin_LoanTruansferDetailView()
/**
 顶部的品字形
 */
@property (nonatomic,strong) HXBFin_LoanTruansferDetail_TopView *topView;
/**
 曾信
 */
@property (nonatomic,strong) HXBFin_LoanTruansfer_AddTrustworthinessView *addTrustworthiness;
/**
 还款方式
 提前还款费率
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomView *loanType_InterestLabel;
/**
 图片- 文字- 图片 的tableView
 */
@property (nonatomic,strong) HXBFinDetail_TableView *detailTableView;
/**
 * 预期收益不代表实际收益，投资需谨慎
 */
@property (nonatomic,strong) UILabel *promptLabel;
/**
 加入按钮
 */
@property (nonatomic,strong) UIButton *addButton;
/**
 点击事件
 */
@property (nonatomic,copy) void (^clickAddButtonBlock)(UIButton *button);
@property (nonatomic,copy)void (^clickBottomTabelViewCellBlock)(NSIndexPath *, HXBFinDetail_TableViewCellModel *);
@end

@implementation HXBFin_LoanTruansferDetailView
- (void)clickAddButtonBlock:(void (^)(UIButton *))clickAddButtonBlock {
    self.clickAddButtonBlock = clickAddButtonBlock;
}
- (void)setUPValueWithManager:(HXBFin_LoanTruansferDetailViewManger *(^)(HXBFin_LoanTruansferDetailViewManger *))loanTruansferDetailViewManagerBlock {
    self.manager = loanTruansferDetailViewManagerBlock(_manager);
}
- (void)setManager:(HXBFin_LoanTruansferDetailViewManger *)manager {
    _manager = manager;
    kWeakSelf
    [self.topView setUPValueWithManager:^HXBFin_LoanTruansferDetail_TopViewManager *(HXBFin_LoanTruansferDetail_TopViewManager *manager) {
        return weakSelf.manager.topViewManager;
    }];
//    self.addTrustworthiness
    [self.loanType_InterestLabel setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        return weakSelf.manager.loanType_InterestLabelManager;
    }];
    self.detailTableView.tableViewCellModelArray = self.manager.detailTableViewArray;
    self.promptLabel.text = self.manager.promptLabelStr;
    [self.addButton setTitle:self.manager.addButtonStr forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
}
///点击了债转的加入按钮
- (void)clickButton:(UIButton *)button {
    if (self.clickAddButtonBlock) {
        self.clickAddButtonBlock(button);
    }
    NSLog(@"点击了债转的加入按钮");
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _manager = [[HXBFin_LoanTruansferDetailViewManger alloc]init];
        [self setup];
        self.backgroundColor = kHXBColor_BackGround;
    }
    return self;
}

- (void)setup {
    [self creatViews];
    [self setUPFrame];
    [self setUPViews];
}
//MARK: 事件的传递
- (void)clickBottomTableViewCellBloakFunc:(void (^)(NSIndexPath *, HXBFinDetail_TableViewCellModel *))clickBottomTabelViewCellBlock {
    self.clickBottomTabelViewCellBlock = clickBottomTabelViewCellBlock;
}
/// 点击了立即加入的button
- (void) clickAddButtonFunc: (void(^)())clickAddButtonBlock {
    self.clickAddButtonBlock = clickAddButtonBlock;
}
- (void) creatViews {
    self.topView = [[HXBFin_LoanTruansferDetail_TopView alloc]init];
    self.addTrustworthiness = [[HXBFin_LoanTruansfer_AddTrustworthinessView alloc]init];
    UIEdgeInsets edgeinsets = UIEdgeInsetsMake(kScrAdaptationH(15), kScrAdaptationW(15), 0, kScrAdaptationW(15));
    self.loanType_InterestLabel = [[HXBBaseView_MoreTopBottomView alloc]initWithFrame:CGRectZero
                                                               andTopBottomViewNumber:2 andViewClass:[UILabel class] andViewHeight:kScrAdaptationH(15)
                                                                    andTopBottomSpace:kScrAdaptationH(20)
                                                           andLeftRightLeftProportion:0.5
                                                                                Space:edgeinsets];
    self.detailTableView = [[HXBFinDetail_TableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.detailTableView.rowHeight = kScrAdaptationH(45);
    self.promptLabel = [[UILabel alloc]init];
    self.addButton = [[UIButton alloc]init];
    
    [self addSubview:self.topView];
    [self addSubview:self.addTrustworthiness];
    [self addSubview:self.loanType_InterestLabel];
    [self addSubview:self.detailTableView];
    [self addSubview:self.promptLabel];
    [self addSubview:self.addButton];
    
    self.topView.backgroundColor = [UIColor whiteColor];
    self.addTrustworthiness.backgroundColor = [UIColor whiteColor];
    self.loanType_InterestLabel.backgroundColor = [UIColor whiteColor];
    self.promptLabel.textAlignment = NSTextAlignmentCenter;
//    self.promptLabel.textColor = [UIColor]
    self.detailTableView.scrollEnabled = false;
}
- (void)setUPFrame {
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self).offset(kScrAdaptationH(0));
        make.height.equalTo(@(kScrAdaptationH(248 - 64)));
    }];
    [self.addTrustworthiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(kScrAdaptationH(10));
        make.left.right.equalTo(self.topView);
        make.height.equalTo(@(kScrAdaptationH(80)));
    }];
    [self.loanType_InterestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addTrustworthiness.mas_bottom).offset(kScrAdaptationH(10));
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(80)));
    }];
    [self.detailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loanType_InterestLabel.mas_bottom).offset(kScrAdaptationH(10));
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(135)));
    }];
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailTableView.mas_bottom).offset(kScrAdaptationH(20));
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(17)));
    }];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo (@(kScrAdaptationH(49)));
        make.bottom.equalTo(self).offset(kScrAdaptationH(0));
        make.left.right.equalTo(self);
    }];
    
}
- (void)setUPViews {
    self.addButton.backgroundColor = kHXBColor_Red_090303;
    self.promptLabel.textColor = kHXBColor_Font0_6;
    self.promptLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    
    //cell的点击事件
    [self.detailTableView clickBottomTableViewCellBloakFunc:^(NSIndexPath *index, HXBFinDetail_TableViewCellModel *model) {
        if (self.clickBottomTabelViewCellBlock) {
            self.clickBottomTabelViewCellBlock(index,model);
        }
    }];

}
@end
@implementation HXBFin_LoanTruansferDetailViewManger
- (instancetype)init
{
    self = [super init];
    if (self) {
       
        /**
         顶部的品字形
         */
         self.topViewManager = [[HXBFin_LoanTruansferDetail_TopViewManager alloc]init];
        /**
         曾信
         */
         self.addTrustworthinessManager = [[HXBFin_LoanTruansfer_AddTrustworthinessView alloc]init];
        /**
         还款方式
         提前还款费率
         */
        self.loanType_InterestLabelManager = [[HXBBaseView_MoreTopBottomViewManager alloc] init];
        self.loanType_InterestLabelManager.leftFont = kHXBFont_PINGFANGSC_REGULAR(15);
        self.loanType_InterestLabelManager.rightFont = kHXBFont_PINGFANGSC_REGULAR(15);
        self.loanType_InterestLabelManager.leftTextColor = kHXBColor_Grey_Font0_2;
        self.loanType_InterestLabelManager.rightTextColor = kHXBColor_HeightGrey_Font0_4;
        self.loanType_InterestLabelManager.leftLabelAlignment = NSTextAlignmentLeft;
        self.loanType_InterestLabelManager.rightLabelAlignment = NSTextAlignmentRight;
        /**
         图片- 文字- 图片 的tableView
         */
         self.detailTableViewArray = @[];
    }
    return self;
}
@end
