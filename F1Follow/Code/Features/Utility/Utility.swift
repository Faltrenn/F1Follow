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
        var milliseconds = String(self).split(separator: ".")[1]
        let diff = 3 - milliseconds.count
        if diff > 0 {
            milliseconds += String(repeating: "0", count: diff)
        } else {
            milliseconds = milliseconds.prefix(3)
        }
        
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        
        if minimum && minutes == 0 {
            return "\(seconds):\(milliseconds)"
        }
        return "\(minutes):\(seconds):\(milliseconds)"
    }
}

func fetch<T: Codable>(link: String, type: T.Type, completion: @escaping (T) -> Void) {
    if let url = URL(string: link) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, error == nil {
                DispatchQueue.main.async {
                    do {
                        completion(try JSONDecoder().decode(T.self, from: data))
                    } catch {
                        print(error)
                    }
                }
            }
        }.resume()
    } else {
        print("Link inválido!")
    }
}
