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
 *  Lazy loading MD5 string
 */
@property (nonatomic, copy, readonly) NSString *md5Key;

/**
 *  Generate MD5 values based on current description
 */
- (NSString *)getCurrentMd5Key;

@end
