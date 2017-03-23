//
//  ViewController1.m
//  ZYSuspensionViewDemo
//
//  GitHub https://github.com/ripperhe
//  Created by ripper on 2017/3/7.
//  Copyright © 2017年 ripper. All rights reserved.
//

#import "ViewController1.h"
#import "ZYSuspensionView.h"

@interface ViewController1 ()<ZYSuspensionViewDelegate>

@property (nonatomic, weak) ZYSuspensionView *susView;

@end

@implementation ViewController1

-(void)dealloc
{
    // In order not to affect other demo
    [self.susView removeFromScreen];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"SuspensionView";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Just create a ZYSuspensionView
    UIColor *color = [UIColor colorWithRed:0.97 green:0.30 blue:0.30 alpha:1.00];
    ZYSuspensionView *susView = [[ZYSuspensionView alloc] initWithFrame:CGRectMake([ZYSuspensionView suggestXWithWidth:100], 200, 100, 100)
                                                               color:color
                                                            delegate:self];
    susView.leanType = ZYSuspensionViewLeanTypeEachSide;
    [susView setTitle:@"JSUT" forState:UIControlStateNormal];
    [susView show];
    self.susView = susView;
}

#pragma mark - ZYSuspensionViewDelegate
- (void)suspensionViewClick:(ZYSuspensionView *)suspensionView
{
    NSLog(@"click %@",suspensionView.titleLabel.text);
}

@end
