//
//  Utility.swift
//  F1Follow
//
//  Created by Emanuel on 22/07/24.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let rgb: UInt64 = UInt64(hex, radix: 16) ?? 0
        
        let redValue = Double(rgb & 0xFF0000) / 255.0
        let greenValue = Double(rgb & 0xFF00) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}
