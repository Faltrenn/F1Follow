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
    let driver: Driver
    @State var showInfo = false
    
    var body: some View {
        VStack {
            HStack {
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(.clear)
                        .aspectRatio(1, contentMode: .fit)
                        .fixedSize(horizontal: true, vertical: false)
                        .overlay {
                            Text("\(driver.position)")
                                .monospaced()
                        }
                    Rectangle()
                        .fill(Color(hex: driver.teamColour))
                        .aspectRatio(1, contentMode: .fit)
                        .fixedSize(horizontal: true, vertical: false)
                }
                Text(driver.nameAcronym)
                    .bold()
                    .font(.title2)
                Spacer()
                if let lap = driver.fastestLap {
                    Text(lap.totalTime().lapTime())
                        .font(.title2)
                }
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
                    if let lLap = driver.lastLap {
                        Text(lLap.totalTime().lapTime())
                            .bold()
                            .font(.title)
                    }
                    Spacer()
//                    VStack {
//                        Text("1:0:0")
//                            .bold()
//                            .font(.title3)
//                        Text("Sainz")
//                    }
//                    Spacer()
                }
                HStack(spacing: 2) {
                    VStack(spacing: 4) {
                        Text("S1")
                        Rectangle()
//                            .foregroundStyle(driver.sector1?.color ?? .gray)
                            .frame(height: 5)
                    }
                    VStack(spacing: 4) {
                        Text("S2")
                        Rectangle()
//                            .foregroundStyle(driver.sector2?.color ?? .gray)
                            .frame(height: 5)
                    }
                    VStack(spacing: 4) {
                        Text("S3")
                        Rectangle()
//                            .foregroundStyle(driver.sector3?.color ?? .gray)
                            .frame(height: 5)
                    }
                }
            }
        }
        .background(Color(red: 21/255, green: 20/255, blue: 30/255))
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
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(racesVM.drivers, id: \.driverNumber) { driver in
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
