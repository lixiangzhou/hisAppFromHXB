//
//  KeyChainManage.m
//  HongXiaoBao
//
//  Created by 牛严 on 16/6/16.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import "KeyChainManage.h"

#import <UICKeyChainStore.h>
#import <Security/Security.h>
#import "HXBRequestUserInfoAgent.h"
#import "HXBAccountActivationManager.h"

#define kGesturePwd self.keychain[kMobile]
#define kSiginPwd @"HXBSinInCount"
// 是否忽略手势密码
#define kHXBGesturePwdSkipeKey [NSString stringWithFormat:@"kHXBGesturePwdSkipeKey%@", KeyChain.mobile ?: @""]
// 是否出现过忽略手势密码弹窗
#define kHXBGesturePwdSkipeAppeardKey [NSString stringWithFormat:@"kHXBGesturePwdSkipeAppeardKey%@", KeyChain.mobile ?: @""]

static NSString * const kService = @"www.hoomxb.com";
//注册时返回的信息
static NSString * const kToken = @"token";
static NSString * const kPhone = @"phone";
static NSString * const kUserId = @"userId";
static NSString * const kInviteCode = @"inviteCode";

static NSString * const kLoginPwd = @"loginPwd";
static NSString * const kTradePwd = @"tradePwd";
//static NSString * const kGesturePwd = @"gesturePwd";
static NSString * const kGesturePwdCount = @"gesturePwdCount";

static NSString * const kRealName = @"realName";
static NSString * const kRealId = @"realId";
static NSString * const kDefBankNum = @"defBankNum";

static NSString * const kBankNumArr = @"bankNumArr";
static NSString * const kAvatarImageURL = @"avatarImageURL";
static NSString * const kLocalAvatarImageData = @"kLocalAvatarImageData";

//统一密文处理
static NSString * const kCiphertext = @"ciphertext";

///错误
static NSString * const kNo = @"0";
///是否实名认证
static NSString *const kIsAllPassed = @"kIsAllPassed";
///是否绑卡
static NSString *const kIsBindCard = @"kIsBindCard";
///是否实名
static NSString *const kIsIdPassed = @"kIsIdPassed";
///是否 手机号
static NSString *const kIsMobilePassed = @"kIsMobilePassed";
///手机号
static NSString *const kMobile = @"kMobile";
///用户名
static NSString *const kUserName = @"kUserName";
///    double    总资产
static NSString *const kAssetsTotal = @"kAssetsTotal";
///    double    累计收益
static NSString *const kEarnTotal = @"kEarnTotal";
///    double    红利计划-持有资产
static NSString *const kFinancePlanAssets = @"kFinancePlanAssets";
///    double    红利计划-累计收益
static NSString *const kFinancePlanSumPlanInterest = @"kFinancePlanSumPlanInterest";
///    double    散标债权-持有资产
static NSString *const kLenderPrincipal = @"kLenderPrincipal";
///    double    散标债权-累计收益
static NSString *const kLenderEarned = @"kLenderEarned";
///    double    可用余额
static NSString *const kAvailablePoint = @"kAvailablePoint";
///    double    冻结余额
static NSString *const kFrozenPoint = @"kFrozenPoint";
/// 是否登录
static NSString *const kIsLogin = @"kIsLogin";
///isEscrow    int    是否开通存管账户 1：已开通， 0：未开通
static NSString *const kISEscrow = @"kISEscrow";
//H5页面的BaseURL
static NSString *const hostH5 = @"hostH5";

@interface KeyChainManage ()

@property (nonatomic, strong) UICKeyChainStore *keychain;

///    double    总资产
@property (nonatomic,copy) NSString *assetsTotal;
///    double    累计收益
@property (nonatomic,copy) NSString *earnTotal;
///    double    红利计划-持有资产
@property (nonatomic,copy) NSString *financePlanAssets;
///    double    红利计划-累计收益
@property (nonatomic,copy) NSString *financePlanSumPlanInterest;
///    double    散标债权-持有资产
@property (nonatomic,copy) NSString *lenderPrincipal;
///    double    散标债权-累计收益
@property (nonatomic,copy) NSString *lenderEarned;
///    double    可用余额
@property (nonatomic,copy) NSString *availablePoint;
///    double    冻结余额
@property (nonatomic,copy) NSString *frozenPoint;


///    是否安全认证
@property (nonatomic,copy) NSString *isVerify;
///是否绑卡
@property (nonatomic,copy) NSString *isBindCard;

///isIdPassed    String    是否实名
@property (nonatomic,copy) NSString *isIdPassed;
///是否手机号
@property (nonatomic,copy) NSString *isMobilePassed;

///用户id
@property (nonatomic,copy) NSString *userId;
///username    String    用户名称
@property (nonatomic,copy) NSString *userName;
///真实姓名
@property (nonatomic,copy) NSString *realName;
///idNo
@property (nonatomic,copy) NSString *idNo;
///是否开通存管账户
@property (nonatomic,copy) NSString *isEscrow;

@end

@implementation KeyChainManage
@synthesize mobile = _mobile;

+ (instancetype)sharedInstance
{
    static KeyChainManage *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.keychain = [UICKeyChainStore keyChainStoreWithService:kService];
    });
    
    return sharedInstance;
}

#pragma mark - 常用方法

- (void)setValueWithUserInfoModel: (HXBRequestUserInfoViewModel *)userInfoViewModel {
    
    //是否实名
    _isVerify = userInfoViewModel.userInfoModel.userInfo.isAllPassed;
    _keychain[kIsAllPassed] = _isVerify;
    
    //是否绑卡 已绑卡， 0：未绑卡
    _isBindCard = userInfoViewModel.userInfoModel.userInfo.hasBindCard;
    _keychain[kIsBindCard] = _isBindCard;
    
    ///isIdPassed    String    是否实名
    _isIdPassed = userInfoViewModel.userInfoModel.userInfo.isIdPassed;
    _keychain[kIsIdPassed] = _isIdPassed;
    
    
    ///isMobilePassed    String    是否手机号
    _isMobilePassed = userInfoViewModel.userInfoModel.userInfo.isMobilePassed;
    _keychain[kIsMobilePassed] = _isMobilePassed;
    
    ///isEscrow 是否开通存管
    _isEscrow = userInfoViewModel.userInfoModel.userInfo.isEscrow;
    _keychain[kISEscrow] = _isEscrow;
    
    ///用户手机号
    _mobile = userInfoViewModel.userInfoModel.userInfo.mobile;
    _keychain[kMobile] = _mobile;
    
    
    /// 用户名
    _userName = userInfoViewModel.userInfoModel.userInfo.username;
    _keychain[kUserName] = _userName;
    
    
    ///用户id
    _userId = userInfoViewModel.userInfoModel.userInfo.userId;
    _keychain[kUserId] = _userId;
    
    ///    double    总资产
    _assetsTotal = userInfoViewModel.userInfoModel.userAssets.assetsTotal;
    ///    double    累计收益
    _earnTotal = userInfoViewModel.userInfoModel.userAssets.earnTotal;
    ///    double    红利计划-持有资产
    _financePlanAssets = userInfoViewModel.userInfoModel.userAssets.financePlanAssets;
    ///    double    红利计划-累计收益
    _financePlanSumPlanInterest = userInfoViewModel.userInfoModel.userAssets.financePlanSumPlanInterest;
    ///    double    散标债权-持有资产
    _lenderPrincipal = userInfoViewModel.userInfoModel.userAssets.lenderPrincipal;
    ///    double    散标债权-累计收益
    _lenderEarned = userInfoViewModel.userInfoModel.userAssets.lenderEarned;
    ///    double    可用余额
    _availablePoint = userInfoViewModel.userInfoModel.userAssets.availablePoint;
    ///    double    冻结余额
    _frozenPoint = userInfoViewModel.userInfoModel.userAssets.frozenPoint;
    /// 是否是新手
    _isNewbie = userInfoViewModel.userInfoModel.userInfo.isNewbie;
}

/**
 新增请求用户信息

 @param requestBlock 请求回调， 补充request的参数
 @param resultBlock 结果回调
 */
- (void)downLoadUserInfoWithRequestBlock:(void(^)(NYBaseRequest* request)) requestBlock resultBlock:(void(^)(HXBRequestUserInfoViewModel *viewModel, NSError *error))resultBlock{
    [HXBRequestUserInfoAgent downLoadUserInfoWithRequestBlock:requestBlock resultBlock:^(HXBRequestUserInfoViewModel *viewModel, NSError *error) {
        if(viewModel) {
            [self setValueWithUserInfoModel:viewModel];
            
            BOOL isAccountActivation = viewModel.userInfoModel.userInfo.isUserActive;
            if(!isAccountActivation && viewModel.userInfoModel.userInfo.isCreateEscrowAcc) {//账户需要激活
                [[HXBAccountActivationManager sharedInstance] entryActiveAccountPage];
                if (resultBlock) {
                    resultBlock(nil, [NSError errorWithDomain:@"" code:kHXBCode_AlreadyPopWindow userInfo:nil]);
                }
            }
            else {
                if (resultBlock) {
                    resultBlock(viewModel, nil);
                }
            }
        }
        else{
            if (resultBlock) {
                resultBlock(nil, error);
            }
        }
    }];
}

- (BOOL)removeAllInfo
{
    KeyChainManage *manager = KeyChain;
    BOOL rmSuccess = [manager.keychain removeAllItems];
    
    return rmSuccess;
}

- (void)signOut
{
    KeyChainManage *manager = KeyChain;
    self.isLogin = NO;
    [HXBRequestUserInfoAgent signOut];
    [manager.keychain removeItemForKey:kLoginPwd];
    [manager.keychain removeItemForKey:kTradePwd];
    [manager.keychain removeItemForKey:kToken];
    [manager.keychain removeItemForKey:kCiphertext];
}

- (void)removeGesture
{
    KeyChainManage *manager = KeyChain;
    [manager.keychain removeItemForKey:kGesturePwd];
    [manager.keychain removeItemForKey:kGesturePwdCount];
}

- (void)removeToken
{
    KeyChainManage *manager = KeyChain;
    [manager.keychain removeItemForKey:kToken];
}

#pragma mark - KVC
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
//    DLog(@"undefine key ---%@",key);
}

#pragma mark - getter/setter
-(BOOL)isLogin
{
    NSLog(@"token = %@",self.token);
    NSLog(@"phone = %@",self.mobile);
//    BOOL isLogin = self.mobile.length;
    return [self.keychain[kIsLogin] integerValue];
}

- (void)setIsLogin:(BOOL)isLogin {
    self.keychain[kIsLogin] = @(isLogin).description;
    NSLog(@"description = %@",  @(isLogin).description);
}

- (void)setMobile:(NSString *)mobile {
    _mobile = mobile;
    self.keychain[kMobile] = mobile;
}
- (NSString *)mobile {
    return self.keychain[kMobile];
}
- (void)setToken:(NSString *)token
{
    self.keychain[kToken] = token;
    
    //    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:kService];
    //    keychain[kPhoneNum] = phoneNum;
    //    keychain[kToken] = token;
}
- (NSString *)token
{
    NSString *token = self.keychain[kToken];
    return token?:@"";
}

- (NSString *)h5host
{
    NSString *h5Host = self.keychain[hostH5];
    if (!h5Host.length) {
        h5Host = @"https://m.hoomxb.com";
    }
    return h5Host;
}

- (void)setH5host:(NSString *)h5host
{
    self.keychain[hostH5] = h5host;
}

-(void)setAvatarImageURL:(NSString *)avatarImageURL
{
    self.keychain[kAvatarImageURL] = avatarImageURL;
}

-(NSString *)avatarImageURL
{
    NSString *avatarImageUrl = self.keychain[kAvatarImageURL];
    return avatarImageUrl?:@"";
}

/**
- (void)setPhone:(NSString *)phone
{
    self.keychain[kPhone] = phone;
}
- (NSString *)phone
{
    NSString *phone = self.keychain[kPhone];
    return phone?:@"";
}
*/

/*
- (void)setUserId:(NSString *)userId
{
    self.keychain[kUserId] = userId;
}
- (NSString *)userId
{
    NSString *userId = self.keychain[kUserId];
    return userId?:@"";
}
 **/

- (BOOL)ishaveNet {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

- (void)setInviteCode:(NSString *)inviteCode
{
    self.keychain[kInviteCode] = inviteCode;
}
- (NSString *)inviteCode
{
    NSString *inviteCode = self.keychain[kInviteCode];
    return inviteCode?:@"";
}

- (void)setLoginPwd:(NSString *)loginPwd
{
    self.keychain[kLoginPwd] = loginPwd;
}
- (NSString *)loginPwd
{
    NSString *loginPwd = self.keychain[kLoginPwd];
    return loginPwd?:@"";
}

- (NSString *)ciphertext
{
    NSString *ciphertext = self.keychain[kCiphertext];
    return ciphertext?:@"";
}

- (void)setCiphertext:(NSString *)ciphertext
{
    self.keychain[kCiphertext] = ciphertext;
}

- (void)setTradePwd:(NSString *)tradePwd
{
    self.keychain[kTradePwd] = tradePwd;
}
- (NSString *)tradePwd
{
    NSString *tradePwd = self.keychain[kTradePwd];
    return tradePwd?:@"";
}

- (void)setGesturePwd:(NSString *)gesturePwd
{
    self.keychain[kGesturePwd] = gesturePwd;
}

- (void)setGesturePwdCount:(NSString *)gesturePwdCount
{
    self.keychain[kGesturePwdCount] = gesturePwdCount;
}

- (void)setSiginCount:(NSString *)siginCount {
    self.keychain[kSiginPwd] = siginCount;
}
- (NSString *)siginCount {
    return self.keychain[kSiginPwd] ? : @"0";
}

- (NSString *)gesturePwd
{
    NSString *gesturePwd = self.keychain[kGesturePwd];
    return gesturePwd?:@"";
}

- (NSString *)gesturePwdCount
{
    NSString *gesturePwdCount = self.keychain[kGesturePwdCount];
    return gesturePwdCount?:@"";
}

- (void)setRealId:(NSString *)realId
{
    self.keychain[kRealId] = realId;
}
- (NSString *)realId
{
    NSString *realId = self.keychain[kRealId];
    return realId?:@"";
}

- (void)setRealName:(NSString *)realName
{
    self.keychain[kRealName] = realName;
}
- (NSString *)realName
{
    NSString *realName = self.keychain[kRealName];
    return realName?:@"";
}

- (void)setDefBankNum:(NSString *)defBankNum
{
    self.keychain[kDefBankNum] = defBankNum;
}

- (NSString *)defBankNum
{
    NSString *defBankNum = self.keychain[kDefBankNum];
    return defBankNum?:@"";
}
/*
- (NSString *)assetsTotal{
    NSString *assetsTotal = self.keychain[kAssetsTotal];
    return assetsTotal?:@"";
}

- (void)setAssetsTotal:(NSString *)assetsTotal{
    self.keychain[kAssetsTotal] = assetsTotal;
}
**/
// 对象存取时，需要做处理
- (void)setBankNumArr:(NSArray *)bankNumArr
{
    NSData *bankData = [NSKeyedArchiver archivedDataWithRootObject:bankNumArr];
    [self.keychain setData:bankData forKey:kBankNumArr];
}

- (NSArray *)bankNumArr
{
    NSData *bankData = [self.keychain dataForKey:kBankNumArr];
    NSArray *bankArr = (NSArray *)[NSKeyedUnarchiver unarchiveObjectWithData:bankData];
    
    return bankArr.count?bankArr:[NSArray array];
}

- (NSString *)skipGesture {
    return self.keychain[kHXBGesturePwdSkipeKey];
}

- (void)setSkipGesture:(NSString *)skipGesture {
    self.keychain[kHXBGesturePwdSkipeKey] = skipGesture;
}

- (void)setSkipGestureAlertAppeared:(BOOL)skipGestureAlertAppeared {
    self.keychain[kHXBGesturePwdSkipeAppeardKey] = @(skipGestureAlertAppeared).description;
}

- (BOOL)skipGestureAlertAppeared {
    return [self.keychain[kHXBGesturePwdSkipeAppeardKey] integerValue];
}

//- (void)setValueWith
@end

