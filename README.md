# STContacts

> **A lightweight iOS contacts manager** built on Apple's `Contacts` framework — contact permission management and data fetching with a clean, callback-based API. Supports Swift Package Manager.

[![License](https://img.shields.io/badge/license-MIT-green?style=flat)](https://github.com/i-stack/STContacts/blob/main/LICENSE)
[![Platform](https://img.shields.io/badge/platform-iOS%2013%2B-lightgrey?style=flat)](https://github.com/i-stack/STContacts)
[![Swift](https://img.shields.io/badge/Swift-5.0%20%7C%205.9-orange?style=flat-square)](https://www.swift.org)
[![SPM](https://img.shields.io/badge/SPM-supported-brightgreen?style=flat)](https://github.com/i-stack/STContacts)
[![Xcode](https://img.shields.io/badge/Xcode-12%2B-147EFB?style=flat)](https://developer.apple.com/xcode/)

**STContacts** is an open-source **iOS contacts framework** written in **Swift**, wrapping Apple's `Contacts` framework to provide contact permission management and device contact fetching based on `CNContact`.

STContacts 是一个简洁易用的 iOS 联系人管理 Swift 包，基于 Apple 的 Contacts 框架封装，提供联系人权限管理和数据获取功能。

## 📋 目录 | Table of Contents

- [特性 | Features](#features)
- [系统要求 | Requirements](#requirements)
- [安装方式 | Installation](#installation)
- [快速开始 | Quick Start](#quick-start)
  - [权限管理](#auth)
  - [获取联系人](#fetch)
- [API 文档 | API](#api)
- [注意事项 | Notes](#notes)
- [许可证 | License](#license)

<a id="features"></a>
## 🎯 特性 | Features

| 类别 | 能力 |
| --- | --- |
| 权限 | 联系人权限请求与管理 |
| 数据 | 获取设备全部联系人（`CNContact` 完整数据） |
| 状态 | 权限状态检查 |
| 接入 | Swift Package Manager 支持 |
| 健壮性 | 错误处理与异常捕获 |

<a id="installation"></a>
## 🚀 安装方式 | Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/i-stack/STContacts.git", from: "1.0.0"),
],
targets: [
    .target(
        name: "YourApp",
        dependencies: [.product(name: "STContacts", package: "STContacts")]
    )
]
```

或在 Xcode 中选择 `File ▸ Add Package Dependencies...`，输入 `https://github.com/i-stack/STContacts.git`。

```swift
import STContacts
import Contacts
```

<a id="quick-start"></a>
## ⚡ 快速开始 | Quick Start

<a id="auth"></a>
### 权限管理

```swift
// 检查权限状态
let status = STContactManager.shared.st_checkContactPermission()
switch status {
case .authorized:   print("已授权")
case .denied:       print("已拒绝")
case .restricted:   print("受限制")
case .notDetermined:print("未确定")
@unknown default:   break
}

// 请求权限并获取联系人
STContactManager.shared.st_requestContactPermission { granted, contacts, error in
    DispatchQueue.main.async {
        if granted {
            print("权限获取成功，联系人数量：\(contacts.count)")
        } else {
            print("权限被拒绝：\(error ?? "unknown")")
        }
    }
}
```

<a id="fetch"></a>
### 获取联系人

```swift
STContactManager.shared.st_fetchContactInfo { success, contacts, error in
    DispatchQueue.main.async {
        guard success else {
            print("获取联系人失败：\(error ?? "unknown")")
            return
        }
        for contact in contacts {
            print("姓名：\(contact.givenName) \(contact.familyName)")
            for phoneNumber in contact.phoneNumbers {
                print("电话：\(phoneNumber.value.stringValue)")
            }
        }
    }
}
```

<a id="api"></a>
## 📚 API 文档 | API

### `STContactManager`

- `shared: STContactManager` — 单例实例

##### `st_requestContactPermission(completion:)`
请求联系人权限并获取联系人数据。
- `completion: (Bool, [CNContact], String?) -> Void`
  - `Bool` — 是否授权成功
  - `[CNContact]` — 联系人列表
  - `String?` — 错误信息

##### `st_fetchContactInfo(completion:)`
获取联系人信息（需先确保已授权）。
- `completion: (Bool, [CNContact], String?) -> Void`

##### `st_checkContactPermission() -> CNAuthorizationStatus`
检查联系人权限状态。

<a id="notes"></a>
## ⚠️ 注意事项 | Notes

1. **隐私权限**：使用前需在 `Info.plist` 添加联系人权限说明：
   ```xml
   <key>NSContactsUsageDescription</key>
   <string>此应用需要访问您的联系人以便提供更好的服务</string>
   ```
2. **线程安全**：回调在后台线程执行，更新 UI 请切换至主线程（见上方示例）。
3. **错误处理**：始终检查回调中的成功状态与错误信息。
4. **权限变化**：权限状态可能在运行时改变，建议在每次使用前检查权限状态。

<a id="license"></a>
## 📄 许可证 | License

本项目采用 MIT 许可证，详见 [LICENSE](LICENSE)。

---

**STContacts** — a Contacts-framework wrapper for iOS & Swift. Keywords: *iOS, Swift, Contacts, CNContact, permission, address book, Swift Package Manager*.
