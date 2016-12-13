# ZYSuspensionView

[![CI Status](http://img.shields.io/travis/ripper/ZYSuspensionView.svg?style=flat)](https://travis-ci.org/ripper/ZYSuspensionView)
[![Version](https://img.shields.io/cocoapods/v/ZYSuspensionView.svg?style=flat)](http://cocoapods.org/pods/ZYSuspensionView)
[![License](https://img.shields.io/cocoapods/l/ZYSuspensionView.svg?style=flat)](http://cocoapods.org/pods/ZYSuspensionView)
[![Platform](https://img.shields.io/cocoapods/p/ZYSuspensionView.svg?style=flat)](http://cocoapods.org/pods/ZYSuspensionView)

## Example

如果想运行demo，下载之后，直接运行工程即可。

## Requirements

* iOS 8.0 or later

## Installation

ZYSuspensionView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ZYSuspensionView"
```

如果仅仅只想集成悬浮球，可以pod子仓库

```ruby
pod "ZYSuspensionView/SuspensionView"
```

## How To Use

* 悬浮球和测试组件配合使用

```objc
// 显示一个默认的悬浮球
[ZYTestManager showSuspensionView];
    
// 设置常驻的测试条目
NSArray *baseArray = @[
                       @{
                           kTestTitleKey: @"item1",
                           kTestAutoCloseKey: @YES,
                           kTestActionKey: ^{
                               NSLog(@"click item1 : do something ~~~~~");
                           }
                           },
                       @{
                           kTestTitleKey:@"item2",
                           kTestAutoCloseKey: @NO,
                           kTestActionKey:^{
                               NSLog(@"click item2 : do something ~~~~~");
                           }
                           },
                       ];
[ZYTestManager setupTestItemPermanentArray:baseArray];
    
// 添加一个测试条目 (注意blcok的引用问题，如果需要在block中使用self，最好传入__weak)
[ZYTestManager addTestItemWithTitle:@"new item" autoClose:YES action:^{
    NSLog(@"click new item : do something ~~~~~~~~~~");
}];
```

* 仅仅使用悬浮球

```objc
// 仅仅创建一个悬浮球，自行实现点击的代理方法
ZYSuspensionView *sus = [[ZYSuspensionView alloc] initWithFrame:CGRectMake(- 50.0 / 6, 200, 50, 50)
                                                           color:[UIColor greenColor]
                                                        delegate:self];
sus.leanType = ZYSuspensionViewLeanTypeEachSide;
[sus setTitle:@"测试2" forState:UIControlStateNormal];
[sus show];
```

## Author

ripper, ripperhe@qq.com

## License

ZYSuspensionView is available under the MIT license. See the LICENSE file for more info.
