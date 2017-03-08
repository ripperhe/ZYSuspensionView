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

extern NSString *const kZYLoginSuccessNotificationKey;
extern NSString *const kZYLogoutSuccessNotificationKey;

@protocol ZYLoginManagerDelegate <NSObject>

- (void)loginManager:(ZYLoginManager *)loginManager loginWithAccout:(NSString *)account password:(NSString *)password;

@end



@interface ZYLoginManager : NSObject

@property (nonatomic, weak) id<ZYLoginManagerDelegate> delegate;

/** Permanent account infos set by @selector(setupTestItemPermanentArray:) */
@property (nonatomic, strong, readonly) NSDictionary <NSString *, NSString *>*permanentAccountInfoDic;
@property (readonly) NSDictionary <NSString *, NSString *>*newAccountInfoDic;
/** Controller for displaying account infos */
@property (nonatomic, weak, readonly) UIViewController *loginTableViewController;

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
 Set permanent account infos

 @param infoDic key is account, value is password
 @note If you need to use it for a long time, it is recommended to use this method
 */
+ (void)setupPermanentAccountInfoDic:(NSDictionary <NSString *, NSString *>*)infoDic;

+ (void)removeSuspensionViewAndAddAccount:(NSString *)account password:(NSString *)password;

+ (void)closeLoginTableViewController;

+ (NSString *)accountInfoPlistPath;

@end
