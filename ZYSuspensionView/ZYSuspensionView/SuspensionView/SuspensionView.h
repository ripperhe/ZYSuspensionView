//
//  SuspensionView.h
//  Latin2.0
//
//  Created by ripper on 16-02-25.
//  Copyright (c) 2016年 ripper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuspensionManager.h"

@class SuspensionView;

@protocol SuspensionViewDelegate <NSObject>
- (void)suspensionViewClick:(SuspensionView *)suspensionView;
@end


@interface SuspensionView : UIButton
@property(nonatomic,weak) id<SuspensionViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor*)color;
/**
 *  显示
 */
- (void)show;
/**
 *  移除
 */
- (void)removeFromScreen;

@end


