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
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}

extension Double {
    func lapTime(minimum: Bool = false) -> String {
        let totalSeconds = Int(self)
        let milliseconds = Int((self - Double(totalSeconds)) * 1000)
        
        // Calcular minutos e segundos
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        
        // Criar um NumberFormatter para formatar os milissegundos com três dígitos
        let millisecondsFormatter = NumberFormatter()
        millisecondsFormatter.minimumIntegerDigits = 3
        
        // Formatando a string de saída
        let formattedMilliseconds = millisecondsFormatter.string(from: NSNumber(value: milliseconds)) ?? "000"
        if minimum && minutes == 0 {
            return String(format: "%02d:%@", seconds, formattedMilliseconds)
        }
        return String(format: "%d:%02d:%@", minutes, seconds, formattedMilliseconds)
    }
}
