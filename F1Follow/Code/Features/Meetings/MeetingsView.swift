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
    @State var sessions: [Session] = [
        Session(dateStart: Date(), sessionKey: 201, sessionName: "Practice 1", sessionType: "Practice"),
        Session(dateStart: Date(), sessionKey: 202, sessionName: "Practice 2", sessionType: "Practice"),
        Session(dateStart: Date(), sessionKey: 203, sessionName: "Practice 3", sessionType: "Practice"),
        Session(dateStart: Date(), sessionKey: 204, sessionName: "Qualifying", sessionType: "Qualifying"),
        Session(dateStart: Date(), sessionKey: 205, sessionName: "Race", sessionType: "Race")
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(sessions, id: \.sessionKey) { session in
                NavigationLink {
                    SessionsView(session: "\(session.sessionKey)")
                } label: {
                    SessionCard(session: session)
                }
            }
        }
        .onAppear {
            
        }
    }
}

#Preview {
    NavigationStack {
        MeetingsView()
    }
}
