//
//  HXBHXBBorrowUserinforView.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/30.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBHXBBorrowUserinforView.h"
#import "HXBFinDetailViewModel_LoanDetail.h"
@interface HXBHXBBorrowUserinforView ()

@property (nonatomic, strong) UILabel *borrowUserinforTitleLabel;
@property (nonatomic, strong) UILabel *borrowUserTypeLabel;
//认证
@property (nonatomic, strong) HXBBaseView_Button *incomButton;///收入认证
@property (nonatomic, strong) UIButton *identityButton;///身份认证
@property (nonatomic, strong) UIButton *individualTrustworthinessButton;//个人信用报告
@property (nonatomic, strong) UIButton *jobButton;//工作认证

@property (nonatomic, strong) UILabel *nameTipLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *idCardNoTipLabel;
@property (nonatomic, strong) UILabel *idCardNoLabel;

@property (nonatomic, strong) UILabel *baseUserinforTitleLabel;
@property (nonatomic, strong) UILabel *ageLabel;
@property (nonatomic, strong) UILabel *nativePlaceLabel;//籍贯
@property (nonatomic, strong) UILabel *academicLabel;//学历
@property (nonatomic, strong) UILabel *marriageLabel;//婚姻


@property (nonatomic, strong) UILabel *financialLabel;//财务
@property (nonatomic, strong) UILabel *incomeLabel;//收入
@property (nonatomic, strong) UILabel *propertyLabel;//房产
@property (nonatomic, strong) UILabel *housingLoanLabel;//房贷
@property (nonatomic, strong) UILabel *carLabel;//车产
@property (nonatomic, strong) UILabel *carLoanLabel;//车贷
@property (nonatomic, strong) UILabel *workinforLabel;//工作信息
@property (nonatomic, strong) UILabel *companyLabel;//公司类别
@property (nonatomic, strong) UILabel *industryLabel;//工作行业
@property (nonatomic, strong) UILabel *positionLabel;//职位
@property (nonatomic, strong) UILabel *cityLabel;//工作城市


@end

@implementation HXBHXBBorrowUserinforView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.borrowUserinforTitleLabel];
        [self addSubview:self.borrowUserTypeLabel];
        
        //四个 图片 加 label
        [self addSubview:self.incomButton];
        
        [self addSubview:self.nameTipLabel];
        [self addSubview:self.nameLabel];
        [self addSubview:self.idCardNoTipLabel];
        [self addSubview:self.idCardNoLabel];
        
        
        [self addSubview:self.baseUserinforTitleLabel];
        [self addSubview:self.ageLabel];
        [self addSubview:self.nativePlaceLabel];
        [self addSubview:self.academicLabel];
        [self addSubview:self.marriageLabel];
        
        
        [self addSubview:self.financialLabel];
        [self addSubview:self.incomeLabel];
        [self addSubview:self.propertyLabel];
        [self addSubview:self.housingLoanLabel];
        [self addSubview:self.carLabel];
        [self addSubview:self.carLoanLabel];
        [self addSubview:self.workinforLabel];
        [self addSubview:self.companyLabel];
        [self addSubview:self.industryLabel];
        [self addSubview:self.positionLabel];
        [self addSubview:self.cityLabel];
        [self setupSubViewFrame];
    }
    return self;
}
- (void)setLoanDetailViewModel:(HXBFinDetailViewModel_LoanDetail *)loanDetailViewModel
{
    _loanDetailViewModel = loanDetailViewModel;
//    self.loanContentLabel.text = loanDetailViewModel.loanDetailModel.loanVo.description_loanVO;
    self.nameLabel.text = [loanDetailViewModel.loanDetailModel.idCardInfo.name replaceStringWithStartLocation:0 lenght:loanDetailViewModel.loanDetailModel.idCardInfo.name.length - 1];
    self.idCardNoLabel.text = [loanDetailViewModel.loanDetailModel.idCardInfo.idNo replaceStringWithStartLocation:1 lenght:loanDetailViewModel.loanDetailModel.idCardInfo.idNo.length - 2];
    self.ageLabel.text = [NSString stringWithFormat:@"年龄 %@岁",loanDetailViewModel.loanDetailModel.idCardInfo.age];
    
    self.nativePlaceLabel.text = [NSString stringWithFormat:@"籍贯 %@",loanDetailViewModel.loanDetailModel.userVo.homeTown];
    self.academicLabel.text = [NSString stringWithFormat:@"学历 %@",loanDetailViewModel.loanDetailModel.userVo.university];
    if ([loanDetailViewModel.loanDetailModel.userVo.marriageStatus isEqualToString:@"MARRIED"]) {
        
        loanDetailViewModel.loanDetailModel.userVo.marriageStatus = @"已婚";
        
    }else if ([loanDetailViewModel.loanDetailModel.userVo.marriageStatus isEqualToString:@"UNMARRIED"]){
        
        loanDetailViewModel.loanDetailModel.userVo.marriageStatus = @"未婚";
        
    }else if ([loanDetailViewModel.loanDetailModel.userVo.marriageStatus isEqualToString:@"DIVORCED"]){
        
        loanDetailViewModel.loanDetailModel.userVo.marriageStatus = @"离异";
        
    }else if ([loanDetailViewModel.loanDetailModel.userVo.marriageStatus isEqualToString:@"WIDOWED"]){
        
        loanDetailViewModel.loanDetailModel.userVo.marriageStatus = @"丧偶";
    }
    
    
    self.marriageLabel.text = [NSString stringWithFormat:@"婚姻 %@",loanDetailViewModel.loanDetailModel.userVo.marriageStatus];
    self.incomeLabel.text = [NSString stringWithFormat:@"收入（月）%@",loanDetailViewModel.loanDetailModel.userVo.monthlyIncome];
    if ([loanDetailViewModel.loanDetailModel.userVo.hasHouse isEqualToString:@"1"]) {
        self.propertyLabel.text = @"房产 有房产";
    }else
    {
        self.propertyLabel.text = @"房产 无房产";
    }
    
    if ([loanDetailViewModel.loanDetailModel.userVo.hasHouseLoan isEqualToString:@"1"]) {
        self.housingLoanLabel.text = @"房贷 有房贷";
    }else
    {
        self.housingLoanLabel.text = @"房贷 无房贷";
    }
    if ([loanDetailViewModel.loanDetailModel.userVo.hasCar isEqualToString:@"1"]) {
        
        self.carLabel.text = @"车产 有车产";
    }else
    {
         self.carLabel.text = @"车产 无车产";
    }
    if ([loanDetailViewModel.loanDetailModel.userVo.hasCarLoan isEqualToString:@"1"]) {
        
        self.carLoanLabel.text = @"车贷 有车贷";
    }else
    {
        self.carLoanLabel.text = @"车贷 无车贷";
    }
    self.companyLabel.text = [NSString stringWithFormat:@"公司类别 %@",loanDetailViewModel.loanDetailModel.userVo.companyCategory];
    self.industryLabel.text = [NSString stringWithFormat:@"工作行业 %@",loanDetailViewModel.loanDetailModel.userVo.companyIndustry];
    self.positionLabel.text = [NSString stringWithFormat:@"职位 %@",loanDetailViewModel.loanDetailModel.userVo.companyPost];
    self.cityLabel.text = [NSString stringWithFormat:@"工作城市 %@",loanDetailViewModel.loanDetailModel.userVo.companyLocation];
}
- (void)setupSubViewFrame
{
    [self.borrowUserinforTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@(kScrAdaptationH(15)));
    }];
    [self.borrowUserTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.borrowUserinforTitleLabel.mas_bottom).offset(kScrAdaptationH(15));
        make.left.equalTo(self.borrowUserinforTitleLabel);
    }];
    [self.incomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.borrowUserTypeLabel.mas_bottom).offset(kScrAdaptationH(9));
        make.left.equalTo(self.borrowUserTypeLabel);
    }];
    
    [self.nameTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.incomButton.mas_bottom).offset(kScrAdaptationH(15));
        make.left.equalTo(self.incomButton);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameTipLabel.mas_bottom).offset(8);
        make.left.equalTo(@20);
    }];
    [self.idCardNoTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(8);
        make.left.equalTo(@20);
    }];
    [self.idCardNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.idCardNoTipLabel.mas_bottom).offset(8);
        make.left.equalTo(@20);
    }];
    
    [self.baseUserinforTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.idCardNoLabel.mas_bottom).offset(8);
        make.left.equalTo(@20);
    }];
    [self.ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseUserinforTitleLabel.mas_bottom).offset(8);
        make.left.equalTo(@20);
    }];
    [self.nativePlaceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ageLabel.mas_bottom).offset(8);
        make.left.equalTo(@20);
    }];
    [self.academicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nativePlaceLabel.mas_bottom).offset(8);
        make.left.equalTo(@20);
    }];
    [self.marriageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.academicLabel.mas_bottom).offset(8);
        make.left.equalTo(@20);
    }];
    [self.financialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.marriageLabel.mas_bottom).offset(8);
        make.left.equalTo(@20);
    }];
    [self.incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.financialLabel.mas_bottom).offset(8);
        make.left.equalTo(@20);
    }];
    [self.propertyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.incomeLabel.mas_bottom).offset(8);
        make.left.equalTo(@20);
    }];
    [self.housingLoanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.propertyLabel.mas_bottom).offset(8);
        make.left.equalTo(@20);
    }];
    [self.carLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.housingLoanLabel.mas_bottom).offset(8);
        make.left.equalTo(@20);
    }];
    [self.carLoanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.carLabel.mas_bottom).offset(8);
        make.left.equalTo(@20);
    }];
    [self.workinforLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.carLoanLabel.mas_bottom).offset(8);
        make.left.equalTo(@20);
    }];
    [self.companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.workinforLabel.mas_bottom).offset(8);
        make.left.equalTo(@20);
    }];
    [self.industryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.companyLabel.mas_bottom).offset(8);
        make.left.equalTo(@20);
    }];
    [self.positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.industryLabel.mas_bottom).offset(8);
        make.left.equalTo(@20);
    }];
    [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.positionLabel.mas_bottom).offset(8);
        make.left.equalTo(@20);
    }];
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.height = self.cityLabel.bottom + 10;
}

- (UILabel *)borrowUserinforTitleLabel
{
    if (!_borrowUserinforTitleLabel) {
        _borrowUserinforTitleLabel = [[UILabel alloc] init];
        _borrowUserinforTitleLabel.font = [UIFont systemFontOfSize:15];
        _borrowUserinforTitleLabel.textColor = COR11;
        _borrowUserinforTitleLabel.text = @"借款人信息";
    }
    return _borrowUserinforTitleLabel;
}
- (UILabel *)borrowUserTypeLabel {
    if (!_borrowUserTypeLabel) {
        _borrowUserTypeLabel = [[UILabel alloc] init];
        _borrowUserTypeLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        _borrowUserTypeLabel.textColor = kHXBColor_HeightGrey_Font0_4;
        _borrowUserTypeLabel.text = @"借款人审核状态";
    }
    return _borrowUserTypeLabel;
}
///收入认证
- (HXBBaseView_Button *) incomButton {
    if (!_incomButton) {
        _incomButton = [[HXBBaseView_Button alloc]init];
        [_incomButton setTitle:@"收入认证" forState: UIControlStateNormal];
        [_incomButton setImage:[UIImage imageNamed:@"duigou"] forState:UIControlStateNormal];
        
        
//        _incomButton.imageView.layer.borderColor = kHXBColor_Blue040610.CGColor;
//        _incomButton.imageView.layer.borderWidth = kScrAdaptationH(1);
//        _incomButton.imageView.layer.masksToBounds = true;
//        _incomButton.imageView.layer.cornerRadius = kScrAdaptationH(5);
        _incomButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        
        [_incomButton setTitleColor:kHXBColor_HeightGrey_Font0_4 forState:UIControlStateNormal];
        
    }
    return _incomButton;
}

///身份认证
- (UIButton *)identityButton {
    if (!_identityButton) {
        _identityButton = [[UIButton alloc]init];
        [_identityButton setTitle:@"收入认证" forState: UIControlStateNormal];
        _identityButton.imageView.image = [UIImage imageNamed:@"duigou"];
        _identityButton.imageView.layer.borderColor = kHXBColor_Blue040610.CGColor;
        _identityButton.imageView.layer.borderWidth = kXYBorderWidth;
        _identityButton.imageView.layer.masksToBounds = true;
        _identityButton.imageView.layer.cornerRadius = kScrAdaptationH(10);
        _identityButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        [_identityButton setTitleColor:kHXBColor_HeightGrey_Font0_4 forState:UIControlStateNormal];
        
    }
    return _incomButton;
}

//个人信用报告
- (UIButton *)individualTrustworthinessButton {
    if (!_individualTrustworthinessButton) {
        _individualTrustworthinessButton = [[UIButton alloc]init];
        [_individualTrustworthinessButton setTitle:@"收入认证" forState: UIControlStateNormal];
        _individualTrustworthinessButton.imageView.image = [UIImage imageNamed:@"duigou"];
        _individualTrustworthinessButton.imageView.layer.borderColor = kHXBColor_Blue040610.CGColor;
        _individualTrustworthinessButton.imageView.layer.borderWidth = kXYBorderWidth;
        _individualTrustworthinessButton.imageView.layer.masksToBounds = true;
        _individualTrustworthinessButton.imageView.layer.cornerRadius = kScrAdaptationH(10);
        _individualTrustworthinessButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        [_individualTrustworthinessButton setTitleColor:kHXBColor_HeightGrey_Font0_4 forState:UIControlStateNormal];
    }
    return _individualTrustworthinessButton;
}
//工作认证
- (UIButton *)jobButton{
    if (!_jobButton) {
        _jobButton = [[UIButton alloc]init];
        [_jobButton setTitle:@"收入认证" forState: UIControlStateNormal];
        _jobButton.imageView.image = [UIImage imageNamed:@"duigou"];
        _jobButton.imageView.layer.borderColor = kHXBColor_Blue040610.CGColor;
        _jobButton.imageView.layer.borderWidth = kXYBorderWidth;
        _jobButton.imageView.layer.masksToBounds = true;
        _jobButton.imageView.layer.cornerRadius = kScrAdaptationH(10);
        _jobButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        [_jobButton setTitleColor:kHXBColor_HeightGrey_Font0_4 forState:UIControlStateNormal];
    }
    return _jobButton;
}
- (UILabel *)nameTipLabel
{
    if (!_nameTipLabel) {
        _nameTipLabel = [[UILabel alloc] init];
        _nameTipLabel.font = [UIFont systemFontOfSize:15];
        _nameTipLabel.textColor = COR11;
        _nameTipLabel.text = @"姓名";
    }
    return _nameTipLabel;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = COR11;
    }
    return _nameLabel;
}
- (UILabel *)idCardNoTipLabel
{
    if (!_idCardNoTipLabel) {
        _idCardNoTipLabel = [[UILabel alloc] init];
        _idCardNoTipLabel.font = [UIFont systemFontOfSize:15];
        _idCardNoTipLabel.textColor = COR11;
        _idCardNoTipLabel.text = @"身份证号";
    }
    return _idCardNoTipLabel;
}
- (UILabel *)idCardNoLabel
{
    if (!_idCardNoLabel) {
        _idCardNoLabel = [[UILabel alloc] init];
        _idCardNoLabel.font = [UIFont systemFontOfSize:15];
        _idCardNoLabel.textColor = COR11;
    }
    return _idCardNoLabel;
}
- (UILabel *)baseUserinforTitleLabel
{
    if (!_baseUserinforTitleLabel) {
        _baseUserinforTitleLabel = [[UILabel alloc] init];
        _baseUserinforTitleLabel.font = [UIFont systemFontOfSize:15];
        _baseUserinforTitleLabel.textColor = COR11;
        _baseUserinforTitleLabel.text = @"基本信息";
    }
    return _baseUserinforTitleLabel;
}


- (UILabel *)ageLabel
{
    if (!_ageLabel) {
        _ageLabel = [[UILabel alloc] init];
        _ageLabel.font = [UIFont systemFontOfSize:15];
        _ageLabel.textColor = COR11;
        _ageLabel.text = @"年龄 27岁";
    }
    return _ageLabel;
}
- (UILabel *)nativePlaceLabel
{
    if (!_nativePlaceLabel) {
        _nativePlaceLabel = [[UILabel alloc] init];
        _nativePlaceLabel.font = [UIFont systemFontOfSize:15];
        _nativePlaceLabel.textColor = COR11;
        _nativePlaceLabel.text = @"籍贯";
    }
    return _nativePlaceLabel;
}
- (UILabel *)academicLabel
{
    if (!_academicLabel) {
        _academicLabel = [[UILabel alloc] init];
        _academicLabel.font = [UIFont systemFontOfSize:15];
        _academicLabel.textColor = COR11;
        _academicLabel.text = @"学历";
    }
    return _academicLabel;
}
- (UILabel *)marriageLabel
{
    if (!_marriageLabel) {
        _marriageLabel = [[UILabel alloc] init];
        _marriageLabel.font = [UIFont systemFontOfSize:15];
        _marriageLabel.textColor = COR11;
        _marriageLabel.text = @"婚姻";
    }
    return _marriageLabel;
}
- (UILabel *)financialLabel
{
    if (!_financialLabel) {
        _financialLabel = [[UILabel alloc] init];
        _financialLabel.font = [UIFont systemFontOfSize:15];
        _financialLabel.textColor = COR11;
        _financialLabel.text = @"财务信息";
    }
    return _financialLabel;
}
- (UILabel *)incomeLabel
{
    if (!_incomeLabel) {
        _incomeLabel = [[UILabel alloc] init];
        _incomeLabel.font = [UIFont systemFontOfSize:15];
        _incomeLabel.textColor = COR11;
        _incomeLabel.text = @"收入";
    }
    return _incomeLabel;
}
- (UILabel *)propertyLabel
{
    if (!_propertyLabel) {
        _propertyLabel = [[UILabel alloc] init];
        _propertyLabel.font = [UIFont systemFontOfSize:15];
        _propertyLabel.textColor = COR11;
        _propertyLabel.text = @"房产";
    }
    return _propertyLabel;
}
- (UILabel *)housingLoanLabel
{
    if (!_housingLoanLabel) {
        _housingLoanLabel = [[UILabel alloc] init];
        _housingLoanLabel.font = [UIFont systemFontOfSize:15];
        _housingLoanLabel.textColor = COR11;
        _housingLoanLabel.text = @"房贷";
    }
    return _housingLoanLabel;
}
- (UILabel *)carLabel
{
    if (!_carLabel) {
        _carLabel = [[UILabel alloc] init];
        _carLabel.font = [UIFont systemFontOfSize:15];
        _carLabel.textColor = COR11;
        _carLabel.text = @"车产";
    }
    return _carLabel;
}
- (UILabel *)carLoanLabel
{
    if (!_carLoanLabel) {
        _carLoanLabel = [[UILabel alloc] init];
        _carLoanLabel.font = [UIFont systemFontOfSize:15];
        _carLoanLabel.textColor = COR11;
        _carLoanLabel.text = @"车贷";
    }
    return _carLoanLabel;
}
- (UILabel *)workinforLabel
{
    if (!_workinforLabel) {
        _workinforLabel = [[UILabel alloc] init];
        _workinforLabel.font = [UIFont systemFontOfSize:15];
        _workinforLabel.textColor = COR11;
        _workinforLabel.text = @"工作信息";
    }
    return _workinforLabel;
}
- (UILabel *)companyLabel
{
    if (!_companyLabel) {
        _companyLabel = [[UILabel alloc] init];
        _companyLabel.font = [UIFont systemFontOfSize:15];
        _companyLabel.textColor = COR11;
        _companyLabel.text = @"公司类型";
    }
    return _companyLabel;
}
- (UILabel *)industryLabel
{
    if (!_industryLabel) {
        _industryLabel = [[UILabel alloc] init];
        _industryLabel.font = [UIFont systemFontOfSize:15];
        _industryLabel.textColor = COR11;
        _industryLabel.text = @"工作行业";
    }
    return _industryLabel;
}
- (UILabel *)positionLabel
{
    if (!_positionLabel) {
        _positionLabel = [[UILabel alloc] init];
        _positionLabel.font = [UIFont systemFontOfSize:15];
        _positionLabel.textColor = COR11;
        _positionLabel.text = @"职位";
    }
    return _positionLabel;
}
- (UILabel *)cityLabel
{
    if (!_cityLabel) {
        _cityLabel = [[UILabel alloc] init];
        _cityLabel.font = [UIFont systemFontOfSize:15];
        _cityLabel.textColor = COR11;
        _cityLabel.text = @"工作城市";
    }
    return _cityLabel;
}

@end
