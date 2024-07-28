//
//  ContentView.swift
//  F1Follow
//
//  Created by Emanuel on 19/07/24.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var gps: [Meeting] = [
        Meeting(circuitKey: 1, circuitShortName: "Monza", countryCode: "IT", countryKey: 39, location: "Monza, Italy", meetingKey: 101, meetingOfficialName: "Italian Grand Prix", year: 2024),
        Meeting(circuitKey: 2, circuitShortName: "Silverstone", countryCode: "GB", countryKey: 44, location: "Silverstone, UK", meetingKey: 102, meetingOfficialName: "British Grand Prix", year: 2024),
        Meeting(circuitKey: 3, circuitShortName: "Spa", countryCode: "BE", countryKey: 32, location: "Spa, Belgium", meetingKey: 103, meetingOfficialName: "Belgian Grand Prix", year: 2024),
        Meeting(circuitKey: 4, circuitShortName: "Suzuka", countryCode: "JP", countryKey: 81, location: "Suzuka, Japan", meetingKey: 104, meetingOfficialName: "Japanese Grand Prix", year: 2024),
        Meeting(circuitKey: 5, circuitShortName: "Interlagos", countryCode: "BR", countryKey: 55, location: "São Paulo, Brazil", meetingKey: 105, meetingOfficialName: "Brazilian Grand Prix", year: 2024)
    ]
    
    var year: Int = 0
    
    func start(year: Int) {
        self.year = year
        fetch(link: String(format: "https://api.openf1.org/v1/meetings?year=%d", year), type: [Meeting].self) { gps in
            self.gps = gps
        }
    }
}

struct ContentView: View {
    @State var year: Int = 2024
    @State var gps: [Meeting] = [
        Meeting(circuitKey: 1, circuitShortName: "Monza", countryCode: "IT", countryKey: 39, location: "Monza, Italy", meetingKey: 101, meetingOfficialName: "Italian Grand Prix", year: 2024),
        Meeting(circuitKey: 2, circuitShortName: "Silverstone", countryCode: "GB", countryKey: 44, location: "Silverstone, UK", meetingKey: 102, meetingOfficialName: "British Grand Prix", year: 2024),
        Meeting(circuitKey: 3, circuitShortName: "Spa", countryCode: "BE", countryKey: 32, location: "Spa, Belgium", meetingKey: 103, meetingOfficialName: "Belgian Grand Prix", year: 2024),
        Meeting(circuitKey: 4, circuitShortName: "Suzuka", countryCode: "JP", countryKey: 81, location: "Suzuka, Japan", meetingKey: 104, meetingOfficialName: "Japanese Grand Prix", year: 2024),
        Meeting(circuitKey: 5, circuitShortName: "Interlagos", countryCode: "BR", countryKey: 55, location: "São Paulo, Brazil", meetingKey: 105, meetingOfficialName: "Brazilian Grand Prix", year: 2024)
        ]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                VStack {
                    Text("Year")
                    Picker("Ano", selection: $year) {
                        ForEach(2023...2024, id: \.self) { y in
                            Text(String(format: "%d", y))
                        }
                    }
                    .pickerStyle(.segmented)
                }
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(Array(zip(gps.indices, gps)), id: \.1.circuitKey) { c, gp in
                            NavigationLink {
                                @State var sessions: [Session] = [
                                        Session(dateStart: Date(), sessionKey: 201, sessionName: "Practice 1", sessionType: "Practice"),
                                        Session(dateStart: Date(), sessionKey: 202, sessionName: "Practice 2", sessionType: "Practice"),
                                        Session(dateStart: Date(), sessionKey: 203, sessionName: "Practice 3", sessionType: "Practice"),
                                        Session(dateStart: Date(), sessionKey: 204, sessionName: "Qualifying", sessionType: "Qualifying"),
                                        Session(dateStart: Date(), sessionKey: 205, sessionName: "Race", sessionType: "Race")
                                    ]
                                VStack(alignment: .leading) {
                                    ForEach(sessions, id: \.sessionKey) { session in
                                        NavigationLink {
                                            Text("boa")
                                        } label: {
                                            SessionCard(session: session)
                                        }
                                    }
                                }
                                .onAppear {
                                    
                                }
                            } label: {
                                MeetingCard(meeting: gp, round: c+1)
                            }
                            .tint(.primary)
                        }
                    }
                }
            }
        }
        .monospaced()
//        .onAppear {
//            cVM.start(year: year)
//        }
//        .onChange(of: year) { oldValue, newValue in
//            cVM.start(year: newValue)
//        }
    }
}

#Preview {
    ContentView()
}
