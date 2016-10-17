//
//  ZYSuspensionManager.h
//  ZYSuspensionView
//
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
- (UIWindow *)windowForKey:(NSString *)key;
/**
 *  持有一个window并设置key值
 *
 *  @param window window
 *  @param key    key值
 */
- (void)saveWindow:(UIWindow *)window forKey:(NSString *)key;
/**
 *  销毁一个window
 *
 *  @param key       根据key值
 *  @param newWindow 手动指定一个keyWindow，一般情况不需要手动指定，系统自动会变换
 */
- (void)destroyWindowForKey:(NSString *)key newKeyWindow:(UIWindow *)newWindow;
/**
 *  销毁当前所有window
 */
- (void)destroyAllWindow;

@end
