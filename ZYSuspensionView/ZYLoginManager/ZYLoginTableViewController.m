//
//  ZYLoginTableViewController.m
//  ZYSuspensionViewDemo
//
//  GitHub https://github.com/ripperhe
//  Created by ripper on 2017/3/7.
//  Copyright © 2017年 ripper. All rights reserved.
//

#import "ZYLoginTableViewController.h"
#import "ZYLoginManager.h"
#import "ZYSuspensionManager.h"

const static NSString *kAccountKey = @"kAccountKey";
const static NSString *kPasswordKey = @"kPasswordKey";


@interface ZYLoginTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UIView *backView;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;

@end

@implementation ZYLoginTableViewController

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)dealloc
{
//    NSLog(@"%@ %s", self.description, __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.7];
    [self backView];
    [self tableView];
    [self addAlertAnimation];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = [self tableFrame];
}

#pragma mark - getter
- (CGRect)tableFrame
{
    CGRect frame = CGRectMake(10, 20, [UIScreen mainScreen].bounds.size.width - 10 * 2, [UIScreen mainScreen].bounds.size.height - 120);
    return frame;
}

- (UIView *)backView
{
    if (!_backView) {
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeLoginTableController)];
        UIView *backView = [[UIView alloc] initWithFrame:self.view.bounds];
        backView.userInteractionEnabled = YES;
        [backView addGestureRecognizer:tgr];
        [self.view addSubview:backView];
        _backView = backView;
    }
    return _backView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:[self tableFrame] style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        tableView.layer.cornerRadius = 2;
        tableView.clipsToBounds = YES;
        [self.view addSubview:tableView];
        _tableView = tableView;
        
        UIView *headerView = nil;
        if ([[ZYLoginManager shareInstance].delegate respondsToSelector:@selector(loginManagerLoginTableHeaderView:)]) {
            headerView = [[ZYLoginManager shareInstance].delegate loginManagerLoginTableHeaderView:[ZYLoginManager shareInstance]];
        }
        if (!headerView) {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.text = @"Login Accounts";
            titleLabel.font = [UIFont systemFontOfSize:20];
            titleLabel.backgroundColor = [UIColor colorWithRed:0.50f green:0.89f blue:0.31f alpha:1.00f];
            headerView = titleLabel;
        }
        _tableView.tableHeaderView = headerView;
    }
    return _tableView;
}

- (NSMutableArray *)dataSourceArray
{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
        
        BOOL isBeta = YES;
        if ([[ZYLoginManager shareInstance].delegate respondsToSelector:@selector(loginManagerIsGetBetaAccountInfos:)]) {
            isBeta = [[ZYLoginManager shareInstance].delegate loginManagerIsGetBetaAccountInfos:[ZYLoginManager shareInstance]];
        }
        NSDictionary *permanentDic = nil;
        if (isBeta) {
            permanentDic = [ZYLoginManager shareInstance].permanentBetaAccountInfoDic;
        }else{
            permanentDic = [ZYLoginManager shareInstance].permanentOfficalAccountInfoDic;
        }
        
        NSDictionary *newDic = [ZYLoginManager shareInstance].newAccountInfoDic;
        
        NSMutableDictionary *allAccountInfoDic = [NSMutableDictionary dictionaryWithDictionary:permanentDic];
        if (newDic.allKeys.count) {
            // Remove duplicate items
            [allAccountInfoDic setValuesForKeysWithDictionary:newDic];
        }
        
        for (NSString *key in allAccountInfoDic.allKeys) {
            NSDictionary *dic = @{
                                  kAccountKey: key,
                                  kPasswordKey: allAccountInfoDic[key]
                                  };
            [_dataSourceArray insertObject:dic atIndex:0];
        }
    }
    return _dataSourceArray;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *info = self.dataSourceArray[indexPath.row];
    // Configure the cell...
    cell.textLabel.text = info[kAccountKey];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *info = self.dataSourceArray[indexPath.row];
    [self loginWithInfoDic:info];
    [self closeLoginTableController];
}

#pragma mark - private methods
- (void)closeLoginTableController
{
    [ZYSuspensionManager destroyWindowForKey:kZYLoginTableControllerKey];
}

- (void)addAlertAnimation
{
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    bounceAnimation.values = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0.9],
                              [NSNumber numberWithFloat:1.1],
                              [NSNumber numberWithFloat:0.9],
                              [NSNumber numberWithFloat:1.0], nil];
    bounceAnimation.duration = 0.3;
    bounceAnimation.removedOnCompletion = NO;
    [self.tableView.layer addAnimation:bounceAnimation forKey:nil];
}

- (void)loginWithInfoDic:(NSDictionary *)info
{
    NSString *account = info[kAccountKey];
    NSString *password = info[kPasswordKey];
    
    if (account.length && password.length) {
        if ([[ZYLoginManager shareInstance].delegate respondsToSelector:@selector(loginManager:loginWithAccout:password:)]) {
            [[ZYLoginManager shareInstance].delegate loginManager:[ZYLoginManager shareInstance] loginWithAccout:account password:password];
        }
    }
}

@end
