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
#import "TestManagerConfig.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)dealloc
{
    // In order not to affect other demo
    [ZYTestManager removeSuspensionView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"TestManager";
    self.view.backgroundColor = [UIColor whiteColor];

    
    // This code is usually written in AppDelegate's @selector(application:didFinishLaunchingWithOptions:)
    [TestManagerConfig setupTestManager];
    
    
    // Add a test item. You can add test items anywhere. (note the blcok reference problem, and if you need to use self in block, it is best to use __weak)
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
