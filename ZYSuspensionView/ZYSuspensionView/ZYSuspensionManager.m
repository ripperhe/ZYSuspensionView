//
//  ZYSuspensionManager.m
//  ZYSuspensionView
//
//  GitHub https://github.com/ripperhe
//  Created by ripper on 16/7/19.
//  Copyright © 2016年 ripper. All rights reserved.
//

#import "ZYSuspensionManager.h"

@interface ZYSuspensionManager ()

/** save windows dictionary */
@property (nonatomic, strong) NSMutableDictionary *windowDic;

@end

@implementation ZYSuspensionManager

static ZYSuspensionManager *_instance;

+ (instancetype)shared
{
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[self alloc] init];
        });
    }
    return _instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}


#pragma mark - getter
- (NSMutableDictionary *)windowDic
{
    if (!_windowDic) {
        _windowDic = [NSMutableDictionary dictionary];
    }
    return _windowDic;
}

#pragma mark - public methods

+ (UIWindow *)windowForKey:(NSString *)key
{
    return [[ZYSuspensionManager shared].windowDic objectForKey:key];
}

+ (void)saveWindow:(UIWindow *)window forKey:(NSString *)key
{
    [[ZYSuspensionManager shared].windowDic setObject:window forKey:key];
}

+ (void)destroyWindowForKey:(NSString *)key
{
    UIWindow *window = [[ZYSuspensionManager shared].windowDic objectForKey:key];
    window.hidden = YES;
    if (window.rootViewController.presentedViewController) {
        [window.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:nil];
    }
    window.rootViewController = nil;
    [[ZYSuspensionManager shared].windowDic removeObjectForKey:key];
}

+ (void)destroyAllWindow
{
    for (UIWindow *window in [ZYSuspensionManager shared].windowDic.allValues) {
        window.hidden = YES;
        window.rootViewController = nil;
    }
    [[ZYSuspensionManager shared].windowDic removeAllObjects];
    [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
}

@end
