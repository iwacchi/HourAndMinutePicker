//
//  HourAndMinutePickerUIView.swift
//  HourAndMinutePicker
//
//  Created by iwacchi on 2025/07/10.
//

import Foundation
import UIKit
import SwiftUI

@available(iOS 13.0, *)
internal struct HourAndMinutePickerUIView: UIViewRepresentable {
    
    @Binding
    var hour: Int
    
    @Binding
    var minute: Int
    
    var division: MinuteDivision
    
    var isMinuteRoundUp: Bool
    
    internal init(
        hour: Binding<Int>,
        minute: Binding<Int>,
        division: MinuteDivision,
        isMinuteRoundUp: Bool
    ) {
        self._hour = hour
        self._minute = minute
        self.division = division
        self.isMinuteRoundUp = isMinuteRoundUp
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(
            parent: self, division: division
        )
    }
    
    func makeUIView(context: Context) -> UIPickerView {
        let pickerView = UIPickerView(frame: .zero)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.delegate = context.coordinator
        pickerView.dataSource = context.coordinator
        pickerView.selectRow(24 * 50 + hour, inComponent: 0, animated: false)
        var minute = (60 / division.value) * 50 + minute / division.value
        if isMinuteRoundUp {
            minute = minute + 1
            let minutes: [Int] = HourAndMinutePickerUIView.getMinutes(division: division)
            self.minute = minutes[minute]
        }
        pickerView.selectRow(
            minute,
            inComponent: 1,
            animated: false
        )
        Task {
            await MainActor.run {
                pickerView.reloadComponent(1)
            }
        }
        return pickerView
    }
    
    func updateUIView(_ uiView: UIPickerView, context: Context) {
        if context.coordinator.division == division {
            return
        }
        context.coordinator.division = division
        context.coordinator.minutes = HourAndMinutePickerUIView.getMinutes(division: division)
        uiView.reloadComponent(1)
        uiView.selectRow(
            (60 / division.value) * 50 + minute / division.value,
            inComponent: 1,
            animated: false
        )
        Task {
            await MainActor.run {
                uiView.reloadComponent(1)
                context.coordinator.pickerView(uiView, didSelectRow: 0, inComponent: 1)
            }
        }
    }
    
    final class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        
        var parent: HourAndMinutePickerUIView
        
        let hours: [Int]
        
        var division: MinuteDivision
        
        var minutes: [Int]
        
        init(
            parent: HourAndMinutePickerUIView,
            division: MinuteDivision
        ) {
            self.parent = parent
            self.hours = Array.init(repeating: 0 ... 23, count: 100).flatMap { $0 }
            self.division = division
            let minutes: [Int] = HourAndMinutePickerUIView.getMinutes(division: division)
            self.minutes = minutes
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            2
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if component == 0 {
                return hours.count
            } else {
                return minutes.count
            }
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let selectedHour: Int = hours[pickerView.selectedRow(inComponent: 0)]
            let selectedMinute: Int = minutes[pickerView.selectedRow(inComponent: 1)]
            parent.hour = selectedHour
            parent.minute = selectedMinute
            pickerView.reloadComponent(1)
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if component == 0 {
                return "\(hours[row])"
            } else {
                let minute = minutes[row]
                if minute < 10 {
                    return "0\(minute)"
                } else {
                    return "\(minute)"
                }
            }
        }
        
    }
    
    internal static func getMinutes(division: MinuteDivision) -> [Int] {
        Array
            .init(repeating: 0 ... (60 / division.value) - 1, count: 100)
            .flatMap { $0 }
            .map { $0 * division.value }
    }
    
}
