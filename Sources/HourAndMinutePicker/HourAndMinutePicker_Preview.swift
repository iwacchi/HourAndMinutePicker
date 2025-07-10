//
//  HourAndMinutePicker_Preview.swift
//  HourAndMinutePicker
//
//  Created by iwacchi on 2025/07/10.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
internal struct HourAndMinutePicker_Preview: PreviewProvider {
    
    internal static var previews: some View {
        HourAndMinutePicker(
            hour: .constant(12), minute: .constant(25), division: .by5Minute
        )
    }
    
}
