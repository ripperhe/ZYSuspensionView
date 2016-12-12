//
//  ZYTestManager.m
//  ZYSuspensionView
//
//  Created by ripper on 2016/12/9.
//  Copyright © 2016年 ripper. All rights reserved.
//

#import "ZYTestManager.h"
#import "ZYSuspensionView.h"
#import "ZYSuspensionManager.h"
#import "ZYTestTableViewController.h"
#import <UIKit/UIKit.h>

NSString *const kTestTitleKey = @"title";
NSString *const kTestAutoCloseKey = @"autoClose";
NSString *const kTestActionKey = @"action";

@interface ZYTestManager ()<ZYSuspensionViewDelegate>

/** 长期存在的测试条目 */
@property (nonatomic, strong) NSArray <NSDictionary *>*testItemPermanentArray;
/** 新增的测试条目 */
@property (nonatomic, strong) NSMutableDictionary *testItemDic;
/** 显示测试条目的控制器 */
@property (nonatomic, weak, nullable) UIViewController *testTableViewController;

@end


@implementation ZYTestManager

static ZYTestManager *_instance;

+ (instancetype)shareInstance
{
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[ZYTestManager alloc] init];
        });
    }
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

#pragma mark - getter
- (NSMutableDictionary *)testItemDic
{
    if (!_testItemDic) {
        _testItemDic = [NSMutableDictionary dictionary];
    }
    return _testItemDic;
}

#pragma mark - API 
+ (void)showSuspensionView
{
#if DEBUG
    ZYSuspensionView *sus = [ZYSuspensionView defaultSuspensionViewWithDelegate:[ZYTestManager shareInstance]];
    [sus setTitle:@"测试" forState:UIControlStateNormal];
    [sus show];
#endif
}

+ (void)setupTestItemPermanentArray:(NSArray <NSDictionary *>*)array
{
#if DEBUG
    [ZYTestManager shareInstance].testItemPermanentArray = array;
#endif
}

+ (void)addTestItemWithTitle:(NSString *)title autoClose:(BOOL)autoClose action:(void(^)())action
{
#if DEBUG
    if (title.length == 0 || !action) {
        return;
    }
    NSDictionary *dic = @{
                          kTestAutoCloseKey: @(autoClose),
                          kTestActionKey: action
                          };
    [[ZYTestManager shareInstance].testItemDic setObject:dic forKey:title];
#endif
}

#pragma mark - ZYSuspensionViewDelegate
- (void)suspensionViewClick:(ZYSuspensionView *)suspensionView
{
#if DEBUG
    if ([ZYSuspensionManager windowForKey:kZYTestTableControllerKey]) {
        [ZYSuspensionManager destroyWindowForKey:kZYTestTableControllerKey];
        [ZYTestManager shareInstance].testTableViewController = nil;
    }else{
        
        UIWindow *currentKeyWindow = [UIApplication sharedApplication].keyWindow;
        ZYTestTableViewController *testTableViewVC = [[ZYTestTableViewController alloc] init];
        UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.rootViewController = testTableViewVC;
        window.windowLevel = UIWindowLevelAlert * 2 - 1;
        [window makeKeyAndVisible];
        [ZYSuspensionManager saveWindow:window forKey:kZYTestTableControllerKey];
        [currentKeyWindow makeKeyWindow];
        [ZYTestManager shareInstance].testTableViewController = testTableViewVC;
    }
#endif
}

@end
