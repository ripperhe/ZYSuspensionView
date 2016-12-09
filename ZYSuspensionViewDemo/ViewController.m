//
//  ViewController.m
//  ZYSuspensionViewDemo
//
//  Created by ripper on 16/8/22.
//  Copyright © 2016年 ripper. All rights reserved.
//

#import "ViewController.h"
#import "ZYSuspensionView.h"
#import "ZYTestManager.h"

@interface ViewController ()<ZYSuspensionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    /** ********** 测试用例1: 悬浮球配合测试工具使用 ********** */
    
    [self suspensionViewWithTestManagerExample];
    
    
    
    
    /** ********** 测试用例2: 仅仅创建一个悬浮球 ********** */
    
    [self suspensionViewExample];
}

- (void)suspensionViewWithTestManagerExample
{
    // ZYTestManager 所有方法，在 release 模式下自动屏蔽，发布上线不会受到影响
    
    // 显示一个默认的悬浮球
    [ZYTestManager showSuspensionView];
    
    // 添加一个测试条目 (注意blcok的引用问题，如果需要在block中使用self，最好传入__weak)
    [ZYTestManager addTestItemWithTitle:@"new item" action:^{
        NSLog(@"new item : do something ~~~~~~~~~~");
    }];
    
    [ZYTestManager addTestItemWithTitle:@"new item2" action:^{
        NSLog(@"new item2 : do something ~~~~~~~~~~");
    }];
}

- (void)suspensionViewExample
{
    // 仅仅创建一个悬浮球，自行实现点击的代理方法
    
    UIColor *color = [UIColor colorWithRed:0.50f green:0.89f blue:0.31f alpha:1.00f];
    ZYSuspensionView *sus2 = [[ZYSuspensionView alloc] initWithFrame:CGRectMake(- 50.0 / 6, 200, 50, 50)
                                                               color:color
                                                            delegate:self];
    sus2.leanType = ZYSuspensionViewLeanTypeEachSide;
    [sus2 setTitle:@"测试2" forState:UIControlStateNormal];
    [sus2 show];
}


#pragma mark - ZYSuspensionViewDelegate
- (void)suspensionViewClick:(ZYSuspensionView *)suspensionView
{
    NSLog(@"click %@",suspensionView.titleLabel.text);
}


@end
