//
//  NSObject+ZYSuspensionView.m
//  ZYSuspensionView
//
//  Created by ripper on 16/7/20.
//  Copyright © 2016年 ripper. All rights reserved.
//

#import "NSObject+ZYSuspensionView.h"
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>

const void *zy_suspensionMd5Key = &zy_suspensionMd5Key;

@implementation NSObject (ZYSuspensionView)

- (NSString *)zy_md5Key
{
    NSString *str = objc_getAssociatedObject(self, zy_suspensionMd5Key);
    if (str.length <= 0) {
        str = [self getCurrentMd5Key];
        objc_setAssociatedObject(self, zy_suspensionMd5Key, str, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return str;
}

- (NSString *)getCurrentMd5Key
{
    NSString *str = self.description;
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (int)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0],result[1],result[2],result[3],
            result[4],result[5],result[6],result[7],
            result[8],result[9],result[10],result[11],
            result[12],result[13],result[14],result[15]];
}

@end
