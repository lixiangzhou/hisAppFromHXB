//
//  HXBDeviceVersion.m
//  hoomxb
//
//  Created by HXB-C on 2017/9/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBDeviceVersion.h"
#import "sys/utsname.h"
@implementation HXBDeviceVersion
+ (NSString *)deviceVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if ([deviceString isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([deviceString isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([deviceString isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([deviceString isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([deviceString isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([deviceString isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([deviceString isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([deviceString isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([deviceString isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([deviceString isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([deviceString isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([deviceString isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([deviceString isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([deviceString isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([deviceString isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([deviceString isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([deviceString isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([deviceString isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    
    if ([deviceString isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    if ([deviceString isEqualToString:@"iPod1,1"])  return @"iPod Touch 1G";
    
    if ([deviceString isEqualToString:@"iPod2,1"])  return @"iPod Touch 2G";
    
    if ([deviceString isEqualToString:@"iPod3,1"])  return @"iPod Touch 3G";
    
    if ([deviceString isEqualToString:@"iPod4,1"])  return @"iPod Touch 4G";
    
    if ([deviceString isEqualToString:@"iPod5,1"])  return @"iPod Touch 5G";
    
    if ([deviceString isEqualToString:@"iPod6,1"])  return @"iPod Touch 6G";
    
    if ([deviceString isEqualToString:@"iPod7,1"])  return @"iPod Touch 7G";
    
    if ([deviceString isEqualToString:@"iPad1,1"])  return @"iPad 1G";
    
    if ([deviceString isEqualToString:@"iPad2,1"])  return @"iPad 2";
    
    if ([deviceString isEqualToString:@"iPad2,2"])  return @"iPad 2";
    
    if ([deviceString isEqualToString:@"iPad2,3"])  return @"iPad 2";
    
    if ([deviceString isEqualToString:@"iPad2,4"])  return @"iPad 2";
    
    if ([deviceString isEqualToString:@"iPad2,5"])  return @"iPad Mini 1G";
    
    if ([deviceString isEqualToString:@"iPad2,6"])  return @"iPad Mini 1G";
    
    if ([deviceString isEqualToString:@"iPad2,7"])  return @"iPad Mini 1G";
    
    if ([deviceString isEqualToString:@"iPad3,1"])  return @"iPad 3";
    
    if ([deviceString isEqualToString:@"iPad3,2"])  return @"iPad 3";
    
    if ([deviceString isEqualToString:@"iPad3,3"])  return @"iPad 3";
    
    if ([deviceString isEqualToString:@"iPad3,4"])  return @"iPad 4";
    
    if ([deviceString isEqualToString:@"iPad3,5"])  return @"iPad 4";
    
    if ([deviceString isEqualToString:@"iPad3,6"])  return @"iPad 4";
    
    if ([deviceString isEqualToString:@"iPad4,1"])  return @"iPad Air";
    
    if ([deviceString isEqualToString:@"iPad4,2"])  return @"iPad Air";
    
    if ([deviceString isEqualToString:@"iPad4,3"])  return @"iPad Air";
    
    if ([deviceString isEqualToString:@"iPad4,4"])  return @"iPad Mini 2G";
    
    if ([deviceString isEqualToString:@"iPad4,5"])  return @"iPad Mini 2G";
    
    if ([deviceString isEqualToString:@"iPad4,6"])  return @"iPad Mini 2G";
    
    if ([deviceString isEqualToString:@"i386"])  return @"iPhone Simulator";
    
    if ([deviceString isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    
   

    　return deviceString;
}
@end
