//
//  ViewController2.m
//  ZYSuspensionViewDemo
//
//  GitHub https://github.com/ripperhe
//  Created by ripper on 2017/3/7.
//  Copyright © 2017年 ripper. All rights reserved.
//

#import "ViewController2.h"
#import "ZYTestManager.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)dealloc
{
    [ZYTestManager removeSuspensionView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"TestManager";
    self.view.backgroundColor = [UIColor whiteColor];

    [self suspensionViewWithTestManagerExample];
}

#pragma mark - 悬浮球 + 测试组件
- (void)suspensionViewWithTestManagerExample
{
    // ZYTestManager 所有方法，在 release 模式下自动屏蔽，发布上线不会受到影响
    
    // 显示一个默认的悬浮球
    [ZYTestManager showSuspensionView];
    
    // 设置常驻的测试条目
    NSArray *baseArray = @[
                           @{
                               kTestTitleKey: @"item1",
                               kTestAutoCloseKey: @YES,
                               kTestActionKey: ^{
                                   NSLog(@"click item1 : do something ~~~~~");
                               }
                               },
                           @{
                               kTestTitleKey:@"item2",
                               kTestAutoCloseKey: @NO,
                               kTestActionKey:^{
                                   NSLog(@"click item2 : do something ~~~~~");
                               }
                               },
                           ];
    
    [ZYTestManager setupTestItemPermanentArray:baseArray];
    
    
    // 添加一个测试条目 (注意blcok的引用问题，如果需要在block中使用self，最好传入__weak)
    [ZYTestManager addTestItemWithTitle:@"new item" autoClose:YES action:^{
        NSLog(@"click new item : do something ~~~~~~~~~~");
    }];
    
    [ZYTestManager addTestItemWithTitle:@"new item2" autoClose:NO action:^{
        NSLog(@"click new item2 : do something ~~~~~~~~~~");
        
        Class VCClass = NSClassFromString(@"SomeViewController");
        if (VCClass && [VCClass isSubclassOfClass:[UIViewController class]]) {
            UIViewController *vc = [VCClass new];
            [[ZYTestManager shareInstance].testTableViewController presentViewController:vc animated:YES completion:nil];
        }
    }];
}


@end
