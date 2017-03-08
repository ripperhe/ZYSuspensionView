//
//  ZYLoginManager.h
//  ZYSuspensionViewDemo
//
//  GitHub https://github.com/ripperhe
//  Created by ripper on 2017/3/7.
//  Copyright © 2017年 ripper. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYLoginManager;

/** The notification name for login success, send the account information by the notification, notification.object is a dictionary, the key is account and the value is password */
extern NSString *const kZYLoginSuccessNotificationKey;
/** The notification name for logout success */
extern NSString *const kZYLogoutSuccessNotificationKey;

@protocol ZYLoginManagerDelegate <NSObject>

/**
 Tell login manager how to login.This method must be implemented.

 @param loginManager login manager instance
 @param account account
 @param password password
 */
- (void)loginManager:(ZYLoginManager *)loginManager loginWithAccout:(NSString *)account password:(NSString *)password;

@optional

/**
 Custom login table header view.

 @param loginManager login manager instance
 @return custom account info table header view
 */
- (UIView *)loginManagerLoginTableHeaderView:(ZYLoginManager *)loginManager;

@end


@interface ZYLoginManager : NSObject

@property (nonatomic, weak) id<ZYLoginManagerDelegate> delegate;

/** Permanent account infos set by @selector(setupTestItemPermanentArray:) */
@property (nonatomic, strong, readonly) NSDictionary <NSString *, NSString *>*permanentAccountInfoDic;
/** New login account */
@property (readonly) NSDictionary <NSString *, NSString *>*newAccountInfoDic;
/** Controller for displaying account infos */
@property (nonatomic, weak, readonly) UIViewController *loginTableViewController;

/**
 Get single object
 
 @return single object
 */
+ (instancetype)shareInstance;

/**
 Display login suspensionView (release mode won't show)
 */
+ (void)showSuspensionView;

/**
 Remove login suspensionView
 */
+ (void)removeSuspensionView;

/**
 Set permanent account infos

 @param infoDic key is account, value is password
 @note If you need to use it for a long time, it is recommended to use this method
 */
+ (void)setupPermanentAccountInfoDic:(NSDictionary <NSString *, NSString *>*)infoDic;

/**
 Remove login suspensionView, and save account info

 @param account account string
 @param password password string
 */
+ (void)removeSuspensionViewAndAddAccount:(NSString *)account password:(NSString *)password;

/**
 Close login table view
 */
+ (void)closeLoginTableViewController;

/**
 Get account infos' plist path

 @return path
 */
+ (NSString *)accountInfoPlistPath;

/**
 Get current viewController for one window

 @param window target window
 @return current viewController
 */
+ (UIViewController *)currentViewControllerWithWindow:(UIWindow *)window;

@end
