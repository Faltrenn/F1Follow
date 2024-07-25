//
//  RacesView.swift
//  F1Follow
//
//  Created by Emanuel on 19/07/24.
//

import SwiftUI

struct RacesView: View {
    @ObservedObject var racesVM = RacesViewModel(session: "latest")
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    ForEach(racesVM.driverPositions, id: \.driverNumber) { dp in
                        if let driver = racesVM.getDriverByNumber(number: dp.driverNumber) {
                            HStack {
                                Text("\(dp.position)")
                                Text(driver.nameAcronym)
                            }
                        }
                    }
                }
            }
            Button("Final") {
                racesVM.endRace()
            }
        }
        .font(.title)
        .monospaced()
        .onReceive(timer, perform: { _ in
            racesVM.testFetch()
        })
    }
}

#Preview {
    ContentView(page: .races)
}
