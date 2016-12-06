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
/** 点击悬浮球的回调 */
- (void)suspensionViewClick:(ZYSuspensionView *)suspensionView;
@end

typedef NS_ENUM(NSUInteger, ZYSuspensionViewLeanType) {
    /** 仅可停留在左、右 */
    ZYSuspensionViewLeanTypeHorizontal,
    /** 可停留在上、下、左、右 */
    ZYSuspensionViewLeanTypeEachSide
};


@interface ZYSuspensionView : UIButton

/** 代理 */
@property (nonatomic, weak) id<ZYSuspensionViewDelegate> delegate;
/** 倚靠类型 default is ZYSuspensionViewLeanTypeHorizontal */
@property (nonatomic, assign) ZYSuspensionViewLeanType leanType;


+ (instancetype)defaultSuspensionViewWithDelegate:(id<ZYSuspensionViewDelegate>)delegate;

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor*)color delegate:(id<ZYSuspensionViewDelegate>)delegate;

/**
 *  显示
 */
- (void)show;

/**
 *  移除
 */
- (void)removeFromScreen;

@end


