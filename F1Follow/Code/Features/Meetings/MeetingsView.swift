//
//  MeetingsView.swift
//  F1Follow
//
//  Created by Emanuel on 28/07/24.
//

import SwiftUI

struct MeetingCard: View {
    let meeting: Meeting
    let round: Int
    var body: some View {
        VStack(alignment: .leading) {
            Text("ROUND \(round)")
                .font(.subheadline)
                .foregroundStyle(.red)
            Text(meeting.circuitShortName)
                .font(.title2)
                .bold()
            Text(meeting.meetingOfficialName)
        }
    }
}

struct MeetingsView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    MeetingsView()
}
