//
//  RacesModel.swift
//  F1Follow
//
//  Created by Emanuel on 19/07/24.
//

import Foundation


//struct DriverPosition: Codable {
//    var position: Int
//    let driverNumber: Int
//    let date: String
//    let sessionKey, meetingKey: Int
//
//    enum CodingKeys: String, CodingKey {
//        case position
//        case driverNumber = "driver_number"
//        case date
//        case sessionKey = "session_key"
//        case meetingKey = "meeting_key"
//    }
//}
//
//class DriverPositionClass: ObservableObject, Codable {
//    @Published var position: Int
//    let driverNumber: Int
//    let date: String
//    let sessionKey, meetingKey: Int
//
//    enum CodingKeys: String, CodingKey {
//        case position
//        case driverNumber = "driver_number"
//        case date
//        case sessionKey = "session_key"
//        case meetingKey = "meeting_key"
//    }
//    
//    func encode(to encoder: any Encoder) throws {
//        
//    }
//    
//    required init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        
//        position = try container.decode(Int.self, forKey: .position)
//        driverNumber = try container.decode(Int.self, forKey: .driverNumber)
//        date = try container.decode(String.self, forKey: .date)
//        sessionKey = try container.decode(Int.self, forKey: .sessionKey)
//        meetingKey = try container.decode(Int.self, forKey: .meetingKey)
//    }
//}
//
//class Lap: ObservableObject, Codable {
//    let driverNumber: Int
//    let dateStart: Date?
//    let isPitOutLap: Bool
//    let durationSector1, durationSector2, durationSector3: Double?
//    let lapNumber: Int
//    @Published var duration: Double = 0
//    let endLap: Bool
//
//    enum CodingKeys: String, CodingKey {
//        case driverNumber = "driver_number"
//        case dateStart = "date_start"
//        case isPitOutLap = "is_pit_out_lap"
//        case durationSector1 = "duration_sector_1"
//        case durationSector2 = "duration_sector_2"
//        case durationSector3 = "duration_sector_3"
//        case lapNumber = "lap_number"
//    }
//    
//    func totalTime() -> Double {
//        (durationSector1 ?? 0) + (durationSector2 ?? 0) + (durationSector3 ?? 0)
//    }
//    
//    required init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        
//        driverNumber = try container.decode(Int.self, forKey: .driverNumber)
//        isPitOutLap = try container.decode(Bool.self, forKey: .isPitOutLap)
//        
//        let dateString = try container.decode(String.self, forKey: .dateStart)
//        let dateFormatter = ISO8601DateFormatter()
//        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
//        dateStart = dateFormatter.date(from: dateString)
//        
//        durationSector1 = try container.decode(Double?.self, forKey: .durationSector1)
//        durationSector2 = try container.decode(Double?.self, forKey: .durationSector2)
//        durationSector3 = try container.decode(Double?.self, forKey: .durationSector3)
//        lapNumber = try container.decode(Int.self, forKey: .driverNumber)
//        endLap = (durationSector1 != nil && durationSector2 != nil && durationSector3 != nil)
//    }
//}

class Driver: ObservableObject, Codable {
    let driverNumber: Int
    let lastName: String
    let teamColour: String
    @Published var position: Int = 0

    enum CodingKeys: String, CodingKey {
        case driverNumber = "driver_number"
        case lastName = "last_name"
        case teamColour = "team_colour"
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.driverNumber = try container.decode(Int.self, forKey: .driverNumber)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.teamColour = try container.decode(String.self, forKey: .teamColour)
    }
}
