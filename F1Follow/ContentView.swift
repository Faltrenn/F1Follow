//
//  ContentView.swift
//  F1Follow
//
//  Created by Emanuel on 19/07/24.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var gps: [GP] = [
            GP(circuitKey: 1, circuitShortName: "Monza", countryCode: "IT", countryKey: 39, location: "Monza, Italy", meetingKey: 101, meetingOfficialName: "Italian Grand Prix", year: 2024),
            GP(circuitKey: 2, circuitShortName: "Silverstone", countryCode: "GB", countryKey: 44, location: "Silverstone, UK", meetingKey: 102, meetingOfficialName: "British Grand Prix", year: 2024),
            GP(circuitKey: 3, circuitShortName: "Spa", countryCode: "BE", countryKey: 32, location: "Spa, Belgium", meetingKey: 103, meetingOfficialName: "Belgian Grand Prix", year: 2024),
            GP(circuitKey: 4, circuitShortName: "Suzuka", countryCode: "JP", countryKey: 81, location: "Suzuka, Japan", meetingKey: 104, meetingOfficialName: "Japanese Grand Prix", year: 2024),
            GP(circuitKey: 5, circuitShortName: "Interlagos", countryCode: "BR", countryKey: 55, location: "São Paulo, Brazil", meetingKey: 105, meetingOfficialName: "Brazilian Grand Prix", year: 2024)
        ]
    
    var year: Int = 0
    
    func start(year: Int) {
        self.year = year
        fetch(link: String(format: "https://api.openf1.org/v1/meetings?year=%d", year), type: [GP].self) { gps in
            self.gps = gps
        }
    }
}

struct GP: Codable {
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

struct ContentView: View {
    @State var year: Int = 2024
    @ObservedObject var cVM = ContentViewModel()
    
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
                        ForEach(Array(zip(cVM.gps.indices, cVM.gps)), id: \.1.circuitKey) { c, gp in
                            NavigationLink {
                            } label: {
                                VStack(alignment: .leading) {
                                    Text("ROUND \(c+1)")
                                        .font(.subheadline)
                                        .foregroundStyle(.red)
                                    Text(gp.circuitShortName)
                                        .font(.title2)
                                        .bold()
                                    Text(gp.meetingOfficialName)
                                }
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
