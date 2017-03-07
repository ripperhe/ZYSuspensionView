//
//  ZYSuspensionManager.h
//  ZYSuspensionView
//
//  GitHub https://github.com/ripperhe
//  Created by ripper on 16/7/19.
//  Copyright © 2016年 ripper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZYSuspensionManager : NSObject

+ (instancetype)shared;

/**
 *  根据key值取window
 *
 *  @param key key
 *
 *  @return window
 */
+ (UIWindow *)windowForKey:(NSString *)key;

/**
 *  持有一个window并设置key值
 *
 *  @param window window
 *  @param key    key值
 */
+ (void)saveWindow:(UIWindow *)window forKey:(NSString *)key;

/**
 *  销毁一个window
 *
 *  @param key       根据key值
 */
+ (void)destroyWindowForKey:(NSString *)key;

/**
 *  销毁当前所有window
 */
+ (void)destroyAllWindow;

@end
