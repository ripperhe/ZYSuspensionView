//
//  ViewController3.m
//  ZYSuspensionViewDemo
//
//  GitHub https://github.com/ripperhe
//  Created by ripper on 2017/3/7.
//  Copyright © 2017年 ripper. All rights reserved.
//

#import "ViewController3.h"
#import "LoginManagerConfig.h"
#import "LoginViewController.h"

@interface ViewController3 ()

@end

@implementation ViewController3

- (void)dealloc
{
    // In order not to affect other demo
    [ZYLoginManager removeSuspensionView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"LoginManager";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [LoginManagerConfig setupLoginManager];
    
    // TODO: 3.代理回调是否为登录状态
}

- (IBAction)goToTestLogin:(id)sender {
    
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    LoginViewController *loginVC = [board instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.navigationController pushViewController:loginVC animated:YES];
}

@end
