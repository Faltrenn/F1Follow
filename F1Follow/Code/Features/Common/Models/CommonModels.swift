//
//  CommonModels.swift
//  F1Follow
//
//  Created by Emanuel on 19/07/24.
//

import Foundation
import SwiftUI

struct Driver: Codable {
    let broadcastName: String
    let countryCode: String
    let driverNumber: Int
    let firstName: String
    let fullName: String
    let headshotUrl: String
    let lastName: String
    let nameAcronym: String
    let teamColour: String
    let teamName: String
    
    enum CodingKeys: String, CodingKey {
        case broadcastName  = "broadcast_name"
        case countryCode   = "country_code"
        case driverNumber  = "driver_number"
        case firstName     = "first_name"
        case fullName      = "full_name"
        case headshotUrl   = "headshot_url"
        case lastName      = "last_name"
        case nameAcronym   = "name_acronym"
        case teamColour    = "team_colour"
        case teamName      = "team_name"
    }
}


extension Color {
    init(hex: String) {
        let rgb: UInt64 = UInt64(hex, radix: 16)!
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}
