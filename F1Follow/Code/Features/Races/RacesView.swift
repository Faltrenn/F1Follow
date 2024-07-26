//
//  RacesView.swift
//  F1Follow
//
//  Created by Emanuel on 19/07/24.
//

import SwiftUI

extension Color {
    static var random: Color {
        Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    }
}

struct DriverCard: View {
    let driver: DriverTest
    @State var showInfo = false
    
    var body: some View {
        VStack {
            HStack {
                HStack(spacing: 0) {
                    Text("1")
                        .padding(.horizontal, 10)
                    Rectangle()
                        .fill(Color.random)
                        .aspectRatio(1, contentMode: .fit)
                        .fixedSize(horizontal: true, vertical: false)
                }
                Text(driver.name.uppercased())
                    .bold()
                    .font(.title2)
                Spacer()
                Text("1:32:450")
                    .font(.title2)
                Rectangle()
                    .aspectRatio(1, contentMode: .fit)
                    .fixedSize(horizontal: true, vertical: false)
                    .overlay {
                        Text("S")
                            .bold()
                            .foregroundStyle(.red)
                    }
            }
            .background(Color(red: 34/255, green: 34/255, blue: 43/255))
            .onTapGesture {
                withAnimation {
                    showInfo.toggle()
                }
            }
            if showInfo {
                HStack {
                    Spacer()
                    Text(driver.timeNow.lapTime(minimum: true))
                        .bold()
                        .font(.title)
                    Spacer()
                    VStack {
                        Text(driver.timeOfNextPilot.lapTime())
                            .bold()
                            .font(.title3)
                        Text("Sainz")
                    }
                    Spacer()
                }
                HStack(spacing: 2) {
                    VStack {
                        Text("S1")
                        Rectangle()
                            .foregroundStyle(driver.sector1?.color ?? .gray)
                            .frame(height: 5)
                    }
                    VStack {
                        Text("S2")
                        Rectangle()
                            .foregroundStyle(driver.sector2?.color ?? .gray)
                            .frame(height: 5)
                    }
                    VStack {
                        Text("S3")
                        Rectangle()
                            .foregroundStyle(driver.sector3?.color ?? .gray)
                            .frame(height: 5)
                    }
                }
            }
        }
        .background(Color(red: 21/255, green: 20/255, blue: 30/255))
    }
}

enum Sectors {
    case yellow, green, purple
    var color: Color {
        switch self {
        case .yellow:
            Color.yellow
        case .green:
            Color.green
        case .purple:
            Color.purple
        }
    }
}

struct DriverTest {
    let name: String
    let sector1: Sectors?
    let sector2: Sectors?
    let sector3: Sectors?
    let timeNow: Double
    let timeOfNextPilot: Double
}

struct RacesView: View {
    @ObservedObject var racesVM = RacesViewModel(session: "latest")
    
    let drivers = [
            DriverTest(name: "VER", sector1: .green, sector2: .purple, sector3: nil, timeNow: 48.678, timeOfNextPilot: 48.890),
            DriverTest(name: "HAM", sector1: .yellow, sector2: .green, sector3: .purple, timeNow: 48.890, timeOfNextPilot: 48.456),
            DriverTest(name: "LEC", sector1: .purple, sector2: .yellow, sector3: .green, timeNow: 48.456, timeOfNextPilot: 48.567),
            DriverTest(name: "RIC", sector1: .green, sector2: nil, sector3: nil, timeNow: 48.567, timeOfNextPilot: 48.789),
            DriverTest(name: "NOR", sector1: .yellow, sector2: .green, sector3: .purple, timeNow: 48.789, timeOfNextPilot: 48.890),
            DriverTest(name: "BOT", sector1: .green, sector2: .purple, sector3: .yellow, timeNow: 48.567, timeOfNextPilot: 48.678),
            DriverTest(name: "SAI", sector1: .yellow, sector2: .green, sector3: .purple, timeNow: 48.890, timeOfNextPilot: 48.123),
            DriverTest(name: "GAS", sector1: .purple, sector2: .yellow, sector3: .green, timeNow: 48.123, timeOfNextPilot: 48.234),
            DriverTest(name: "ALB", sector1: .green, sector2: nil, sector3: .yellow, timeNow: 48.234, timeOfNextPilot: 48.345),
            DriverTest(name: "TSU", sector1: .yellow, sector2: .green, sector3: .purple, timeNow: 48.345, timeOfNextPilot: 48.456),
            DriverTest(name: "OCO", sector1: .purple, sector2: .yellow, sector3: .green, timeNow: 48.456, timeOfNextPilot: 48.567),
            DriverTest(name: "STR", sector1: .green, sector2: .purple, sector3: nil, timeNow: 48.567, timeOfNextPilot: 48.678),
            DriverTest(name: "MAZ", sector1: .yellow, sector2: .green, sector3: .purple, timeNow: 48.678, timeOfNextPilot: 48.789),
            DriverTest(name: "SCH", sector1: .green, sector2: .purple, sector3: .yellow, timeNow: 48.789, timeOfNextPilot: 48.890),
            DriverTest(name: "LAT", sector1: .purple, sector2: .yellow, sector3: .green, timeNow: 48.890, timeOfNextPilot: 49.123),
            DriverTest(name: "ZHO", sector1: .purple, sector2: .yellow, sector3: .green, timeNow: 48.890, timeOfNextPilot: 49.123),
            DriverTest(name: "HUL", sector1: .purple, sector2: .yellow, sector3: .green, timeNow: 48.890, timeOfNextPilot: 49.123),
            DriverTest(name: "ALO", sector1: .purple, sector2: .yellow, sector3: .green, timeNow: 48.890, timeOfNextPilot: 49.123),
            DriverTest(name: "PIA", sector1: .purple, sector2: .yellow, sector3: .green, timeNow: 48.890, timeOfNextPilot: 49.123),
            DriverTest(name: "EMA", sector1: .purple, sector2: .yellow, sector3: .green, timeNow: 48.890, timeOfNextPilot: 49.123),
        ]
    
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(drivers, id: \.name) { driver in
                    DriverCard(driver: driver)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView(page: .races)
}
