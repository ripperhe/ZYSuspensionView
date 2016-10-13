//
//  ZYSuspensionView.h
//  ZYSuspensionView
//
//  Created by ripper on 16-02-25.
//  Copyright (c) 2016年 ripper. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYSuspensionView;

@protocol ZYSuspensionViewDelegate <NSObject>
- (void)suspensionViewClick:(ZYSuspensionView *)suspensionView;
@end


@interface ZYSuspensionView : UIButton
@property(nonatomic,weak) id<ZYSuspensionViewDelegate> delegate;

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


