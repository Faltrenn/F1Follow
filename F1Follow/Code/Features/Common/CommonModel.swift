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
    let fullName: String
    let headshotURL: String
    let nameAcronym: String
    let teamColour: String
    let teamName: String

    enum CodingKeys: String, CodingKey {
        case broadcastName  = "broadcast_name"
        case countryCode    = "country_code"
        case driverNumber   = "driver_number"
        case fullName       = "full_name"
        case headshotURL    = "headshot_url"
        case nameAcronym    = "name_acronym"
        case teamColour     = "team_colour"
        case teamName       = "team_name"
    }
}
