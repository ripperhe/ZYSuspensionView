//
//  ViewController.m
//  ZYSuspensionViewDemo
//
//  Created by ripper on 16/8/22.
//  Copyright © 2016年 ripper. All rights reserved.
//

#import "ViewController.h"
#import "ZYSuspensionView.h"

@interface ViewController ()<ZYSuspensionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    ZYSuspensionView *sus = [ZYSuspensionView defaultSuspensionViewWithDelegate:self];
    [sus setTitle:@"测试" forState:UIControlStateNormal];
    [sus show];
    
    
    
    UIColor *color = [UIColor colorWithRed:0.50f green:0.89f blue:0.31f alpha:1.00f];
    
    ZYSuspensionView *sus2 = [[ZYSuspensionView alloc] initWithFrame:CGRectMake(0, 200, 50, 50)
                                                               color:color
                                                            delegate:self];
    sus2.leanType = ZYSuspensionViewLeanTypeEachSide;
    [sus2 setTitle:@"测试2" forState:UIControlStateNormal];
    [sus2 show];
}

#pragma mark - SuspensionViewDelegate
- (void)suspensionViewClick:(ZYSuspensionView *)suspensionView
{
    NSLog(@"%@ 点击事件",suspensionView.titleLabel.text);
}


@end
