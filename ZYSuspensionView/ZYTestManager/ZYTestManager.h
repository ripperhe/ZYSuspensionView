//
//  ZYTestManager.h
//  ZYSuspensionView
//
//  GitHub https://github.com/ripperhe
//  Created by ripper on 2016/12/9.
//  Copyright © 2016年 ripper. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYTestManager;

extern NSString *const kTestTitleKey; /** The key for title */
extern NSString *const kTestAutoCloseKey; /** This determines whether to close the table automatically */
extern NSString *const kTestActionKey; /** The key for action */

@protocol ZYTestManagerDelegate <NSObject>

@optional
/**
 Custom test table header view.
 
 @param testManager login manager instance
 @return custom test table header view
 */
- (UIView *)testManagerLoginTableHeaderView:(ZYTestManager *)testManager;

@end

@interface ZYTestManager : NSObject

@property (nonatomic, weak) id<ZYTestManagerDelegate> delegate;

/** Permanent test items set by @selector(setupTestItemPermanentArray:) */
@property (nonatomic, strong, readonly) NSArray <NSDictionary *>*permanentTestItemArray;
/** Test items set by @selector(addTestItemWithTitle:action:) */
@property (nonatomic, strong, readonly) NSMutableDictionary <NSString *, NSDictionary *>*newTestItemDic;
/** Controller for displaying test items */
@property (nonatomic, weak, readonly) UIViewController *testTableViewController;


/**
 Get single object

 @return single object
 */
+ (instancetype)shareInstance;

/**
 Display test suspensionView (release mode won't show)
 */
+ (void)showSuspensionView;

/**
 Remove test suspensionView
 */
+ (void)removeSuspensionView;

/**
 Set permanent test items
 
 @param array Permanent test items
 @note If you need to use it for a long time, it is recommended to use this method
 */
+ (void)setupPermanentTestItemArray:(NSArray <NSDictionary *>*)array;

/**
 Add a single test item

 @param title title
 @param autoClose if automatically close test list after clicking
 @param action action after click
 */
+ (void)addTestItemWithTitle:(NSString *)title autoClose:(BOOL)autoClose action:(void(^)())action;


/**
 Add a single test item

 @param title title
 @param action action after click
 
 @note after click test table, the table will closex
 */
+ (void)addTestItemWithTitle:(NSString *)title action:(void(^)())action;


/**
 Close test list
 */
+ (void)closeTestTableViewController;


@end
