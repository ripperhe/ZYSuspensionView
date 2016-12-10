//
//  ZYTestManager.h
//  ZYSuspensionView
//
//  Created by ripper on 2016/12/9.
//  Copyright © 2016年 ripper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYTestManager : NSObject

/** 通过 @selector(addTestItemWithTitle:action:) 添加的所有测试条目 */
@property (nonatomic, strong, readonly) NSMutableDictionary *testItemDic;

/**
 单例对象

 @return 单例对象
 */
+ (instancetype)shareInstance;


/**
 显示测试按钮 release模式自动不显示
 */
+ (void)showSuspensionView;

/**
 添加测试条目

 @param title 标题
 @param action 行为
 */
+ (void)addTestItemWithTitle:(NSString *)title action:(void(^)())action;

@end
