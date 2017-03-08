//
//  LoginManagerConfig.m
//  ZYSuspensionViewDemo
//
//  GitHub https://github.com/ripperhe
//  Created by ripper on 2017/3/7.
//  Copyright © 2017年 ripper. All rights reserved.
//

#import "LoginManagerConfig.h"

@interface LoginManagerConfig ()<ZYLoginManagerDelegate>

@end

@implementation LoginManagerConfig

static LoginManagerConfig *_instance;

+ (instancetype)shareInstance
{
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[LoginManagerConfig alloc] init];
        });
    }
    return _instance;
}

+ (void)setupLoginManager
{
    [ZYLoginManager shareInstance].delegate = [LoginManagerConfig shareInstance];
    
    [ZYLoginManager showSuspensionView];
    
    NSDictionary *accountDic = @{
                                 @"h1":@"11111",
                                 @"h2":@"22222",
                                 @"h3":@"33333",
                                 @"h4":@"44444",
                                 @"h5":@"55555",
                                 };
    [ZYLoginManager setupPermanentAccountInfoDic:accountDic];
}

#pragma mark - ZYLoginManagerDelegate
- (void)loginManager:(ZYLoginManager *)loginManager loginWithAccout:(NSString *)account password:(NSString *)password
{
    NSLog(@"sandbox cache path : \n%@", [ZYLoginManager accountInfoPlistPath]);

    NSLog(@"accout : %@   password : %@", account, password);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kZYLoginSuccessNotificationKey object:@{@"new!!!!":@"bewwewewe"}];
        
    });
    
}


@end
