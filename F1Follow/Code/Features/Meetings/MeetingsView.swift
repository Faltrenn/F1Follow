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
                .multilineTextAlignment(.leading)
        }
    }
}

struct MeetingsView: View {
    @State var sessions: [Session] = []
    let meeting: Meeting
    
    var body: some View {
        VStack(alignment: .leading) {
            if sessions.count > 0 {
                ForEach(sessions, id: \.sessionKey) { session in
                    NavigationLink {
                        SessionsView(session: "\(session.sessionKey)")
                    } label: {
                        SessionCard(session: session)
                    }
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            fetch(link: String(format: "https://api.openf1.org/v1/sessions?meeting_key=%d", meeting.meetingKey), type: [Session].self) { sessions in
                self.sessions = sessions.reversed()
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
