//
//  RacesView.swift
//  F1Follow
//
//  Created by Emanuel on 19/07/24.
//

import SwiftUI

struct RacesView: View {
    @ObservedObject var racesVM = RacesViewModel(session: "latest")
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack {
                        ForEach(racesVM.driverPositions, id: \.driverNumber) { dp in
                            if let driver = racesVM.getDriverByNumber(number: dp.driverNumber) {
                                VStack {
                                    HStack {
                                        Text("\(dp.position)")
                                        Text(driver.nameAcronym)
                                    }
                                    if let lap = racesVM.laps.first(where: { $0.driverNumber == driver.driverNumber}), !lap.isPitOutLap{
                                        VStack {
                                            Text("Sector 1: \((lap.durationSector1 ?? 0).lapTime)")
                                            Text("Sector 2: \((lap.durationSector2 ?? 0).lapTime)")
                                            Text("Sector 3: \((lap.durationSector3 ?? 0).lapTime)")
                                            Text("Total: \(lap.totalTime().lapTime)")
                                            Text("Total: \(Date().timeIntervalSince(lap.dateStart!).lapTime)")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .font(.title)
        .monospaced()
    }
}

#Preview {
    ContentView(page: .races)
}
