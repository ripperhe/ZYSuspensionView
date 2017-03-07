//
//  ZYTestManager.h
//  ZYSuspensionView
//
//  GitHub https://github.com/ripperhe
//  Created by ripper on 2016/12/9.
//  Copyright © 2016年 ripper. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIViewController;

extern NSString *const kTestTitleKey;
extern NSString *const kTestAutoCloseKey;
extern NSString *const kTestActionKey;

@interface ZYTestManager : NSObject

/** Permanent test items set by @selector(setupTestItemPermanentArray:) */
@property (nonatomic, strong, readonly) NSArray <NSDictionary *>*testItemPermanentArray;
/** Test items set by @selector(addTestItemWithTitle:action:) */
@property (nonatomic, strong, readonly) NSMutableDictionary *testItemDic;
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
 Set ermanent test items（If you need to use it for a long time, it is recommended to use this method）

 @param array Permanent test items
 */
+ (void)setupTestItemPermanentArray:(NSArray <NSDictionary *>*)array;

/**
 Add a single test item

 @param title title
 @param autoClose if automatically close test list after clicking
 @param action action after click
 */
+ (void)addTestItemWithTitle:(NSString *)title autoClose:(BOOL)autoClose action:(void(^)())action;

/**
 Close test list
 */
+ (void)closeTestTableViewController;


@end
