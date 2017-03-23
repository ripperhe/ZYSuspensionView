//
//  ZYSuspensionView.h
//  ZYSuspensionView
//
//  GitHub https://github.com/ripperhe
//  Created by ripper on 16-02-25.
//  Copyright (c) 2016年 ripper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYSuspensionContainer : UIWindow
@end

@interface ZYSuspensionViewController : UIViewController
@end

@class ZYSuspensionView;
@protocol ZYSuspensionViewDelegate <NSObject>
/** callback for click on the ZYSuspensionView */
- (void)suspensionViewClick:(ZYSuspensionView *)suspensionView;
@end

typedef NS_ENUM(NSUInteger, ZYSuspensionViewLeanType) {
    /** Can only stay in the left and right */
    ZYSuspensionViewLeanTypeHorizontal,
    /** Can stay in the upper, lower, left, right */
    ZYSuspensionViewLeanTypeEachSide
};

@interface ZYSuspensionView : UIButton

/** delegate */
@property (nonatomic, weak) id<ZYSuspensionViewDelegate> delegate;
/** lean type, default is ZYSuspensionViewLeanTypeHorizontal */
@property (nonatomic, assign) ZYSuspensionViewLeanType leanType;


/**
 Create a default susView

 @param delegate delegate for susView
 @return obj
 */
+ (instancetype)defaultSuspensionViewWithDelegate:(id<ZYSuspensionViewDelegate>)delegate;

/** Get the suggest x with width */
+ (CGFloat)suggestXWithWidth:(CGFloat)width;

/**
 Create a susView

 @param frame frame
 @param color background color
 @param delegate delegate for susView
 @return obj
 */
- (instancetype)initWithFrame:(CGRect)frame color:(UIColor*)color delegate:(id<ZYSuspensionViewDelegate>)delegate;

/**
 *  Show
 */
- (void)show;

/**
 *  Remove and dealloc
 */
- (void)removeFromScreen;

@end


