# TPNOperaSDKAdapter

[![Version](https://img.shields.io/cocoapods/v/TPNOperaSDKAdapter.svg?style=flat)](https://cocoapods.org/pods/TPNOperaSDKAdapter)
[![Platform](https://img.shields.io/cocoapods/p/TPNOperaSDKAdapter.svg?style=flat)](https://cocoapods.org/pods/TPNOperaSDKAdapter)
[![Language](https://img.shields.io/badge/language-Objective--C-orange.svg)](https://developer.apple.com/objective-c/)

**TPNOperaSDKAdapter** 是 Opera Ads SDK 的 **TopOn (AnyThink)** 聚合适配器。
通过集成此适配器，您可以在 TopOn 的聚合瀑布流（Waterfall）或 Bidding 系统中加载并展示 Opera 的广告资源，从而最大化您的变现收益。

---

## 📋 功能特性

- [x] 支持 TopOn 自定义 Adapter 接入
- [x] 支持 Native（原生）、Banner、Interstitial、Rewarded广告格式
- [x] 自动处理 Opera SDK 的状态检测与 Mediation 参数注入
- [x] 支持 CocoaPods 一键集成

## 🛠 安装指南

### 使用 CocoaPods (推荐)

在您的项目的 `Podfile` 中添加以下代码：

```ruby
source '[https://github.com/CocoaPods/Specs.git]'

target 'YourProjectTarget' do
    # 添加 TopOn 主 SDK (如果没有)
    pod 'TPNiOS','6.4.93'

    # 添加 Opera 聚合适配器
    pod 'TPNOperaSDKAdapter'
end
运行安装命令：

Bash
pod install
🚀 快速开始
1. 初始化 SDK (Required)

重要提示：Opera SDK 的初始化必须在宿主 App 的 AppDelegate 中完成。Adapter 内部会等待初始化成功后再进行广告加载，但不会主动发起初始化。

请在 AppDelegate.m 中引入头文件并添加以下初始化代码：

Objective-C
#import "AppDelegate.h"
// 引入 Opera SDK 头文件
#import <OpAdxSdk/OpAdxSDK.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // 初始化 Opera Ads SDK
    [self initOpAdxSDK];

    // 初始化 TopOn SDK (请确保 TopOn 也在此时或之后初始化)
    // [ATAPI integrationChecking];
    // [[ATAPI sharedInstance] startWithAppID:@"YOUR_TOPON_APPID" appKey:@"YOUR_TOPON_APPKEY" error:nil];

    return YES;
}

// Opera SDK 初始化方法
- (void)initOpAdxSDK {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 请替换为您在 Opera 后台申请的 ApplicationId 和 iOSAppId
        NSString *applicationId = @"YOUR_OPERA_APPLICATION_ID";
        NSString *iOSAppId = @"YOUR_IOS_APP_ID"; // 您的iOS应用Id

        OpAdxSdkInitConfig *initConfig = [OpAdxSdkInitConfig createWithApplicationId:applicationId
                                                                            iOSAppId:iOSAppId
                                                                       publisherName:nil];

        // 初始化 OpAdxSDK
        [OpAdxSDK initializeWithConfig:initConfig
                             onSuccess:^{
            NSLog(@"[OpAdxSDK] initializeWithConfig onSuccess");
        }
                               onError:^(NSError *error) {
            NSLog(@"[OpAdxSDK] initializeWithConfig error %@", error);
        }];
    });
}

@end
2. TopOn 后台配置

要在 TopOn 聚合管理后台中启用 Opera 广告源，请按照以下步骤添加 Custom Network (自定义广告平台)：

登录 TopOn 开发者后台。

进入 Network -> Custom Network。

添加一个新的自定义广告源，并填写以下 Adapter 类名信息：

广告类型 (Ad Type)    Adapter 类名 (Class Name)
Native (原生广告)    OpAdxToponNativeAdapter
注意: serverInfo 中的参数（如 slot_id）将透传给 Adapter，请确保在 TopOn 后台配置的参数键值与 Opera 提供的广告位 ID 对应。

⚠️ 常见问题 (FAQ)
Q: 为什么广告加载失败，提示 "OpAdx SDK not initialized"? A: 请检查您是否在 AppDelegate 中正确调用了 [OpAdxSDK initializeWithConfig:...]。Adapter 依赖宿主 App 完成 SDK 的初始化。

Q: 需要手动设置 Mediation Provider 吗？ A: 不需要。TPNOperaSDKAdapter 会在检测到 SDK 初始化成功后，自动注入 TopOn 的 Mediation 标识，您只需关注业务层的初始化即可。
```
