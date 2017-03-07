//
//  TestManagerConfig.m
//  ZYSuspensionViewDemo
//
//  GitHub https://github.com/ripperhe
//  Created by ripper on 2017/3/7.
//  Copyright © 2017年 ripper. All rights reserved.
//

#import "TestManagerConfig.h"

@implementation TestManagerConfig

+ (void)setupTestManager
{
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
    
    [ZYTestManager setupTestItemPermanentArray:baseArray];
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


@end
