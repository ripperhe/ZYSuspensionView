//
//  LoginViewController.m
//  ZYSuspensionViewDemo
//
//  GitHub https://github.com/ripperhe
//  Created by ripper on 2017/3/8.
//  Copyright © 2017年 ripper. All rights reserved.
//

#import "LoginViewController.h"
#import "LogoutViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)clickLogin:(id)sender {
    
    if (self.accountTF.text.length && self.passwordTF.text.length) {
        [self sendLoginRequestWithAccount:self.accountTF.text password:self.passwordTF.text];
        self.accountTF.text = @"";
        self.passwordTF.text = @"";
    }
}

- (void)sendLoginRequestWithAccount:(NSString *)account password:(NSString *)password
{
    NSLog(@"LoginVC accout : %@   password : %@", account, password);
    
    // show indicator
    UIView *blackView = [[UIView alloc] initWithFrame:self.view.bounds];
    blackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.7];
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicatorView.center = CGPointMake(blackView.frame.size.width / 2.0, blackView.frame.size.height / 2.0);
    [indicatorView startAnimating];
    [blackView addSubview:indicatorView];
    [self.navigationController.view addSubview:blackView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // remove indicator
        [blackView removeFromSuperview];
        
        // push
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        LogoutViewController *logoutVC = [board instantiateViewControllerWithIdentifier:@"LogoutViewController"];
        [self.navigationController pushViewController:logoutVC animated:YES];
        
        // When you log in successfully, please send ZYLoginSuccess Notification with account info.
        // The susView will be removed, and the account info will be saved.
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kZYLoginSuccessNotificationKey"
                                                            object:@{account:password}];
    });
    
}



@end
