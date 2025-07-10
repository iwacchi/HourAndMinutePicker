# HourAndMinutePicker

iOS向けSwiftUIカスタムコンポーネント。時（Hour）と分（Minute）を無限スクロールで直感的に選択できます。

## 特徴

+ Hour（時）: 0〜23を無限スクロールでの選択が可能です。
+	Minute（分）: 0〜59を指定した刻み幅（1分／5分／10分／15分）で無限スクロールでの選択が可能です。
+	@Binding による外部状態との双方向データバインディング
+	iOS 13.0以降対応

## インストール方法

Swift Package Manager

```swift
.package(
    url: "https://github.com/iwacchi/HourAndMinutePicker.git",
    from: "0.0.3"
)
```

Xcodeの File → Add Packages… からも追加可能です。

## 使い方

### インポート

```swift
import HourAndMinutePicker
```

### 基本例

```swift:ContentView.swift
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

## サンプルアプリ

アプリ起動時にモーダルで時刻選択画面を表示し、選択結果をラベルに反映するサンプルです。

```swift:PickerExampleApp.swift
import SwiftUI
import HourAndMinutePicker

@main
struct PickerExampleApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

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
            .navigationTitle("サンプルアプリ")
            .sheet(isPresented: $showPicker) {
                VStack {
                    HourAndMinutePicker(
                        hour: $hour,
                        minute: $minute,
                        division: .by10Minute
                    )
                    .frame(height: 200)

                    Button("完了") {
                        showPicker = false
                    }
                    .padding()
                }
            }
        }
    }
}
```

## APIリファレンス

### HourAndMinutePicker

```swift:HourAndMinutePicker.swift
@available(iOS 13.0, *)
public struct HourAndMinutePicker: View {

    @Binding public var hour: Int

    @Binding public var minute: Int

    public var division: MinuteDivision

    public init(
        hour: Binding<Int>,
        minute: Binding<Int>,
        division: MinuteDivision = .by5Minute
    )

    ...

}
```

### MinuteDivision

```swift:MinuteDivision.swift
@available(iOS 13.0, *)
public enum MinuteDivision: CaseIterable {

    case by1Minute

    case by5Minute

    case by10Minute

    case by15Minute

    public var value: Int { ... }

}
```

## ライセンス

MIT License
