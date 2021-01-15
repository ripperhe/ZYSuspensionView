# ZYSuspensionView

⚠️ The repository has a new address and a new name. [点击跳转 🚀](https://github.com/ripperhe/Debugo)

⚠️ 本仓库有了一个新的地址和新的名字。 [点击跳转 🚀](https://github.com/ripperhe/Debugo)


[![Version](https://img.shields.io/cocoapods/v/ZYSuspensionView.svg?style=flat)](http://cocoapods.org/pods/ZYSuspensionView)
[![License](https://img.shields.io/cocoapods/l/ZYSuspensionView.svg?style=flat)](http://cocoapods.org/pods/ZYSuspensionView)
[![Platform](https://img.shields.io/cocoapods/p/ZYSuspensionView.svg?style=flat)](http://cocoapods.org/pods/ZYSuspensionView)

[博客介绍](http://ripperhe.com/2017/03/10/suspension-view/)

## Example

If you want to run demo, download the project can be run directly.

![](https://raw.githubusercontent.com/ripperhe/Resource/master/20170310/testmanager.gif)
![](https://raw.githubusercontent.com/ripperhe/Resource/master/20170310/loginmanager.gif)

## Requirements

* iOS 8.0 or later

## Installation

ZYSuspensionView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ZYSuspensionView"
```

Only install SuspensionView

```ruby
pod "ZYSuspensionView/SuspensionView"
```
Install SuspensionView + TestManager

```ruby
pod "ZYSuspensionView/TestManager"
```

Install SuspensionView + LoginManager

```ruby
pod "ZYSuspensionView/LoginManager"
```

## Usage

### SuspensionView

Create and show a suspensionView

```objc
ZYSuspensionView *susView = [[ZYSuspensionView alloc] initWithFrame:CGRectMake(- 50.0 / 6, 200, 50, 50)
                                                           color:color
                                                        delegate:self];
[susView show];
```

### TestManager

Add a test item. You can add test items anywhere.

```objc
[ZYTestManager addTestItemWithTitle:@"new item" autoClose:YES action:^{
    // click new item : do something ~~~~~~~~~~
}];
```

### LoginManager

LoginManager help you save and get account password.

When you log in successfully, please send ZYLoginSuccess Notification with account info. The susView will be removed, and the account info will be saved.

```objc
[[NSNotificationCenter defaultCenter] postNotificationName:@"kZYLoginSuccessNotificationKey"
                                                    object:@{account:password}];
```

When you log out successfully, please send ZYLogoutSuccess Notification. The susView will be show again.

```objc
[[NSNotificationCenter defaultCenter] postNotificationName:@"kZYLogoutSuccessNotificationKey"
                                                    object:nil];
```


## Author

ripper, ripperhe@qq.com

## License

ZYSuspensionView is available under the MIT license. See the LICENSE file for more info.
