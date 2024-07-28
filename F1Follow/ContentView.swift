//
//  ContentView.swift
//  F1Follow
//
//  Created by Emanuel on 19/07/24.
//

import SwiftUI


struct ContentView: View {
    @State var year: Int = 2024
//    @State var meetings: [Meeting] = [
//        Meeting(circuitKey: 1, circuitShortName: "Monza", countryCode: "IT", countryKey: 39, location: "Monza, Italy", meetingKey: 101, meetingOfficialName: "Italian Grand Prix", year: 2024),
//        Meeting(circuitKey: 2, circuitShortName: "Silverstone", countryCode: "GB", countryKey: 44, location: "Silverstone, UK", meetingKey: 102, meetingOfficialName: "British Grand Prix", year: 2024),
//        Meeting(circuitKey: 3, circuitShortName: "Spa", countryCode: "BE", countryKey: 32, location: "Spa, Belgium", meetingKey: 103, meetingOfficialName: "Belgian Grand Prix", year: 2024),
//        Meeting(circuitKey: 4, circuitShortName: "Suzuka", countryCode: "JP", countryKey: 81, location: "Suzuka, Japan", meetingKey: 104, meetingOfficialName: "Japanese Grand Prix", year: 2024),
//        Meeting(circuitKey: 5, circuitShortName: "Interlagos", countryCode: "BR", countryKey: 55, location: "São Paulo, Brazil", meetingKey: 105, meetingOfficialName: "Brazilian Grand Prix", year: 2024)
//    ]
    @State var meetings: [Meeting] = []
    
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
                if meetings.count > 0 {
                    ScrollView {
                        VStack(alignment: .leading) {
                            ForEach(Array(zip(meetings.indices, meetings)), id: \.1.circuitKey) { c, meeting in
                                NavigationLink {
                                    MeetingsView(meeting: meeting)
                                } label: {
                                    MeetingCard(meeting: meeting, round: c+1)
                                }
                                .tint(.primary)
                            }
                        }
                    }
                } else {
                    Spacer()
                        .frame(maxWidth: .infinity)
                        .overlay(alignment: .center) {
                            ProgressView()
                        }
                }
            }
        }
        .monospaced()
        .onChange(of: year, { oldValue, newValue in
            self.meetings = []
            fetch(link: "https://api.openf1.org/v1/meetings?year=\(year)", type: [Meeting].self) { meetings in
                self.meetings = meetings
            }
        })
        .onAppear {
            fetch(link: "https://api.openf1.org/v1/meetings?year=\(year)", type: [Meeting].self) { meetings in
                self.meetings = meetings
            }
        }
    }
}

#Preview {
    ContentView()
}
