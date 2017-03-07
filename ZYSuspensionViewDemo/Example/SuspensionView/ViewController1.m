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
    [self.susView removeFromScreen];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"SuspensionView";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Just create a ZYSuspensionView
//    UIColor *color = [UIColor colorWithRed:0.50f green:0.89f blue:0.31f alpha:1.00f];
    UIColor *color = [UIColor colorWithRed:0.97 green:0.30 blue:0.30 alpha:1.00];
    ZYSuspensionView *susView = [[ZYSuspensionView alloc] initWithFrame:CGRectMake(- 50.0 / 6, 200, 50, 50)
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
