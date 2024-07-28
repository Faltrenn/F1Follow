//
//  RacesView.swift
//  F1Follow
//
//  Created by Emanuel on 19/07/24.
//

import SwiftUI


struct DriverCard: View {
    @ObservedObject var driver: Driver
    @State var liveTime: Double = 0
    @State var showInfo = false
    let liveTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
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
                Text(driver.lastName)
                    .bold()
                    .font(.title2)
                Spacer()
                if let lap = driver.bestLap {
                    Text(lap.lapDuration!.lapTime())
                        .font(.title2)
                }
                Rectangle()
                    .fill(Color(red: 16/255, green: 25/255, blue: 26/255))
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
                    if let lap = driver.lastLap {
                        Text(lap.isPitOutLap ? "OUT LAP" : liveTime.lapTime())
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
                            .foregroundStyle(driver.sectors[0]?.color ?? .gray)
                            .frame(height: 5)
                    }
                    VStack(spacing: 4) {
                        Text("S2")
                        Rectangle()
                            .foregroundStyle(driver.sectors[1]?.color ?? .gray)
                            .frame(height: 5)
                    }
                    VStack(spacing: 4) {
                        Text("S3")
                        Rectangle()
                            .foregroundStyle(driver.sectors[2]?.color ?? .gray)
                            .frame(height: 5)
                    }
                }
            }
        }
        .background(Color(red: 21/255, green: 20/255, blue: 30/255))
        .onReceive(liveTimer, perform: { _ in
            if showInfo, let lastLap = driver.lastLap {
                liveTime = lastLap.lapLiveTime() ?? 0
            }
        })
    }
}

struct RacesView: View {
    @ObservedObject var racesVM = RacesViewModel(session: "latest")
    let refreshTimer = Timer.publish(every: 5.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(racesVM.drivers, id: \.driverNumber) { driver in
                    DriverCard(driver: driver)
                }
            }
            .background(Color(red: 34/255, green: 34/255, blue: 43/255))
        }
        .preferredColorScheme(.dark)
        .onReceive(refreshTimer, perform: { _ in
            racesVM.sortDrivers()
            racesVM.refreshDriverLaps()
        })
    }
}

//#Preview {
//    ContentView(page: .races)
//}
