//
//  MeetingsModel.swift
//  F1Follow
//
//  Created by Emanuel on 28/07/24.
//

import Foundation

struct Meeting: Codable {
    let circuitKey: Int
    let circuitShortName, countryCode: String
    let countryKey: Int
    let location: String
    let meetingKey: Int
    let meetingOfficialName: String
    let year: Int

    enum CodingKeys: String, CodingKey {
        case circuitKey = "circuit_key"
        case circuitShortName = "circuit_short_name"
        case countryCode = "country_code"
        case countryKey = "country_key"
        case location
        case meetingKey = "meeting_key"
        case meetingOfficialName = "meeting_official_name"
        case year
    }
}
