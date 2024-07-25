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

class DriverPositionClass: ObservableObject, Codable {
    @Published var position: Int
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
    
    func encode(to encoder: any Encoder) throws {
        
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        position = try container.decode(Int.self, forKey: .position)
        driverNumber = try container.decode(Int.self, forKey: .driverNumber)
        date = try container.decode(String.self, forKey: .date)
        sessionKey = try container.decode(Int.self, forKey: .sessionKey)
        meetingKey = try container.decode(Int.self, forKey: .meetingKey)
    }
}
