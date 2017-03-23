//
//  ZYLoginManager.m
//  ZYSuspensionViewDemo
//
//  GitHub https://github.com/ripperhe
//  Created by ripper on 2017/3/7.
//  Copyright © 2017年 ripper. All rights reserved.
//

#import "ZYLoginManager.h"
#import "ZYSuspensionView.h"
#import "ZYSuspensionManager.h"
#import "ZYLoginTableViewController.h"

NSString *const kZYLoginSuccessNotificationKey = @"kZYLoginSuccessNotificationKey";
NSString *const kZYLogoutSuccessNotificationKey = @"kZYLogoutSuccessNotificationKey";

@interface ZYLoginManager ()<ZYSuspensionViewDelegate>

@property (nonatomic, weak) ZYSuspensionView *susView;
@property (nonatomic, strong) NSDictionary <NSString *, NSString *>*permanentBetaAccountInfoDic;
@property (nonatomic, strong) NSDictionary <NSString *, NSString *>*permanentOfficalAccountInfoDic;
@property (nonatomic, weak) UIViewController *loginTableViewController;

@end

@implementation ZYLoginManager

static ZYLoginManager *_instance;

+ (instancetype)shareInstance
{
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[ZYLoginManager alloc] init];
        });
    }
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
        [[NSNotificationCenter defaultCenter] addObserver:_instance selector:@selector(loginSuccessNoti:) name:kZYLoginSuccessNotificationKey object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:_instance selector:@selector(logoutSuccessNoti:) name:kZYLogoutSuccessNotificationKey object:nil];
    });
    return _instance;
}

#pragma mark - getter
- (NSDictionary<NSString *,NSString *> *)newAccountInfoDic
{
    NSDictionary *accountDic = [NSDictionary dictionaryWithContentsOfFile:[ZYLoginManager accountInfoPlistPath]];
    return accountDic;
}


#pragma mark - event response
- (void)loginSuccessNoti:(NSNotification *)noti
{
#if DEBUG
    [ZYLoginManager removeSuspensionView];
    NSObject *obj = noti.object;
    if ([obj isKindOfClass:[NSDictionary class]]) {
        if (((NSDictionary *)obj).allKeys.count > 0) {
            NSString *account = ((NSDictionary *)obj).allKeys.firstObject;
            NSString *password = [((NSDictionary *)obj) objectForKey:account];
            if (password.length) {
                [ZYLoginManager saveAccount:account password:password];
            }
        }
    }
#endif
}

- (void)logoutSuccessNoti:(NSNotification *)noti
{
#if DEBUG
    [ZYLoginManager showSuspensionView];
#endif
}

#pragma mark - ZYSuspensionViewDelegate
- (void)suspensionViewClick:(ZYSuspensionView *)suspensionView
{
#if DEBUG
    if ([ZYSuspensionManager windowForKey:kZYLoginTableControllerKey]) {
        [ZYSuspensionManager destroyWindowForKey:kZYLoginTableControllerKey];
        [ZYLoginManager shareInstance].loginTableViewController = nil;
    }else{
        
        UIWindow *currentKeyWindow = [UIApplication sharedApplication].keyWindow;
        ZYLoginTableViewController *loginTableViewVC = [[ZYLoginTableViewController alloc] init];
        ZYSuspensionContainer *window = [[ZYSuspensionContainer alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.rootViewController = loginTableViewVC;
        window.windowLevel -= 1;
        [window makeKeyAndVisible];
        [ZYSuspensionManager saveWindow:window forKey:kZYLoginTableControllerKey];
        [currentKeyWindow makeKeyWindow];
        [ZYLoginManager shareInstance].loginTableViewController = loginTableViewVC;
    }
#endif
}

#pragma mark - private methods
+ (void)saveAccount:(NSString *)account password:(NSString *)password
{
#if DEBUG
    NSMutableDictionary *accountDic = [NSDictionary dictionaryWithContentsOfFile:[self accountInfoPlistPath]].mutableCopy;
    if (!accountDic) {
        accountDic = [NSMutableDictionary dictionary];
    }
    
    [accountDic setObject:password forKey:account];
    [accountDic writeToFile:[self accountInfoPlistPath] atomically:YES];
#endif
}

/**
 code from http://stackoverflow.com/questions/24825123/get-the-current-view-controller-from-the-app-delegate%EF%BC%89
 */
+ (UIViewController*)findBestViewController:(UIViewController*)vc
{
    if (vc.presentedViewController) {
        
        // Return presented view controller
        return [self findBestViewController:vc.presentedViewController];
        
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        
        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        
        // Return top view
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.topViewController];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.selectedViewController];
        else
            return vc;
        
    } else {
        
        // Unknown view controller type, return last child view controller
        return vc;
        
    }
}

#pragma mark - API
+ (void)showSuspensionView
{
#if DEBUG
    if ([ZYLoginManager shareInstance].susView) {
        [[ZYLoginManager shareInstance].susView removeFromScreen];
    }
    
    UIColor *color = [UIColor colorWithRed:0.50f green:0.89f blue:0.31f alpha:1.00f];
    ZYSuspensionView *susView = [[ZYSuspensionView alloc] initWithFrame:CGRectMake(-8, 200, 55, 55)
                                                                  color:color
                                                               delegate:[ZYLoginManager shareInstance]];
    [susView setTitle:@"Login" forState:UIControlStateNormal];
    [susView show];

    [ZYLoginManager shareInstance].susView = susView;
#endif
}

+ (void)removeSuspensionView
{
#if DEBUG
    [[ZYLoginManager shareInstance].susView removeFromScreen];
#endif
}

+ (void)setupPermanentAccountInfoDic:(NSDictionary<NSString *,NSString *> *)infoDic isBeta:(BOOL)isBeta
{
#if DEBUG
    if (isBeta) {
        [ZYLoginManager shareInstance].permanentBetaAccountInfoDic = infoDic;
    }else{
        [ZYLoginManager shareInstance].permanentOfficalAccountInfoDic = infoDic;
    }
#endif
}

+ (void)removeSuspensionViewAndAddAccount:(NSString *)account password:(NSString *)password
{
#if DEBUG
    [self removeSuspensionView];
    [self saveAccount:account password:password];
#endif
}

+ (void)closeLoginTableViewController
{
#if DEBUG
    [ZYSuspensionManager destroyWindowForKey:kZYLoginTableControllerKey];
    [ZYLoginManager shareInstance].loginTableViewController = nil;
#endif
}

+ (NSString *)accountInfoPlistPath
{
    // cache path
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *plistPath = nil;
    BOOL isBeta = YES;
    if ([[ZYLoginManager shareInstance].delegate respondsToSelector:@selector(loginManagerIsGetBetaAccountInfos:)]) {
        isBeta = [[ZYLoginManager shareInstance].delegate loginManagerIsGetBetaAccountInfos:[ZYLoginManager shareInstance]];
    }
    if (isBeta) {
        plistPath = [cachePath stringByAppendingPathComponent:@"com.ripperhe.zyloginmanager.beta.plist"];
    }else{
        plistPath = [cachePath stringByAppendingPathComponent:@"com.ripperhe.zyloginmanager.official.plist"];
    }
    
    return plistPath;
}

+ (void)removeInfoPlist
{
    [[NSFileManager defaultManager] removeItemAtPath:[self accountInfoPlistPath] error:nil];
}

+ (UIViewController *)currentViewControllerWithWindow:(UIWindow *)window
{
    // Find best view controller
    UIWindow *targetWindow = window ? window : [[[UIApplication sharedApplication] delegate] window];
    UIViewController* viewController = targetWindow.rootViewController;
    return [self findBestViewController:viewController];
}

@end
