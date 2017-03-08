//
//  TestManagerConfig.m
//  ZYSuspensionViewDemo
//
//  GitHub https://github.com/ripperhe
//  Created by ripper on 2017/3/7.
//  Copyright © 2017年 ripper. All rights reserved.
//

#import "TestManagerConfig.h"

@interface TestManagerConfig ()<ZYTestManagerDelegate>

@end

@implementation TestManagerConfig

static TestManagerConfig *_instance;

+ (instancetype)shareInstance
{
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[TestManagerConfig alloc] init];
        });
    }
    return _instance;
}

+ (void)setupTestManager
{
    // delegate (optation)
//    [ZYTestManager shareInstance].delegate = [TestManagerConfig shareInstance];

    // show TestManager' suspensionView
    [ZYTestManager showSuspensionView];
    
    // Set resident test items
    NSArray *baseArray = @[
                           @{
                               kTestTitleKey: @"clean user defaults",
                               kTestAutoCloseKey: @YES,
                               kTestActionKey: ^{
                                   NSLog(@"click 'clean user defaults'");
                                   [self cleanUserDefaults];
                               }
                               },
                           @{
                               kTestTitleKey:@"something",
                               kTestAutoCloseKey: @NO,
                               kTestActionKey:^{
                                   NSLog(@"click 'something'");
                               }
                               },
                           ];
    
    [ZYTestManager setupPermanentTestItemArray:baseArray];
}

#pragma mark - frequently action example
+ (void)cleanUserDefaults
{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    for (id key in [dic allKeys]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - ZYTestManagerDelegate
//- (UIView *)testManagerLoginTableHeaderView:(ZYTestManager *)testManager
//{
//    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    v.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:.6];
//    return v;
//}

@end
