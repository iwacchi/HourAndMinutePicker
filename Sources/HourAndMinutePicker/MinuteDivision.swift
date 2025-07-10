//
//  MinuteDivision.swift
//  HourAndMinutePicker
//
//  Created by iwacchi on 2025/07/10.
//

import Foundation

@available(iOS 13.0, *)
public enum MinuteDivision: CaseIterable {
    
    case by1Minute
    
    case by5Minute
    
    case by10Minute
    
    case by15Minute
    
    var value: Int {
        switch self {
        case .by1Minute:
            return 1
        case .by5Minute:
            return 5
        case .by10Minute:
            return 10
        case .by15Minute:
            return 15
        }
    }
    
}
