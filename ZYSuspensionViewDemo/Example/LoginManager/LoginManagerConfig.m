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
    
    // permanet account infos won't write in the sandbox
    NSLog(@"sandbox cache path : \n%@", [ZYLoginManager accountInfoPlistPath]);
}

#pragma mark - ZYLoginManagerDelegate
- (void)loginManager:(ZYLoginManager *)loginManager loginWithAccout:(NSString *)account password:(NSString *)password
{
    NSLog(@"LoginManagerConfig  accout : %@   password : %@", account, password);
    
    UIViewController *currentVC = [ZYLoginManager currentViewControllerWithWindow:nil];
    
    Class VC3Class = NSClassFromString(@"ViewController3");
    Class LoginVCClass = NSClassFromString(@"LoginViewController");
    
    if (VC3Class && [currentVC isKindOfClass:VC3Class]) {
        
        [currentVC performSelector:@selector(goToTestLogin:) withObject:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIViewController *vc = [ZYLoginManager currentViewControllerWithWindow:nil];
            if ([vc isKindOfClass:LoginVCClass]) {
                [vc performSelector:@selector(sendLoginRequestWithAccount:password:) withObject:account withObject:password];
            }
        });
        
    }else if (LoginVCClass && [currentVC isKindOfClass:LoginVCClass]) {
        
        [currentVC performSelector:@selector(sendLoginRequestWithAccount:password:) withObject:account withObject:password];
        
    }else{
        NSLog(@"can't login at here.");
    }
}

@end
