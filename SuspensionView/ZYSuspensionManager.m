//
//  ZYSuspensionManager.m
//  ZYSuspensionView
//
//  Created by ripper on 16/7/19.
//  Copyright © 2016年 ripper. All rights reserved.
//

#import "ZYSuspensionManager.h"

@interface ZYSuspensionManager ()

/** 持有window的字典 */
@property (nonatomic, strong) NSMutableDictionary *windowDic;

@end

static id kInstanceName;
@implementation ZYSuspensionManager

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kInstanceName = [super allocWithZone:zone];
    });
    return kInstanceName;
}

+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kInstanceName = [[self alloc] init];
    });
    return kInstanceName;
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return kInstanceName;
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

- (UIWindow *)windowForKey:(NSString *)key
{
    return [self.windowDic objectForKey:key];
}

- (void)saveWindow:(UIWindow *)window forKey:(NSString *)key
{
    [self.windowDic setObject:window forKey:key];
}

- (void)destroyWindowForKey:(NSString *)key replaceWith:(UIWindow *)newWindow
{
    UIWindow *window = [self.windowDic objectForKey:key];
    window.hidden = YES;
    if (window.rootViewController.presentedViewController) {
        [window.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:nil];
    }
    window.rootViewController = nil;
    for (UIView *view in window.subviews) {
        [view removeFromSuperview];
    }
    [self.windowDic removeObjectForKey:key];
    if (newWindow) {
        [newWindow makeKeyAndVisible];
    }
}

- (void)destroyAllWindow
{
    for (UIWindow *window in self.windowDic.allValues) {
        window.hidden = YES;
        if (window.rootViewController.presentedViewController) {
            [window.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:nil];
        }
        window.rootViewController = nil;
        for (UIView *view in window.subviews) {
            [view removeFromSuperview];
        }
    }
    [self.windowDic removeAllObjects];
    [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
}

@end
