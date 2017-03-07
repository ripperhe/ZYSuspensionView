//
//  ViewController.m
//  ZYSuspensionViewDemo
//
//  Created by ripper on 16/8/22.
//  Copyright © 2016年 ripper. All rights reserved.
//

#import "ViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSourceArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    __weak typeof(self) weakSelf = self;
    self.dataSourceArray = @[
                             @{
                                 @"title":@"SuspensionView",
                                 @"action":^{
                                     ViewController1 *vc1 = [ViewController1 new];
                                     [weakSelf.navigationController pushViewController:vc1 animated:YES];
                                 }},
                             @{
                                 @"title":@"TestManager",
                                 @"action":^{
                                     ViewController2 *vc2 = [ViewController2 new];
                                     [weakSelf.navigationController pushViewController:vc2 animated:YES];
                                 }},
                             ];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *item = self.dataSourceArray[indexPath.row];
    // Configure the cell...
    cell.textLabel.text = item[@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].selected = ![tableView cellForRowAtIndexPath:indexPath].selected;
    NSDictionary *item = self.dataSourceArray[indexPath.row];
    ((void(^)())item[@"action"])();
}


@end
