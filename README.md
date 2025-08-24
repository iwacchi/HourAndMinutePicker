# HourAndMinutePicker

[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![iOS](https://img.shields.io/badge/iOS-13.0%2B-blue.svg)](https://developer.apple.com/ios/)
[![Swift](https://img.shields.io/badge/Swift-5.0%2B-orange.svg)](https://swift.org/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**HourAndMinutePicker** は、SwiftUIで作られたiOS向けカスタムコンポーネントです。時（Hour）と分（Minute）を無限スクロールで直感的に選択できるピッカーです。

## ✨ 特徴

- 🕐 **時（Hour）**: 0〜23時を無限スクロールで選択可能
- ⏰ **分（Minute）**: 0〜59分を指定した刻み幅で選択可能
  - 1分刻み
  - 5分刻み（デフォルト）
  - 10分刻み
  - 15分刻み
- 🔄 **双方向バインディング**: `@Binding`による外部状態との連携
- 📱 **iOS 13.0以降対応**
- 🎨 **SwiftUI ネイティブ**

## 📦 インストール

### Swift Package Manager

#### Xcodeから追加する場合

1. Xcodeで **File → Add Packages…** を選択
1. 以下のURLを入力: `https://github.com/iwacchi/HourAndMinutePicker.git`
1. **Add Package** をクリック

#### Package.swiftに直接追加する場合

```swift
dependencies: [
    .package(
        url: "https://github.com/iwacchi/HourAndMinutePicker.git",
        from: "0.0.3"
    )
]
```

## 🚀 基本的な使い方

### 1. インポート

```swift
import HourAndMinutePicker
```

### 2. 最小限の実装

```swift
struct ContentView: View {
    @State private var selectedHour: Int = 8
    @State private var selectedMinute: Int = 30
    
    var body: some View {
        VStack(spacing: 20) {
            HourAndMinutePicker(
                hour: $selectedHour,
                minute: $selectedMinute
            )
            .frame(height: 180)
            
            Text("選択時刻: \(selectedHour)時 \(String(format: "%02d", selectedMinute))分")
                .font(.headline)
        }
        .padding()
    }
}
```

### 3. 分の刻み幅を指定

```swift
HourAndMinutePicker(
    hour: $selectedHour,
    minute: $selectedMinute,
    division: .by10Minute  // 10分刻み
)
```

## 📋 詳細な使用例

### モーダル表示での時刻選択

```swift
import SwiftUI
import HourAndMinutePicker

struct MainView: View {
    @State private var showPicker = false
    @State private var hour = 12
    @State private var minute = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text("現在の時刻: \(hour)時 \(String(format: "%02d", minute))分")
                    .font(.largeTitle)
                
                Button("時刻を選択") {
                    showPicker.toggle()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .navigationTitle("時刻選択アプリ")
            .sheet(isPresented: $showPicker) {
                TimePickerModal(
                    hour: $hour,
                    minute: $minute,
                    showPicker: $showPicker
                )
            }
        }
    }
}

struct TimePickerModal: View {
    @Binding var hour: Int
    @Binding var minute: Int
    @Binding var showPicker: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                HourAndMinutePicker(
                    hour: $hour,
                    minute: $minute,
                    division: .by5Minute
                )
                .frame(height: 200)
                
                Spacer()
            }
            .navigationTitle("時刻選択")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("キャンセル") {
                        showPicker = false
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("完了") {
                        showPicker = false
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
}
```

## 🔧 API リファレンス

### HourAndMinutePicker

```swift
public struct HourAndMinutePicker: View {
    public init(
        hour: Binding<Int>,
        minute: Binding<Int>,
        division: MinuteDivision = .by5Minute
    )
}
```

#### パラメーター

- **hour**: `Binding<Int>` - 選択された時（0-23）
- **minute**: `Binding<Int>` - 選択された分（0-59、刻み幅による）
- **division**: `MinuteDivision` - 分の刻み幅（デフォルト: `.by5Minute`）

### MinuteDivision

```swift
public enum MinuteDivision: CaseIterable {
    case by1Minute   // 1分刻み
    case by5Minute   // 5分刻み（デフォルト）
    case by10Minute  // 10分刻み
    case by15Minute  // 15分刻み
}
```

## 💡 ヒント

### 推奨される高さ

ピッカーの可読性を最適にするため、`frame(height: 180)` 以上の高さを設定することをお勧めします。

### 初期値の設定

現在時刻を初期値に設定したい場合：

```swift
@State private var selectedHour: Int = Calendar.current.component(.hour, from: Date())
@State private var selectedMinute: Int = Calendar.current.component(.minute, from: Date())
```

### 時刻フォーマット

表示用の時刻文字列を作成する場合：

```swift
var timeString: String {
    return "\(selectedHour):\(String(format: "%02d", selectedMinute))"
}
```

## 📱 動作環境

- iOS 13.0以降
- Swift 5.0以降
- Xcode 11以降

## 🤝 コントリビューション

バグレポートや機能リクエストは [Issues](https://github.com/iwacchi/HourAndMinutePicker/issues) からお気軽にどうぞ。

プルリクエストも歓迎です！

## 📄 ライセンス

このプロジェクトは [MIT License](LICENSE) のもとで公開されています。

-----

**作者**: [iwacchi](https://github.com/iwacchi)

何かご質問がございましたら、お気軽にお問い合わせください！