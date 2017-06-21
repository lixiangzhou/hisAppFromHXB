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

static NSString * const kService = @"www.hoomxb.com";
//注册时返回的信息
static NSString * const kToken = @"token";
static NSString * const kPhone = @"phone";
static NSString * const kUserId = @"userId";
static NSString * const kInviteCode = @"inviteCode";

static NSString * const kLoginPwd = @"loginPwd";
static NSString * const kTradePwd = @"tradePwd";
static NSString * const kGesturePwd = @"gesturePwd";
static NSString * const kGesturePwdCount = @"gesturePwdCount";

static NSString * const kRealName = @"realName";
static NSString * const kRealId = @"realId";
static NSString * const kDefBankNum = @"defBankNum";

static NSString * const kBankNumArr = @"bankNumArr";
static NSString * const kAvatarImageURL = @"avatarImageURL";
static NSString * const kLocalAvatarImageData = @"kLocalAvatarImageData";
static NSString * const kAssetsTotal = @"kAssetsTotal";

@interface KeyChainManage ()

@property (nonatomic, strong) UICKeyChainStore *keychain;
//UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:kService];

@end

@implementation KeyChainManage

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

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.gesturePwd = @"";
    }
    return self;
}

#pragma mark - 常用方法
- (BOOL)isVerify
{
    BOOL isVerify = (![[KeyChain realId] isEqualToString:@""] && ![[KeyChain realName] isEqualToString:@""]);
    
    return isVerify;
}

- (BOOL)isSwitchOn
{
    BOOL isSwitchOn = (![[KeyChain gesturePwd] isEqualToString:@""] && [KeyChain isLogin]);
    
    return isSwitchOn;
}

- (BOOL)hasBindBankcard
{
    NSArray *bankArr = [KeyChain bankNumArr];
    
    BOOL hasBankcard = (bankArr != nil && ![bankArr  isEqual: @[]]);
    
    return hasBankcard;
}

- (BOOL)isInvest{
    BOOL isInvest = ![[KeyChain assetsTotal] isEqualToString:@""] && [KeyChain isLogin];
    return isInvest;
}

- (BOOL)removeAllInfo
{
    //
    KeyChainManage *manager = KeyChain;
    BOOL rmSuccess = [manager.keychain removeAllItems];
    
    return rmSuccess;
}

- (void)removePassword
{
    KeyChainManage *manager = KeyChain;
    [manager.keychain removeItemForKey:kLoginPwd];
    [manager.keychain removeItemForKey:kTradePwd];
    [manager.keychain removeItemForKey:kGesturePwd];
    [manager.keychain removeItemForKey:kGesturePwdCount];
}

- (void)removeGesture
{
    KeyChainManage *manager = KeyChain;
    [manager.keychain removeItemForKey:kGesturePwd];
}

- (void)removeGesturePwdCount
{
    KeyChainManage *manager = KeyChain;
    [manager.keychain removeItemForKey:kGesturePwdCount];
}

- (void)removeToken
{
    KeyChainManage *manager = KeyChain;
    [manager.keychain removeItemForKey:kToken];
}

- (void)printAllInfo
{
//    KeyChainManage *manager = KeyChain;
//    DLog(@"kcManager-info:\n{\n phone:%@\n token:%@\n userId:%@\n inviteCode:%@\n loginpwd:%@\n tradepwd:%@\n realName:%@\n realID:%@\n bankArr:%@\n}",manager.phone,manager.token,manager.userId,manager.inviteCode,manager.loginPwd,manager.tradePwd,manager.realName,manager.realId,manager.bankNumArr);
//    DLog(@"keychain-realinfo:\nallkey:%@,\nallitem:%@",manager.keychain.allKeys,manager.keychain.allItems);
//    DLog(@"kc-bankArr:%@\nkc-token:%@",[NSKeyedUnarchiver unarchiveObjectWithData:[manager.keychain dataForKey:kBankNumArr]],manager.keychain[kToken]);
//    DLog(@"manager.bankarr:%@",manager.bankNumArr);
}

#pragma mark - KVC
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
//    DLog(@"undefine key ---%@",key);
}

#pragma mark - getter/setter
-(BOOL)isLogin
{
    BOOL isLogin = self.token.length && self.phone.length;
    NSLog(@"token = %@",self.token);
    NSLog(@"phone = %@",self.phone);
    return isLogin;
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
-(void)setAvatarImageURL:(NSString *)avatarImageURL
{
    self.keychain[kAvatarImageURL] = avatarImageURL;
}

-(NSString *)avatarImageURL
{
    NSString *avatarImageUrl = self.keychain[kAvatarImageURL];
    return avatarImageUrl?:@"";
}

- (void)setPhone:(NSString *)phone
{
    self.keychain[kPhone] = phone;
}
- (NSString *)phone
{
    NSString *phone = self.keychain[kPhone];
    return phone?:@"";
}

- (void)setUserId:(NSString *)userId
{
    self.keychain[kUserId] = userId;
}
- (NSString *)userId
{
    NSString *userId = self.keychain[kUserId];
    return userId?:@"";
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

- (NSString *)assetsTotal{
    NSString *assetsTotal = self.keychain[kAssetsTotal];
    return assetsTotal?:@"";
}

- (void)setAssetsTotal:(NSString *)assetsTotal{
    self.keychain[kAssetsTotal] = assetsTotal;
}

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


@end
