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

@interface ViewController3 ()

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"LoginManager";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [LoginManagerConfig setupLoginManager];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [ZYLoginManager removeSuspensionViewAndAddAccount:@"aaaaa" password:@"bbbbb"];
}



@end
