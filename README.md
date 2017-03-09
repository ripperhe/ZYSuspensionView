# ZYSuspensionView

[![CI Status](http://img.shields.io/travis/ripper/ZYSuspensionView.svg?style=flat)](https://travis-ci.org/ripper/ZYSuspensionView)
[![Version](https://img.shields.io/cocoapods/v/ZYSuspensionView.svg?style=flat)](http://cocoapods.org/pods/ZYSuspensionView)
[![License](https://img.shields.io/cocoapods/l/ZYSuspensionView.svg?style=flat)](http://cocoapods.org/pods/ZYSuspensionView)
[![Platform](https://img.shields.io/cocoapods/p/ZYSuspensionView.svg?style=flat)](http://cocoapods.org/pods/ZYSuspensionView)

## Example

If you want to run demo, download the project can be run directly.

![](http://ojt802f2b.bkt.clouddn.com/SuspensionView.gif)![](http://ojt802f2b.bkt.clouddn.com/TestManager.gif)![](http://ojt802f2b.bkt.clouddn.com/LoginManager.gif)

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

## How To Use

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
