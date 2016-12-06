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

@implementation ZYSuspensionManager

static ZYSuspensionManager *_instance;

+ (instancetype)shared
{
    if (!_instance) {
        _instance = [[self alloc] init];
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

- (UIWindow *)windowForKey:(NSString *)key
{
    return [self.windowDic objectForKey:key];
}

- (void)saveWindow:(UIWindow *)window forKey:(NSString *)key
{
    [self.windowDic setObject:window forKey:key];
}

- (void)destroyWindowForKey:(NSString *)key newKeyWindow:(UIWindow *)newWindow
{
    UIWindow *window = [self.windowDic objectForKey:key];
    window.hidden = YES;
    window.rootViewController = nil;
    [self.windowDic removeObjectForKey:key];
    if (newWindow) {
        [newWindow makeKeyAndVisible];
    }
}

- (void)destroyAllWindow
{
    for (UIWindow *window in self.windowDic.allValues) {
        window.hidden = YES;
        window.rootViewController = nil;
    }
    [self.windowDic removeAllObjects];
    [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
}

@end
