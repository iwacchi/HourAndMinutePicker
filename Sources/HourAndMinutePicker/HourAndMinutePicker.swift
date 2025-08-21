// The Swift Programming Language
// https://docs.swift.org/swift-book

// HourAndMinutePicker.swift
// HourAndMinutePicker
//
// Created by iwacchi on 2025/07/10
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
public struct HourAndMinutePicker: View {
    
    @Binding
    var hour: Int
    
    @Binding
    var minute: Int
    
    var division: MinuteDivision
    
    var isMinuteRoundUp: Bool
    
    public init(
        hour: Binding<Int>,
        minute: Binding<Int>,
        division: MinuteDivision = .by5Minute,
        isMinuteRoundUp: Bool = true
    ) {
        self._hour = hour
        self._minute = minute
        self.division = division
        self.isMinuteRoundUp = isMinuteRoundUp
    }
    
    public var body: some View {
        ZStack {
            HourAndMinutePickerUIView(
                hour: $hour,
                minute: $minute,
                division: division,
                isMinuteRoundUp: isMinuteRoundUp
            )
            Text(":")
                .fontWeight(.bold)
        }
    }
    
}
