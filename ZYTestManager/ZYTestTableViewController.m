//
//  ZYTestTableViewController.m
//  ZYSuspensionView
//
//  GitHub https://github.com/ripperhe
//  Created by ripper on 2016/12/9.
//  Copyright © 2016年 ripper. All rights reserved.
//

#import "ZYTestTableViewController.h"
#import "ZYTestManager.h"
#import "ZYSuspensionManager.h"

@interface ZYTestTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UIView *backView;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;

@end

@implementation ZYTestTableViewController

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

#pragma mark - getter
- (UIView *)backView
{
    if (!_backView) {
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeTestTableController)];
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
        CGRect frame = CGRectMake(10, 20, [UIScreen mainScreen].bounds.size.width - 10 * 2, [UIScreen mainScreen].bounds.size.height - 120);
        UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        tableView.layer.cornerRadius = 2;
        tableView.clipsToBounds = YES;
        [self.view addSubview:tableView];
        _tableView = tableView;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"Test Items";
        titleLabel.font = [UIFont systemFontOfSize:20];
        _tableView.tableHeaderView = titleLabel;
    }
    return _tableView;
}

- (NSMutableArray *)dataSourceArray
{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
        
        if ([ZYTestManager shareInstance].testItemPermanentArray) {
            [_dataSourceArray addObjectsFromArray:[ZYTestManager shareInstance].testItemPermanentArray];
        }
        
        for (NSString *title in [ZYTestManager shareInstance].testItemDic.allKeys) {
            NSDictionary *dic = @{
                                  kTestTitleKey: title,
                                  kTestAutoCloseKey: [ZYTestManager shareInstance].testItemDic[title][kTestAutoCloseKey],
                                  kTestActionKey: [ZYTestManager shareInstance].testItemDic[title][kTestActionKey]
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
    NSDictionary *item = self.dataSourceArray[indexPath.row];
    // Configure the cell...
    cell.textLabel.text = item[kTestTitleKey];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item = self.dataSourceArray[indexPath.row];
    ((void(^)())item[kTestActionKey])();
    BOOL autoClose = [item[kTestAutoCloseKey] boolValue];
    if (autoClose) {
        [self closeTestTableController];
    }
}

#pragma mark - private methods
- (void)closeTestTableController
{
    [ZYSuspensionManager destroyWindowForKey:kZYTestTableControllerKey];
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

@end
