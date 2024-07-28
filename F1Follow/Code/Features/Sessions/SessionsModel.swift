//
//  SessionsModel.swift
//  F1Follow
//
//  Created by Emanuel on 28/07/24.
//

import Foundation

struct Session: Codable {
    let dateStart: String
    let sessionKey: Int
    let sessionName, sessionType: String

    enum CodingKeys: String, CodingKey {
        case dateStart = "date_start"
        case sessionKey = "session_key"
        case sessionName = "session_name"
        case sessionType = "session_type"
    }
}
