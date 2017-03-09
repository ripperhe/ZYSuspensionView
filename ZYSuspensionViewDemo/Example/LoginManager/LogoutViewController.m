//
//  LogoutViewController.m
//  ZYSuspensionViewDemo
//
//  GitHub https://github.com/ripperhe
//  Created by ripper on 2017/3/8.
//  Copyright © 2017年 ripper. All rights reserved.
//

#import "LogoutViewController.h"

@interface LogoutViewController ()

@end

@implementation LogoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setHidesBackButton:YES];
}

- (IBAction)clickLogout:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    // When you log out successfully, please send ZYLogoutSuccess Notification.
    // The susView will be show again.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kZYLogoutSuccessNotificationKey"
                                                        object:nil];
}


@end
