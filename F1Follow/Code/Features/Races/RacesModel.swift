//
//  RacesModel.swift
//  F1Follow
//
//  Created by Emanuel on 19/07/24.
//

import Foundation


struct DriverPosition: Codable {
    var position: Int
    let driverNumber: Int
    let date: String
    let sessionKey, meetingKey: Int

    enum CodingKeys: String, CodingKey {
        case position
        case driverNumber = "driver_number"
        case date
        case sessionKey = "session_key"
        case meetingKey = "meeting_key"
    }
}
