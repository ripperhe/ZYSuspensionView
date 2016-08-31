//
//  ViewController.m
//  ZYSuspensionView
//
//  Created by ripper on 16/8/22.
//  Copyright © 2016年 ripper. All rights reserved.
//

#import "ViewController.h"
#import "SuspensionView.h"

@interface ViewController ()<SuspensionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    SuspensionView *sus = [[SuspensionView alloc] initWithFrame:CGRectMake(-50.0/6, 100, 50, 50) color:[UIColor colorWithRed:0.21f green:0.45f blue:0.88f alpha:1.00f]];
    [sus setTitle:@"测试" forState:UIControlStateNormal];
    sus.delegate = self;
    [sus show];
    
    SuspensionView *sus2 = [[SuspensionView alloc] initWithFrame:CGRectMake(-50.0/6, 200, 50, 50) color:[UIColor colorWithRed:0.50f green:0.89f blue:0.31f alpha:1.00f]];
    [sus2 setTitle:@"测试2" forState:UIControlStateNormal];
    sus2.delegate = self;
    [sus2 show];
}

#pragma mark - SuspensionViewDelegate
- (void)suspensionViewClick:(SuspensionView *)suspensionView
{
    NSLog(@"%@ 点击事件",suspensionView.titleLabel.text);
}


@end
