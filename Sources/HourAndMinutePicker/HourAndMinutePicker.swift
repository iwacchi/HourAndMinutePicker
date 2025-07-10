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
    
    init(
        hour: Binding<Int>,
        minute: Binding<Int>,
        division: MinuteDivision = .by5Minute
    ) {
        self._hour = hour
        self._minute = minute
        self.division = division
    }
    
    public var body: some View {
        ZStack {
            HourAndMinutePicker(
                hour: $hour,
                minute: $minute,
                division: division
            )
            Text(":")
                .fontWeight(.bold)
        }
    }
    
}
