//
//  NSObject+ZYSuspensionView.h
//  ZYSuspensionView
//
//  Created by ripper on 16/7/20.
//  Copyright © 2016年 ripper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ZYSuspensionView)

/**
 *  懒加载的md5Key
 */
@property (nonatomic, copy, readonly) NSString *md5Key;

/**
 *  根据当前description生成md5值
 */
- (NSString *)getCurrentMd5Key;

@end
